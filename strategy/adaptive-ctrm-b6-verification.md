---
title: B6 verification — Blueprint versioning
updated: 2026-04-21
owner: sozturk
status: draft
related:
  - adaptive-ctrm-gap-analysis.md
  - adaptive-ctrm-gap-analysis-v2.md
---

# B6 verification — Blueprint versioning

**Original claim (v1 Section 3 / v2 B6):** "no blueprint tables, no ASL alias versioning, no snapshot store, no migration executor."

Evidence pass, same rigour demanded as the B1 correction.

---

## 1. Filename search in `src/resolvers/` for `blueprint` / `version`

Search: grep `-i` for `blueprint|version` in file contents under [src/resolvers/](../../../trackon-aws-backend/src/resolvers/).

No filename contains `blueprint`. No filename contains `version`. Hits on the pattern come from unrelated word uses (e.g. `conversion`, `overseas`, `oversight`, `Version` inside strings). Relevant content matches:

| File | Use of the term |
|---|---|
| [resolvers/generate_report.py](../../../trackon-aws-backend/src/resolvers/generate_report.py) | "version" in docx lib API docs, not versioning logic |
| [resolvers/tenant_data_exporter.py](../../../trackon-aws-backend/src/resolvers/tenant_data_exporter.py) | dumps tenant metadata to S3; no version number, just an overwrite |
| [resolvers/vtl/*.vtl](../../../trackon-aws-backend/src/resolvers/vtl/) | `$util.autoId()`, `$util.time.nowISO8601()` — coincidental |
| [resolvers/update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py) | prints "environment" string, not a version |
| others | noise (conversion, override, overseas …) |

**No resolver named `*blueprint*`, `*version*`, `*snapshot*`, `*diff*`, or `*rollback*` exists.**

---

## 2. DynamoDB table / SK-pattern search for versioning

Search: grep for `VERSION#|SNAPSHOT#|HISTORY#` across the backend repo.

```
src/graphql/entity/metadata.json:38860    "skFormula": "METADATA_HISTORY#{id}"
src/graphql/entity/metadata.json:43675    "skFormula": "PROFITABILITY_SNAPSHOT#{id}"
```

Two entities in the shared metadata catalogue have version-adjacent SK patterns:

- **`METADATA_HISTORY`** — stores per-tenant metadata change records (see section 3).
- **`PROFITABILITY_SNAPSHOT`** — stores per-entity-computation profitability snapshots; business data, not configuration versioning.

[templates/cloudformation.yaml:514-605](../../../trackon-aws-backend/templates/cloudformation.yaml#L514-L605) — the universal DDB table has no version-aware GSI; all 6 GSIs use generic `PK1/SK1 … PK6/SK6` with the stream set to `NEW_AND_OLD_IMAGES`, which is the source of the changelog (data, not config).

[templates/tenant-template.yaml:608](../../../trackon-aws-backend/templates/tenant-template.yaml#L608) and [:1307](../../../trackon-aws-backend/templates/tenant-template.yaml#L1307) — **S3 bucket `VersioningConfiguration: Status: Enabled`** is set on the tenant data bucket and the athena bucket. Raw S3 object versioning exists (off-site backup of any file dropped there), but nothing above it queries or diffs the S3 object versions.

[README.md:37-38](../../../trackon-aws-backend/README.md#L37-L38) — "SnapStart + AutoPublishAlias create a new version on every deploy" — Lambda functions auto-publish versions behind a `live` alias (see [templates/cloudformation.yaml:305](../../../trackon-aws-backend/templates/cloudformation.yaml#L305): `AutoPublishAlias: live`). **Lambda-level aliasing is in use.** Step-Functions-level aliasing is not.

---

## 3. METADATA_HISTORY flow — created, written, read, scope

### Where the entity itself is declared

[src/graphql/entity/metadata.json:38672-38870](../../../trackon-aws-backend/src/graphql/entity/metadata.json#L38672-L38870):

```json
{
  "entityName": "METADATA_HISTORY",
  "attributes": {
    "id":                    { "Type": "S", "immutable": true, "required": true },
    "tenantId":              { "Type": "S", "immutable": true, "required": true },
    "entityName":            { "Type": "S", "immutable": true, "required": true },
    "transactionTimestamp":  { "Type": "S", "immutable": true, "required": true },
    "metadataJson":          { "Type": "S", "immutable": true, "required": true },
    "attributesCount":       { "Type": "N", "immutable": true, "required": false },
    "attributes":            { "Type": "S", "immutable": true, "required": false },
    "IDGeneration":          { "Type": "S", "immutable": true, "required": false },
    "pkFormula":             { "Type": "S", "immutable": true, "required": false },
    "skFormula":             { "Type": "S", "immutable": true, "required": false },
    "pk1Formula":            { "Type": "S", "immutable": true, "required": false },
    "sk1Formula":            { "Type": "S", "immutable": true, "required": false },
    "pk2Formula":            { "Type": "S", "immutable": true, "required": false },
    "sk2Formula":            { "Type": "S", "immutable": true, "required": false },
    "pk3Formula":            { "Type": "S", "immutable": true, "required": false },
    "sk3Formula":            { "Type": "S", "immutable": true, "required": false },
    "entityParameters":      { "Type": "S", "immutable": true, "required": false },
    "entityStates":          { "Type": "S", "immutable": true, "required": false },
    "workflowTriggers":      { "Type": "S", "immutable": true, "required": false },
    "referentialConstraints":{ "Type": "S", "immutable": true, "required": false },
    "detailEntities":        { "Type": "S", "immutable": true, "required": false },
    "extractionPrompt":      { "Type": "S", "immutable": true, "required": false }
  },
  "IDGeneration": { "Attribute": "id", "Method": "UUID" },
  "entityParameters": { "useStatus": false, "editOnDefinitions": false },
  "pkFormula":  "T#{tenantId}#METADATA_HISTORY",
  "skFormula":  "METADATA_HISTORY#{id}",
  "pk1Formula": "T#{tenantId}#METADATA_HISTORY",
  "sk1Formula": "TIMESTAMP#{transactionTimestamp}",
  "entityStates": {
    "Default": { "deleteAllowed": false, "queryAllowed": true, "updateAllowed": false, "insertAllowed": true }
  }
}
```

Notes:
- GSI1 key `TIMESTAMP#{transactionTimestamp}` — time-ordered queries work out of the box.
- `updateAllowed: false`, `deleteAllowed: false` — append-only by policy.
- Every field on the source entity metadata has a mirror attribute here.

### What writes to it

Only [resolvers/create_entity_metadata.py](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py) calls `record_to_history()`. Quoted — [create_entity_metadata.py:20-78](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L20-L78):

```python
def record_to_history(tenant_id, metadata, original_identity):
    """Record metadata creation to METADATA_HISTORY. Fail-safe - never throws."""
    try:
        logger.info(f"record_to_history called for entity: {metadata['entityName']}")

        if not CREATE_ENTITY_FUNCTION_ARN:
            logger.warning(
                "CREATE_ENTITY_FUNCTION_ARN not set, skipping history recording"
            )
            return

        history_data = {
            "tenantId": tenant_id,
            "entityName": metadata["entityName"],
            "transactionTimestamp": utc_now_iso(),
            "metadataJson": json.dumps(metadata),
            "attributesCount": len(metadata.get("attributes", {})),
            "attributes": json.dumps(metadata.get("attributes", {})),
            "IDGeneration": json.dumps(metadata.get("IDGeneration", {})),
            "pkFormula":   metadata.get("pkFormula", ""),
            "skFormula":   metadata.get("skFormula", ""),
            "pk1Formula":  metadata.get("pk1Formula", ""),
            "sk1Formula":  metadata.get("sk1Formula", ""),
            "pk2Formula":  metadata.get("pk2Formula", ""),
            "sk2Formula":  metadata.get("sk2Formula", ""),
            "pk3Formula":  metadata.get("pk3Formula", ""),
            "sk3Formula":  metadata.get("sk3Formula", ""),
            "entityParameters":      json.dumps(metadata.get("entityParameters", {})),
            "entityStates":          json.dumps(metadata.get("entityStates", {})),
            "workflowTriggers":      json.dumps(metadata.get("workflowTriggers", {})),
            "referentialConstraints":json.dumps(metadata.get("referentialConstraints", {})),
            "detailEntities":        json.dumps(metadata.get("detailEntities", {})),
            "extractionPrompt":      metadata.get("extractionPrompt", ""),
        }

        payload = {
            "arguments": {
                "tenantId": tenant_id,
                "entityName": "METADATA_HISTORY",
                "data": history_data,
            },
            "identity": original_identity,
        }

        response = invoke_lambda(CREATE_ENTITY_FUNCTION_ARN, payload, lambda_client)
        if response and response.get("success"):
            logger.info(f"Successfully recorded metadata history: {response.get('id')}")
        else:
            logger.warning(f"Failed to record metadata history: {response}")

    except Exception as e:
        logger.warning(f"Error recording metadata history: {e}")
        pass
```

Called from [create_entity_metadata.py:171-173](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L171-L173):

```python
# Record to history (fail-safe) - BEFORE the return statement
logger.info(f"About to record to history for entity: {metadata['entityName']}")
record_to_history(tenant_id, metadata, event.get("identity", {}))
```

**No other resolver writes to METADATA_HISTORY.** Searched for every lambda / resolver; only `create_entity_metadata.py` hits it. In particular neither [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py) / [create_workflow.py](../../../trackon-aws-backend/src/resolvers/create_workflow.py) / [create_report_template.py](../../../trackon-aws-backend/src/resolvers/create_report_template.py) / [update_report_template.py](../../../trackon-aws-backend/src/resolvers/update_report_template.py) nor [avp_operations.py](../../../trackon-aws-backend/src/resolvers/avp_operations.py) records to history.

### What reads from it

Search terms `getMetadataHistory`, `listMetadataHistory`, `MetadataHistoryList`, `METADATA_HISTORY` against the UI repo: **no UI consumers.** The only non-trivial hit outside the backend resolver and its own metadata declaration is in migration tooling ([migrate_hfd_progress.json](../../../trackon-aws-backend/migrate_hfd_progress.json), [migrate_demo_progress.json](../../../trackon-aws-backend/migrate_demo_progress.json), [migrate_afg_progress.json](../../../trackon-aws-backend/migrate_afg_progress.json)) that logs a `metadata_history_log` key — operator-side scripts, not a UI.

However, because `METADATA_HISTORY` is a regular entity with `queryAllowed: true` and a GSI on timestamp, it is **already queryable via the generic `listEntities` API** (no bespoke resolver needed). Nothing in the UI is wired up to surface it.

### Scope of capture

`metadataJson` at [create_entity_metadata.py:35](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L35) is `json.dumps(metadata)` — the entire metadata blob, which *does* include `formLayout`, `tabLayout`, `sideLayout`, and `layouts` if present (since metadata is passed in whole). So for entity metadata specifically, layouts *are* captured.

**What is NOT captured by METADATA_HISTORY:**
- Workflow definitions — updates go through `update_workflow.py`, which writes a new WORKFLOW row via `updateEntity` but never invokes `record_to_history`.
- Report templates — `create_report_template.py` / `update_report_template.py` persist metadata JSON on a `REPORT_TEMPLATE` item but never call `record_to_history`.
- AVP policies — `avp_operations.py` writes to AVP via the AWS SDK; nothing mirrors changes into METADATA_HISTORY.
- Integration mappings (would-be new entity) — none captured.

**Verdict:** METADATA_HISTORY is a **partial, append-only audit log for entity-schema changes only.** Coverage: entity metadata. No coverage for workflows, report templates, AVP policies, integrations.

---

## 4. Step Functions versioning / aliases in `create_workflow.py` and `update_workflow.py`

Searched every invocation of `boto3.client("stepfunctions")`. Results:

### [update_workflow.py:62-98](../../../trackon-aws-backend/src/resolvers/update_workflow.py#L62-L98) (quoted)

```python
def update_state_machine(
    state_machine_definition,
    state_machine_arn,
    account_id,
    tenant_id,
    environment,
    definition_substitutions=None,
):
    client = boto3.client("stepfunctions")

    role_name = f"TenantStepFunctionExecutionRole-{environment}-{tenant_id}"
    role_arn = f"arn:aws:iam::{account_id}:role/{role_name}"
    logger.info(f"Using Role ARN: {role_arn}")

    if definition_substitutions:
        definition_str = json.dumps(state_machine_definition)
        for key, value in definition_substitutions.items():
            definition_str = definition_str.replace(f"${{{key}}}", value)
        definition = definition_str
    else:
        definition = json.dumps(state_machine_definition)

    # Update the state machine
    try:
        client.update_state_machine(
            stateMachineArn=state_machine_arn,
            definition=definition,
            roleArn=role_arn,
        )
    except client.exceptions.StateMachineDoesNotExist:
        raise Exception(f"State machine '{state_machine_arn}' does not exist.")
    except Exception as e:
        logger.error(f"Error updating state machine '{state_machine_arn}': {str(e)}")
        raise e
```

### [create_workflow.py:383-446](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L383-L446) (quoted)

```python
def deploy_state_machine(
    state_machine_definition,
    account_id,
    region,
    tenant_id,
    environment,
    state_machine_name,
    definition_substitutions=None,
):
    client = boto3.client("stepfunctions")

    role_name = f"TenantStepFunctionExecutionRole-{environment}-{tenant_id}"
    role_arn = f"arn:aws:iam::{account_id}:role/{role_name}"
    # ... substitutions elided ...

    existing_state_machine = None
    paginator = client.get_paginator("list_state_machines")
    for page in paginator.paginate():
        for state_machine in page["stateMachines"]:
            if state_machine["name"] == state_machine_name:
                existing_state_machine = state_machine
                break
        if existing_state_machine:
            break

    if existing_state_machine:
        state_machine_arn = existing_state_machine["stateMachineArn"]
        raise ValueError(
            f"A state machine with the name '{state_machine_name}' already exists. "
            f"Use the update functionality with ARN: {state_machine_arn}."
        )

    try:
        response = client.create_state_machine(
            name=state_machine_name, definition=definition, roleArn=role_arn
        )
        state_machine_arn = response["stateMachineArn"]
        ...
    except client.exceptions.StateMachineAlreadyExists:
        state_machine_arn = (
            f"arn:aws:states:{region}:{account_id}:stateMachine:{state_machine_name}"
        )
        raise Exception(
            f"State machine '{state_machine_name}' already exists. Use update instead."
        )

    return state_machine_arn
```

### boto3 calls actually made

Only these four (grep over all of `src/`):

| File | Line | Call |
|---|---|---|
| [create_workflow.py](../../../trackon-aws-backend/src/resolvers/create_workflow.py) | 430 | `client.create_state_machine(name=…, definition=…, roleArn=…)` |
| [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py) | 62 | `def update_state_machine(...)` — internal helper |
| [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py) | 89 | `client.update_state_machine(stateMachineArn=…, definition=…, roleArn=…)` |
| [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py) | 245 | calls the helper |

**No call to `publish_state_machine_version`, `create_state_machine_alias`, `update_state_machine_alias`, or any `StateMachineVersion*` API anywhere in the backend.** Step Functions are updated **in place** every deploy. In-flight executions continue against their original ASL (AWS default behaviour), but there is no app-level versioning, no ability to name two coexisting versions, no cut-over primitive.

Lambda does use aliases — [templates/cloudformation.yaml:305](../../../trackon-aws-backend/templates/cloudformation.yaml#L305): `AutoPublishAlias: live` — so the pattern is present at the Lambda layer but has not been extended to Step Functions.

---

## 5. Config-level diff / compare code

Searched `src/` for `diff|compare|changes_between|ChangeSet`. 27 hits, classified:

- **Data-level changelog** (ignored per instruction): [ddb_streams_changelog.py](../../../trackon-aws-backend/src/lambdas/ddb_streams_changelog.py), [write_changelog.py](../../../trackon-aws-backend/src/lambdas/write_changelog.py), etc. Records row mutations into S3 Tables; not config-level.
- **Business-logic uses of "compare"/"diff"**: [calculate_profitability.py](../../../trackon-aws-backend/src/lambdas/calculate_profitability.py), [link_positions.py](../../../trackon-aws-backend/src/resolvers/link_positions.py), [book_purchase_sale.py](../../../trackon-aws-backend/src/resolvers/book_purchase_sale.py), [load_offload_cargo.py](../../../trackon-aws-backend/src/resolvers/load_offload_cargo.py), [update_entity.py](../../../trackon-aws-backend/src/resolvers/update_entity.py), [update_linking_quantity.py](../../../trackon-aws-backend/src/resolvers/update_linking_quantity.py), [currency_manager.py](../../../trackon-aws-backend/src/utils/currency_manager.py) — all numeric/date comparisons in business code.
- **Validation**: [generate_discrepancy_summary.py](../../../trackon-aws-backend/src/lambdas/generate_discrepancy_summary.py), [auto_resolve_discrepancies.py](../../../trackon-aws-backend/src/lambdas/auto_resolve_discrepancies.py) — compare documents to contracts for DI validation, not config diff.
- **Misc**: [s3tables_manager.py](../../../trackon-aws-backend/src/utils/s3tables_manager.py) — "compare" inside Iceberg schema-evolution helpers (column-type compatibility), not blueprint-level diff.

**No file performs a semantic diff of two versions of an entity definition, workflow definition, screen descriptor, report template, AVP policy, or integration mapping.** A diff engine would be new code.

---

## 6. UI screens for version history / diff / promotion / rollback

Searched [react-ui/src/views/](../../../react-ui/src/views/) for `version|history|rollback|diff|promote` (case-insensitive). 30 file hits, all unrelated:

- `history` → route history (`useNavigate` etc.)
- `version` → Syncfusion component version strings
- `diff` → `e-diff` icon class in grids
- `promote` → not a config promote; it's e.g. promoting a contract to a status
- `rollback` → no hits at all inside UI pages

**No version-list page.** **No diff-view page.** **No promotion wizard.** **No rollback button.** The admin UI under `Administration/` has no tab for configuration history (see B2 verification §1 for the tab inventory).

`METADATA_HISTORY` is queryable via the standard entity API but has zero UI surface.

---

## 7. Revised B6 gap statement

**The original claim is partially refuted.**

What already exists that v1 (and v2) didn't credit:
- **[METADATA_HISTORY](../../../trackon-aws-backend/src/graphql/entity/metadata.json#L38672)** — an append-only, time-indexed audit row per tenant-entity-metadata change, capturing the full `metadataJson` (which includes `formLayout`, `tabLayout`, `sideLayout`, `layouts`). `transactionTimestamp` GSI makes history queries trivial.
- **[tenant_data_exporter.py](../../../trackon-aws-backend/src/resolvers/tenant_data_exporter.py) + [tenant_data_loader.py](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py)** — a primitive snapshot-and-restore of a whole tenant's metadata and templates to/from S3. Export includes layouts.
- **S3 bucket versioning** on the tenant data bucket and athena bucket ([tenant-template.yaml:608](../../../trackon-aws-backend/templates/tenant-template.yaml#L608), [:1307](../../../trackon-aws-backend/templates/tenant-template.yaml#L1307)) — off-site snapshot retention already on.
- **Lambda aliasing + autopublishing** at [cloudformation.yaml:305](../../../trackon-aws-backend/templates/cloudformation.yaml#L305) — the alias pattern is already used at the Lambda layer.

What is still genuinely missing:
- **Step Functions versioning / aliases** — [update_workflow.py:89](../../../trackon-aws-backend/src/resolvers/update_workflow.py#L89) issues in-place `update_state_machine`; no `publish_state_machine_version`, `create_state_machine_alias`, or `update_state_machine_alias` is called anywhere.
- **History for non-entity artefacts** — no record_to_history equivalent for workflow definitions ([create_workflow.py](../../../trackon-aws-backend/src/resolvers/create_workflow.py), [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py)), report templates ([create_report_template.py](../../../trackon-aws-backend/src/resolvers/create_report_template.py), [update_report_template.py](../../../trackon-aws-backend/src/resolvers/update_report_template.py)), AVP policies ([avp_operations.py](../../../trackon-aws-backend/src/resolvers/avp_operations.py)), or integration mappings.
- **Semantic diff engine** — no code compares two snapshots/rows at the config level.
- **Promotion / rollback workflow** — no resolver orchestrates "deploy version N to target env / rollback to N-1".
- **Migration executor** — no forward-only migration handlers for add-field / rename-field / archive-entity etc.
- **UI surface** — version list, diff view, promote wizard, rollback button are all absent.

**Revised effort, building on what exists:**
- Re-use METADATA_HISTORY for entity history (saves ~1 wk of M2 capture work).
- Add `record_to_history`-style shims to [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py), [create_report_template.py](../../../trackon-aws-backend/src/resolvers/create_report_template.py), [update_report_template.py](../../../trackon-aws-backend/src/resolvers/update_report_template.py), [avp_operations.py](../../../trackon-aws-backend/src/resolvers/avp_operations.py) — either extend METADATA_HISTORY to carry a `kind` column or create sibling `WORKFLOW_HISTORY` / `REPORT_TEMPLATE_HISTORY` / `AVP_POLICY_HISTORY` entities of the same shape. ~1.5 wks.
- Step Functions alias flip: add `publish_state_machine_version` + `create_state_machine_alias` on first deploy, `update_state_machine_alias` on promote. ~0.5 wk. Swap ARN construction in [workflow_triggers_service.py:109-121](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L109-L121), [start_workflow.py:77-96](../../../trackon-aws-backend/src/resolvers/start_workflow.py#L77-L96), [create_workflow.py:148-156](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L148-L156), and the substitution blocks in [create_workflow.py:193-252](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L193-L252) / [update_workflow.py:256-308](../../../trackon-aws-backend/src/resolvers/update_workflow.py#L256-L308). ~0.5 wk.
- Lift `tenant_data_exporter` into a versioned snapshot (write to `s3://.../tenants/{id}/{version:010d}.json` rather than overwrite). ~0.5 wk.
- Semantic diff over the history rows + Admin UI for version list / diff view / promote / rollback. ~3 wks.
- Forward-only migration executor for the 9 change types in v2 §5.6. ~3–4 wks.
- E2E drill + buffer. ~1–2 wks.

**Revised blocker effort: ~5–7 dev-weeks (was 9–12 in v2, 13–16 in v1).**

The two-account topology documented in v2 §5.1 still applies and still does the heavy lifting on cross-environment atomicity. What's new in this verification is that the audit-trail skeleton for one of the five artefact types (entity metadata) already exists and works — we should extend it, not redesign it.

**Confidence grade: Partially Confirmed.** "No Step Functions aliasing", "no migration executor", "no diff engine", and "no promotion/rollback UI" all hold. "No blueprint tables / snapshot store" is **Refuted**: METADATA_HISTORY is a blueprint-history table for the dominant artefact type, tenant_data_exporter/loader is a snapshot primitive, and S3 bucket versioning is the off-site store. The effort drops by ~40 % because the hardest design question (how to shape an append-only history row) is already answered and in production.
