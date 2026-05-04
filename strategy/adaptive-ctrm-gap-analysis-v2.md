---
title: TrackonAI Adaptive CTRM Gap Analysis (v2 — corrected)
updated: 2026-04-21
owner: sozturk
status: draft
related:
  - adaptive-ctrm-gap-analysis.md
  - adaptive-ctrm-gap-summary.md
  - products/trackonai/trackonai-roadmap.md
---

# TrackonAI — Adaptive CTRM Gap Analysis, v2

Corrections to [adaptive-ctrm-gap-analysis.md](adaptive-ctrm-gap-analysis.md):

1. **B1 was wrong.** `create_entity_metadata.py` is already an upsert via `put_item` and records to `METADATA_HISTORY` on every call — the resolver *is* the update path. B1 becomes a hardening task, not a missing-feature task.
2. **Blueprint versioning was designed for a single-account world.** The real topology is two AWS accounts (staging + production) with a CI/CD pipeline that already treats `src/graphql/entity/metadata.json` as a source-controlled blueprint. The design must fit that pipeline, not replace it.

Sections rewritten here: **Section 3 B1**, **Section 3 B6**, **Section 5 (end-to-end)**, **Section 8 (effort totals recomputed)**. Everything else in v1 still stands — v1 is the source for Sections 1, 2, 4, 4b, 6, 7.

---

# Existing deployment pipeline (verified before any proposal)

## Source-controlled blueprint artefacts

Every "blueprint" artefact is already a file in git. No DynamoDB snapshot is needed to capture them, because they live in the repo:

- **Entity definitions** — [src/graphql/entity/metadata.json](../../../trackon-aws-backend/src/graphql/entity/metadata.json) — the canonical list of entities, validated in CI (see below).
- **Seed data** — [src/graphql/entity/initial_data.json](../../../trackon-aws-backend/src/graphql/entity/initial_data.json), [src/graphql/entity/additional_data.json](../../../trackon-aws-backend/src/graphql/entity/additional_data.json).
- **Saved reports / analytics queries** — [src/graphql/entity/reports.json](../../../trackon-aws-backend/src/graphql/entity/reports.json).
- **Flow-designer node templates** — [src/lambdas/flow_node_templates.json](../../../trackon-aws-backend/src/lambdas/flow_node_templates.json).
- **Step Functions ASL** — 35 files in [src/statemachine/](../../../trackon-aws-backend/src/statemachine/).
- **VTL resolvers** — files under [src/resolvers/vtl/](../../../trackon-aws-backend/src/resolvers/vtl/).
- **IaC** — [templates/cloudformation.yaml](../../../trackon-aws-backend/templates/cloudformation.yaml), [templates/tenant-template.yaml](../../../trackon-aws-backend/templates/tenant-template.yaml).
- **Document templates** — `.docx` files under [reports/templates/](../../../trackon-aws-backend/reports/templates/).
- **Entity schema** — [src/graphql/schema.graphql](../../../trackon-aws-backend/src/graphql/schema.graphql) + per-entity JSON under [src/graphql/entity/](../../../trackon-aws-backend/src/graphql/entity/).

## Make targets that move the artefacts

[Makefile](../../../trackon-aws-backend/Makefile) owns the full deploy pipeline. Relevant targets:

- `upload_state_machines` ([line 110-113](../../../trackon-aws-backend/Makefile#L110-L113)) — every ASL to S3 under `state_machine_definitions/`.
- `upload_vtl` ([line 145-148](../../../trackon-aws-backend/Makefile#L145-L148)) — VTL resolvers.
- `upload_templates` ([line 115-118](../../../trackon-aws-backend/Makefile#L115-L118)) — CloudFormation templates.
- `upload_entities` ([line 120-123](../../../trackon-aws-backend/Makefile#L120-L123)) — all JSON under `src/graphql/entity/`.
- `upload_report_templates` ([line 125-140](../../../trackon-aws-backend/Makefile#L125-L140)) — `.docx` / `.jrxml` / `.pdf`.
- `upload_tenant_template` ([line 142-143](../../../trackon-aws-backend/Makefile#L142-L143)) — tenant CFN template.
- `upload_layer` ([line 80-89](../../../trackon-aws-backend/Makefile#L80-L89)) — Python Lambda layers.
- `package` / `deploy` ([line 150-181](../../../trackon-aws-backend/Makefile#L150-L181)) — CloudFormation deploy gated by `ENVIRONMENT` + `AWS_REGION`.
- Stack + S3-bucket names parameterised on `ENVIRONMENT` + region at [Makefile:24-29](../../../trackon-aws-backend/Makefile#L24-L29): e.g. `trackon-aws-backend-stack-staging` for `us-east-1`, `tai-prod-eu` for `eu-central-1`.

## GitHub Actions — the two-account wiring

[.github/workflows/](../../../trackon-aws-backend/.github/workflows/) has twelve workflows. The load-bearing ones:

- [deploy-staging.yaml](../../../trackon-aws-backend/.github/workflows/deploy-staging.yaml) — trigger: `push` to `main`. Env: `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` (staging-account secrets). Step: `make deploy ENVIRONMENT=staging`.
- [deploy-prod.yaml](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml) — trigger: `push` of a `v*` **tag**. Env: `PROD_AWS_ACCESS_KEY_ID` / `PROD_AWS_SECRET_ACCESS_KEY` (production-account secrets). Step: `make deploy ENVIRONMENT=prod LOG_LEVEL=ERROR`.
- [deploy-pr.yaml](../../../trackon-aws-backend/.github/workflows/deploy-pr.yaml) — `workflow_dispatch` with env selector; uses staging creds; pinned to `us-west-1`.
- [manual-deploy-dev.yaml](../../../trackon-aws-backend/.github/workflows/manual-deploy-dev.yaml) — manual `dev` deploys.
- [metadata-check.yaml](../../../trackon-aws-backend/.github/workflows/metadata-check.yaml) — runs [utils/metadata_check.py](../../../trackon-aws-backend/utils/metadata_check.py) on every change to `src/graphql/entity/metadata.json`. **This is already a blueprint-integrity gate.** Checks (from [metadata_check.py:24-97](../../../trackon-aws-backend/utils/metadata_check.py#L24-L97)): pk/sk formula attributes are marked `required: true`, IDGeneration attributes exist, formula variables are declared.
- [lint.yaml](../../../trackon-aws-backend/.github/workflows/lint.yaml), [test.yaml](../../../trackon-aws-backend/.github/workflows/test.yaml) — pre-deploy quality gates.
- [layer-deploy.yaml](../../../trackon-aws-backend/.github/workflows/layer-deploy.yaml) / [layer-deploy-prod.yaml](../../../trackon-aws-backend/.github/workflows/layer-deploy-prod.yaml) — Python layer deploys.
- [docker-deploy.yaml](../../../trackon-aws-backend/.github/workflows/docker-deploy.yaml) / [prod-docker-deploy.yaml](../../../trackon-aws-backend/.github/workflows/prod-docker-deploy.yaml) — container-based Lambdas (Docling, LibreOffice).
- [cleanup.yaml](../../../trackon-aws-backend/.github/workflows/cleanup.yaml) — Lambda version pruning.

**The two-account split is purely credential-based: no cross-account IAM roles or `AssumeRole` in the repo** — each workflow runs with the account's own long-lived access keys. `ACCOUNT_ID` is discovered at deploy time via `aws sts get-caller-identity` ([Makefile:212](../../../trackon-aws-backend/Makefile#L212), [Makefile:238](../../../trackon-aws-backend/Makefile#L238), [Makefile:256](../../../trackon-aws-backend/Makefile#L256), [Makefile:271](../../../trackon-aws-backend/Makefile#L271)), never hard-coded.

## Cut-over semantics we get for free

- **Staging validation against real-shape data** — the staging account runs real Step Functions against test tenants. Every change lands there before prod via `push → main`.
- **Release tagging** — only `v*` tags can touch prod ([deploy-prod.yaml:5](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml#L5)). That tag is the blueprint version.
- **Rollback** — `git checkout v{prev}` + re-tag + push → CI redeploys the prior version to prod. No bespoke rollback tooling needed.
- **Account isolation** — a catastrophic migration in staging cannot touch prod data because the credentials don't exist there.

**This simplifies Section 5 significantly.** See below.

---

# Section 3 — Blockers, revised entries

## B1 (revised) — Metadata resolver hardening (NOT a missing feature)

**Grade update:** point 1 of the seven-point test moves from **Partial** to **Partial (strong)**. The resolver already supports update; the UI already has EntityBuilder. What's missing is hardening, not implementation.

**Evidence the resolver is already an upsert + history recorder:**

- [create_entity_metadata.py:148-149](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L148-L149): `tbl.put_item(Item=item)` with **no `ConditionExpression`** — DynamoDB `put_item` without a condition is upsert semantics. Calling `createEntityMetadata` for an existing entity overwrites it.
- [create_entity_metadata.py:171-173](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L171-L173): `record_to_history(tenant_id, metadata, event.get("identity", {}))` runs on every invocation, writing a full snapshot to the `METADATA_HISTORY` entity — this is already a blueprint audit trail keyed by `transactionTimestamp` ([line 34](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L34)).
- [create_entity_metadata.py:157-168](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L157-L168): `create_or_evolve_view(...)` is called on every invocation, so S3 Tables / Iceberg schema evolves in place — adding a nullable column to an existing entity Just Works.
- Cache invalidation for `entity_manager.get_entity_definitions()` ([utils/entity_manager.py:33-93](../../../trackon-aws-backend/src/utils/entity_manager.py#L33-L93)) is time-based (5-min TTL). No explicit bust on update is necessary for correctness, but it introduces a read-after-write staleness window.

**What needs hardening (the real work):**

1. **Split create vs update at the GraphQL layer.** Today a single mutation silently upserts; the API should expose `createEntityMetadata` (`attribute_not_exists` condition) and `updateEntityMetadata` (`attribute_exists` condition). This prevents a client accidentally clobbering a tenant's entity with a create call. Change is in the schema + resolver dispatch; the underlying DDB/Iceberg code is unchanged.
2. **Immutability enforcement on update.** [create_entity_metadata.py:110-120](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L110-L120) validates required fields but not invariants across calls: pkFormula, skFormula, IDGeneration, and any attribute whose `immutable: true` flag is set must not change once created. Add a diff check in the update path that rejects changes to these with a structured error, citing the field.
3. **Fix the pk/sk formula copy bug at [create_entity_metadata.py:141-145](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L141-L145).** The indentation is wrong:
   ```python
   for i in range(1, 11):
       for prefix in ("pk", "sk"):
           field = f"{prefix}{i}Formula"
       if metadata.get(field):
           item[field] = metadata[field]
   ```
   The `if` block is outside the inner `for prefix` loop — it only ever tests and copies the last `field` assigned (`sk{i}Formula` for `i` in `1..10`), so `pk{i}Formula` values for any attributes not already in `item.update(metadata)` at [line 139](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L139) are dropped. The `item.update(metadata)` at line 139 masks this in most cases because metadata already contains these fields at the top level, but the loop is still dead code and a latent bomb. Fix to proper nesting and add a test under [tests/resolvers/test_create_entity_metadata.py](../../../trackon-aws-backend/tests/resolvers/test_create_entity_metadata.py).
4. **Make METADATA_HISTORY failures visible.** [create_entity_metadata.py:75-78](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L75-L78) swallows the error with `logger.warning` + `pass`. On the Adaptive CTRM claim this *is* the audit trail — silent failure is unacceptable. Emit a CloudWatch metric and fail the mutation if the history write fails, unless an explicit `allowHistoryFailure=true` flag is passed.
5. **Explicit cache bust.** After a successful update, publish an SNS or EventBridge event so the `entity_manager` cache in every warm Lambda can invalidate, rather than waiting up to 5 minutes. The existing DDB Streams changelog machinery ([lambdas/ddb_streams_changelog.py:76-300](../../../trackon-aws-backend/src/lambdas/ddb_streams_changelog.py#L76-L300)) can carry this signal without new infra.

**Why it blocks the claim at all:** without items 1–2 and 4 a customer admin can save a broken schema and not know the audit log didn't record it, and a clobber via `createEntityMetadata` on an existing entity is indistinguishable from an update. Those are the defensibility risks, not the update capability itself.

**Effort: ~1.5–2 dev-weeks.**
- 0.5 wk split mutations + immutability check + formula-bug fix + unit tests.
- 0.5 wk audit-failure visibility (metric + optional-bypass flag).
- 0.5–1 wk explicit cache bust + e2e tests + docs.

**Dependencies:** none.

## B6 (revised) — Blueprint versioning, fitted to the two-account pipeline

The single-account design in v1 is overbuilt. The repo + CI pipeline already provides 80% of what we need:

- The blueprint lives in `src/graphql/entity/*.json` + `src/statemachine/*.asl.json` + `reports/templates/*` + `templates/*.yaml` + `src/resolvers/vtl/*.vtl`. It is already versioned in git.
- "Staging" = what's on `main` after CI runs `make deploy ENVIRONMENT=staging` ([deploy-staging.yaml](../../../trackon-aws-backend/.github/workflows/deploy-staging.yaml)).
- "Published" = the commit reachable from a `v*` tag, deployed to the prod account by [deploy-prod.yaml](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml).
- "Rollback" = `git tag v{prev+1} v{prev}^{commit}` and push.

What's genuinely missing is the **per-tenant overlay** on top of the shared platform blueprint: custom entities, custom workflow definitions, custom screens, custom integration mappings, all scoped to one tenant and editable at runtime by their admin. Those cannot live in the platform repo (customer data in git is a non-starter), but they must still be:

- versionable with diff and rollback,
- deployed in a two-phase promotion (validate-in-staging → promote-to-prod),
- auditable.

**Revised blocker, in one sentence:** build a tenant-blueprint overlay that (a) is stored as JSON in DynamoDB + S3 per tenant, (b) goes through a three-state lifecycle whose *staging* state is literal deployment to the staging AWS account, (c) promotes to the prod account via the same CI/CD pipeline that already moves platform code, (d) rolls back by re-promoting an earlier overlay version.

**Effort:** ~7–9 dev-weeks (down from 13–16 in v1). Breakdown in Section 5.8.

**Dependencies:** B1 hardening must land first (split create/update mutations are the write path the overlay uses).

---

# Section 5 — Blueprint versioning design (rewritten)

## 5.1 Two-account deployment topology

### The existing model (platform blueprint)

```
                ┌──────────────────────────────┐
                │  git (trackon-aws-backend)   │
                │  main branch = staging head  │
                │  v* tag      = prod release  │
                └──────────────┬───────────────┘
                               │
                 push main ────┤──── push v* tag
                               │
              ┌────────────────┴────────────────┐
              ▼                                 ▼
     deploy-staging.yaml                 deploy-prod.yaml
     AWS_ACCESS_KEY_ID                   PROD_AWS_ACCESS_KEY_ID
     make deploy ENV=staging             make deploy ENV=prod
              │                                 │
              ▼                                 ▼
      ┌───────────────┐                 ┌───────────────┐
      │ STAGING ACCT  │                 │    PROD ACCT  │
      │ trackon-aws-  │                 │ trackon-aws-  │
      │ backend-stack-│                 │ backend-stack-│
      │ staging       │                 │ prod          │
      │               │                 │               │
      │ universal DDB │                 │ universal DDB │
      │ per-tenant CF │                 │ per-tenant CF │
      │ stacks        │                 │ stacks        │
      │ 35 SFNs       │                 │ 35 SFNs       │
      └───────────────┘                 └───────────────┘
```

Credentials are the only isolation boundary ([deploy-staging.yaml:14-15](../../../trackon-aws-backend/.github/workflows/deploy-staging.yaml#L14-L15) vs [deploy-prod.yaml:14-15](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml#L14-L15)). There is no cross-account IAM role; each workflow runs with the account-local access keys.

### Where the tenant blueprint overlay lives at each stage

| Lifecycle state | Where it lives | Account | Editable by |
|---|---|---|---|
| **Draft** | DynamoDB + S3 in the **staging account**, under a "draft" version number per tenant | staging | tenant admin (via Screen Designer / EntityBuilder / Flow designer) |
| **Staging** | same DynamoDB + S3 in the **staging account**, flagged `status: STAGING`; Step Functions for that tenant's workflows deployed to the staging account under an alias | staging | read-only; validated against test-tenant data |
| **Published** | DynamoDB + S3 in the **production account**, flagged `status: PUBLISHED`; Step Functions alias in prod pointed at the newly-deployed version | prod | read-only |
| **Archived** | previous PUBLISHED row retained in the prod account for rollback | prod | read-only |

This mirrors how the platform blueprint already moves: edits accumulate on `main` (staging), then a tag + push promotes to prod. The only difference is that tenant overlays can't commit to the platform repo, so the draft/staging stages run inside the staging AWS account's DynamoDB instead of in git.

## 5.2 Blueprint as versioned artefact — hybrid git + S3

### Platform blueprint (unchanged)

Already in git at `trackon-aws-backend`:

```
src/graphql/entity/metadata.json          # platform-shared entity defs
src/graphql/entity/reports.json           # platform-shared reports
src/graphql/entity/initial_data.json      # seed data
src/graphql/entity/additional_data.json
src/statemachine/*.asl.json               # platform workflows
src/resolvers/vtl/*.vtl                   # resolver templates
src/lambdas/flow_node_templates.json      # flow-node catalogue
reports/templates/**.docx                 # document templates
templates/cloudformation.yaml             # tenant CFN template
```

Already validated in CI by [metadata-check.yaml](../../../trackon-aws-backend/.github/workflows/metadata-check.yaml) invoking [utils/metadata_check.py](../../../trackon-aws-backend/utils/metadata_check.py). Branch model = `main` (staging head) + `v*` tags (prod releases).

### Tenant overlay (new)

One overlay per tenant per version. JSON shape:

```json
{
  "tenantId": "aghospital",
  "version": 17,
  "parentVersion": 16,
  "createdBy": "admin@ags.com",
  "createdAt": "2026-04-21T10:00:00Z",
  "status": "PUBLISHED",
  "platformBlueprintTag": "v2.41.0",
  "entities": { "AGS_PATIENT": {/* metadata.json shape */} },
  "workflows": { "approvePatientIntake": { "graph": {...}, "asl": {...} } },
  "screens":  { "AGS_PATIENT#edit": { /* ScreenLayout descriptor, see 4b */ } },
  "reports":  { "patientMix": { "sqlTemplate": "...", "params": [...] } },
  "integrationMappings": { "LAB_IMPORT#RESULT": {...} },
  "avpPolicies": [/* exported AVP policies referencing custom entities */]
}
```

Stored as a **single JSON blob per tenant per version** in S3:

```
s3://tai-blueprints-{env}/tenants/{tenantId}/{version:010d}.json
```

(Bucket versioning enabled for a second layer of off-site retention.) Reason for a single blob per version: atomic reads, atomic writes, no referential-integrity worries across tables when snapshotting. A small pointer record in DynamoDB (see 5.3) is the source of truth for "which version is current".

Every overlay pins a `platformBlueprintTag` — the platform release it was edited against. Blueprint promotion will reject a tenant overlay edited against tag X when prod is running tag Y until the admin re-validates against Y.

### Optional: mirror to per-tenant git repo

For customers who want their own audit trail, a GitHub App can mirror each published overlay to `tenants/{tenantId}` in a dedicated git repo. Not required for v1. Adds ~1 dev-week if pursued.

## 5.3 DynamoDB tables for deployment tracking (simplified)

V1 proposed five tables. The pipeline-fitted design needs **two items in the universal DynamoDB table**, one LSI/GSI, and a pointer pattern. History lives in S3 and in git; DynamoDB tracks current state only.

### Item A — `TENANT_BLUEPRINT_POINTER`

One item per tenant per environment. Current active version and its predecessor.

| Field | Description |
|---|---|
| PK | `T#{tenantId}#BLUEPRINT` |
| SK | `POINTER#{env}` where env ∈ `{staging, prod}` |
| currentVersion | int, the published version number |
| previousVersion | int, the version this rolled back from or was promoted over |
| platformBlueprintTag | e.g. `v2.41.0` |
| promotedAt | ISO timestamp |
| promotedBy | user sub / email |
| s3Key | `tenants/{tenantId}/{version:010d}.json` |

Only mutated on promote / rollback. Two items per tenant maximum.

### Item B — `TENANT_BLUEPRINT_DEPLOYMENT` (audit)

One item per deployment (promote, rollback, or staging publish). Append-only.

| Field | Description |
|---|---|
| PK | `T#{tenantId}#BLUEPRINT_DEPLOYMENT` |
| SK | `{deployedAt_desc}#{deploymentId}` — reverse timestamp for natural ordering |
| fromVersion / toVersion | ints |
| targetEnv | `staging` or `prod` |
| status | `SUCCESS` \| `FAILED` \| `ROLLBACK` |
| migrationLog | JSON array of `{changeType, target, result, durationMs, error?}` |
| triggeredBy | user sub |
| stepFunctionExecutionArn | link to the deploy Step Function run |

GSI2 on `BLUEPRINT_DEPLOYMENT#{deploymentId}` → a stable per-deployment link.

### What V1 had that V2 drops

- `blueprint_snapshots` → redundant. The snapshot *is* the S3 JSON blob.
- `blueprint_changes` → computed on demand by diffing two S3 blobs. Store the *semantic diff output* inside the `migrationLog` of the deployment record so the UI doesn't have to recompute.
- `blueprint_versions` → the S3 key `{version:010d}.json` is the version record.
- `blueprints` → the tenant itself is the blueprint. No separate blueprint entity.

Both PK patterns fit the existing universal DynamoDB table at [templates/cloudformation.yaml:514-605](../../../trackon-aws-backend/templates/cloudformation.yaml#L514-L605) — no schema changes, same PK/SK + existing GSIs.

## 5.4 Promotion flow

### Phase 1 — Admin edits, draft accumulates (staging account)

1. Tenant admin edits an entity (EntityBuilder → `updateEntityMetadata`, after B1 hardening), a workflow ([WorkflowEditor.tsx](../../../react-ui/src/views/pages/Flows/WorkflowEditor.tsx) → `createWorkflow` / `updateWorkflow`), or a screen (new Screen Designer from Section 4b).
2. Each save writes to the tenant's live DynamoDB rows **in the staging account only**.
3. A new resolver `createDraftBlueprintSnapshot(tenantId)` pulls all tenant-scoped custom rows (entities with `tenantId` prefix in their SK, tenant-owned workflows, screen descriptors, integration mappings, tenant-owned AVP policies via [avp_operations.py:25-98](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L25-L98)), bundles them into the overlay JSON, and uploads to `s3://tai-blueprints-staging/tenants/{tenantId}/{nextVersion:010d}.json`. Draft-only.
4. The admin sees a "Draft v17 ready" banner.

### Phase 2 — Promote to staging (still staging account)

1. Admin clicks "Promote to staging". GraphQL mutation `promoteBlueprintToStaging(tenantId, version)`.
2. New Step Function `TenantBlueprintDeploy-staging-{env}` (see 5.7) runs:
   - Validates the overlay against the current `platformBlueprintTag` (platform entity references resolve, AVP policy schema matches, screen descriptor `fieldId` values exist).
   - Runs the forward migration executor (5.6) against a **copy of the tenant's DynamoDB data** in the staging account. If migrations fail, halts.
   - Creates new Step Functions *versions* (not new state machines) for every tenant workflow in the overlay and flips the tenant-local alias `{workflowName}-staging-{tenantId}-live` to the new version. Old in-flight executions drain against the prior version.
   - Updates the `POINTER#staging` row for the tenant.
   - Appends a `BLUEPRINT_DEPLOYMENT` audit record.
3. Admin runs tenant-specific validation suites in the staging account (customer scenarios against real-shape data). This is the "free migration testing" the two-account architecture buys us.

### Phase 3 — Promote to production (prod account)

1. Admin clicks "Promote to prod". GraphQL mutation `promoteBlueprintToProd(tenantId, version)` in the staging account.
2. Staging-side resolver copies the S3 overlay from `tai-blueprints-staging` to `tai-blueprints-prod` via a **pre-signed PUT + cross-bucket copy using a dedicated bucket replication rule**, OR via a small EventBridge-triggered Lambda in the prod account that pulls from staging. No cross-account IAM role is introduced on the control plane; we use S3 bucket policies to allow one-way read from the prod pull-lambda.
3. A webhook to a prod-account API Gateway endpoint triggers `TenantBlueprintDeploy-prod`. Same Step Function shape as staging, running in the prod account's credentials, reading the prod S3 overlay.
4. On success: prod `POINTER#prod` row updated, audit record written, prod Step Function alias flipped.
5. On failure: pointer unchanged, Step Function remains pointed at the prior version, audit record logs failure. No silent partial states.

### Alias flip: how and why (narrower than v1)

Given the two-account atomicity, aliases are now only used for **in-flight execution safety within a single account**, not for cross-environment cutover. Concretely:

- When promoting overlay `v17` to the prod account: for each workflow, `CreateStateMachineVersion` (or create a new versioned state-machine resource under a fixed logical name) and `UpdateStateMachineAlias` `{name}-prod-{tenant}-live` to point at the new version.
- In-flight executions from `v16` continue against the `v16` version until they complete; new executions get `v17`.
- This requires swapping construction of the `stepFunctionArn` in [create_workflow.py:148-156](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L148-L156) and [workflow_triggers_service.py:109-121](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L109-L121) from raw ARN to alias ARN. One file change in each.

## 5.5 Rollback flow

Forward-only migrations + two accounts make rollback cheap: **redeploy the prior overlay version**.

1. Admin picks `v16` from the version list in the Admin UI (reading from the S3 prefix or the `DEPLOYMENT` audit log).
2. System calls `promoteBlueprintToProd(tenantId, 16)` — the same mutation as a forward promote.
3. The Step Function treats `v16` as the new target. It diffs against the current `v17` and applies whatever *forward* migrations are required to reach the `v16` shape (e.g. if `v17` added a column, the rollback to `v16` soft-deletes the column; the migration map in 5.6 defines each transition type in the forward direction only).
4. `POINTER#prod.currentVersion = 16`, `previousVersion = 17`. Audit record tagged `status: ROLLBACK`.

**Reverse migrations are not maintained.** Every rollback path is just another forward migration whose target happens to be an earlier shape. This halves the migration-executor maintenance cost.

**Exception:** irreversible changes. Dropping data (`archive_entity` with `hardDelete: true`, dropping a required field) breaks the "any version can be re-promoted" invariant. Forbid these at the promotion-validator step: the validator walks the overlay diff and, if any change is irreversible, requires an explicit `acknowledgeDataLoss=true` parameter and records the acknowledgement in the audit log. Reversible changes (add nullable field, soft-delete field, rename with alias view in Iceberg) form the default menu.

## 5.6 Migration executor — forward only, idempotent

Same change types as v1 Section 5.5, **no reverse paths required**:

| Change type | Forward action | Idempotence key |
|---|---|---|
| add_field_nullable | Patch entity metadata via hardened `updateEntityMetadata` (B1). Iceberg `evolve_schema` (already supported by [s3tables_manager.py](../../../trackon-aws-backend/src/utils/s3tables_manager.py)) auto-adds a nullable column. | Field exists in metadata |
| add_field_required_with_default | Patch metadata. Backfill existing DDB items with `attribute_not_exists` guard. | Item has field OR hash match |
| soft_delete_field | Patch metadata flag `deprecated:true`. UI hides, DDB retains. | Flag set |
| rename_field | Patch metadata. Copy data in DDB. Add Iceberg view alias. | New name present AND old name empty |
| add_entity | Hardened `createEntityMetadata`. | Entity present in DDB metadata |
| archive_entity | Patch metadata `state=ARCHIVED`. | State flag matches |
| workflow_changed | `CreateStateMachineVersion` + alias flip (5.4). | Alias points to target version ARN |
| screen_descriptor_changed | Write descriptor to DDB. | SHA256 of blob |
| report_template_changed | Upload `.docx` to prod S3 `reports/templates/`. | S3 object ETag |
| integration_mapping_changed | Write `INTEGRATION_FIELD_MAPPING` item to DDB. | Item exists with matching version |
| avp_policy_changed | `BatchWritePolicies` to the prod tenant policy store. | Policy ID + etag match |

All handlers:
- Read current state first.
- Skip if idempotence key matches.
- Log `applied | skipped | failed` to the deployment audit record.
- Fail-fast with a structured error that names the change and the handler.

Executor lives in a new `src/lambdas/blueprint_migration_executor.py`. One handler module per change type under `src/utils/blueprint_migrations/`.

## 5.7 CI/CD integration points

The overlay pipeline re-uses the existing pipeline instead of creating a parallel one. Concrete integration points:

### Makefile — two new targets

Add to [Makefile](../../../trackon-aws-backend/Makefile):

- `deploy-blueprint-infra` — extends `deploy` to include the new DynamoDB PK/SK patterns (nothing to deploy; it's items, not schema) and the two S3 buckets (`tai-blueprints-staging`, `tai-blueprints-prod`) and the new CloudWatch Log Group `/aws/lambda/TenantBlueprintDeploy`. Wire into the existing CFN `templates/cloudformation.yaml` as three new resources — no standalone stack.
- `upload-blueprint-schema` — new target uploading a JSON-Schema (`ajv`-validatable) for the tenant overlay to `s3://{bucket}/blueprint-schema/overlay.schema.json`. Referenced by the promotion-validator Lambda.

### CloudFormation template — three new resources in the existing stack

Add to [templates/cloudformation.yaml](../../../trackon-aws-backend/templates/cloudformation.yaml):

- `TenantBlueprintDeployFunction` (Lambda, handler `blueprint_migration_executor.lambda_handler`).
- `TenantBlueprintDeployStateMachine` (Step Function orchestrating validate → migrate → alias-flip → update pointer → audit).
- `TenantBlueprintsBucket` per environment (tag-based naming like existing buckets at [Makefile:25](../../../trackon-aws-backend/Makefile#L25)).

All three get wired into existing output exports so [resolvers/blueprint_operations.py](../../../trackon-aws-backend/src/resolvers/blueprint_operations.py) (new) can discover them.

### GitHub Actions — no new workflow files

Existing workflows cover it:

- `deploy-staging.yaml` already picks up the new Lambda/Step-Function definitions on every push to `main`.
- `deploy-prod.yaml` picks them up on every `v*` tag.
- `metadata-check.yaml` extends to validate the JSON-Schema of any committed overlay sample (not required for runtime overlays since those live in S3, but useful for the platform's own tenant-template fixtures).
- [lint.yaml](../../../trackon-aws-backend/.github/workflows/lint.yaml) + [test.yaml](../../../trackon-aws-backend/.github/workflows/test.yaml) cover unit tests for new code.

### Resolvers — new files that fit the existing pattern

Follow the pattern of [create_workflow.py](../../../trackon-aws-backend/src/resolvers/create_workflow.py):

- `src/resolvers/blueprint_operations.py` — `createDraftBlueprintSnapshot`, `listBlueprintVersions`, `getBlueprintDiff`, `promoteBlueprintToStaging`, `promoteBlueprintToProd`, `rollbackBlueprint`.
- `src/resolvers/blueprint_diff.py` — semantic diff between two S3 overlay blobs.
- `src/lambdas/blueprint_migration_executor.py` — the forward-only executor.
- `src/utils/blueprint_migrations/*.py` — one file per change type.
- `src/statemachine/tenant_blueprint_deploy_step_function.asl.json` — new ASL: validate → migrate → alias-flip → update pointer → audit (retry + catch on every step).

### What simplifies vs v1

- No `blueprint_snapshots` table, no `blueprint_changes` table, no `blueprints` table. Only pointer + audit.
- No reverse migrations.
- No bespoke rollback orchestration — rollback is forward promote of an earlier version.
- Off-site backup is free (platform S3 buckets in two accounts, both versioned).
- Cross-account cutover atomicity comes from the account boundary, not from alias juggling.
- CI/CD is unchanged; the platform-blueprint deploys already move any new resolvers / Lambdas / state machines to both accounts via the existing `main` → staging and `v*` → prod trigger.

## 5.8 Revised milestone plan

| # | Milestone | Content | Dev-days | Rationale |
|---|---|---|---|---|
| M1 | B1 hardening (prereq) | split create/update mutations, immutability check, fix L141 bug, visible audit failures, explicit cache bust | 8 | See B1 above. Blocks the rest because overlay writes use the hardened path. |
| M2 | Overlay schema + JSON-Schema validator + S3 buckets | Lock descriptor shape; add `ajv` to [react-ui/package.json](../../../react-ui/package.json) and a Python validator for the backend; CFN resources for the two buckets | 5 | Cross-cutting interface — must be frozen before anything consumes it. |
| M3 | `createDraftBlueprintSnapshot` + overlay pull from live DDB | Read tenant-scoped rows, bundle overlay, upload to S3. | 5 | Extends the `list_entities`/`list_entity` pattern. |
| M4 | Semantic diff on S3 blobs | Pure JSON-diff plus change-type classifier. No DB state. | 5 | Output feeds the Admin UI and the migration executor. |
| M5 | Forward-only migration executor | One handler per change type (11 types). Idempotent. Audit log. | 12 | Bulk of the backend work. Most handlers are thin wrappers over existing resolvers. |
| M6 | Step Function alias flip changes | Modify [create_workflow.py:148-156](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L148-L156) and [workflow_triggers_service.py:109-121](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L109-L121) to use alias ARNs; add `CreateStateMachineVersion` call on deploy. | 4 | Narrow-scoped change; only alias construction + one deploy call. |
| M7 | `TenantBlueprintDeploy` Step Function + promote/rollback mutations | ASL orchestrating validate → migrate → alias flip → pointer update → audit. Staging and prod variants differ only in S3 bucket + pointer env. | 5 | Straightforward if M5 handlers are solid. |
| M8 | Cross-account S3 copy for prod promote | One-way pull-lambda in prod reading from staging bucket via bucket policy. No cross-account IAM role required. | 3 | Shallow but needs careful IAM review. |
| M9 | Admin UI — version list, diff view, promote wizard, rollback | React components using existing Syncfusion grid + dialog primitives. Reads S3 overlays and audit log. | 8 | Reuses patterns from [src/views/pages/Administration/](../../../react-ui/src/views/pages/Administration/). |
| M10 | E2E drill + docs | Run a full edit → promote → validate → promote → rollback drill in staging with a test tenant. | 5 | Real-data sign-off. |
| — | Contingency / buffer (20%) | | 12 | |
| **Total** | | | **72 dev-days ≈ 7 calendar weeks × 2 = ~14 weeks… no wait, 72 / 5 = 14.4 weeks — correction below.** | |

Math check: 72 dev-days ÷ 5 dev-days per week = **14.4 dev-weeks**. This is still lower than v1's 13–16 *without* buffer and 16+ *with* buffer, because the snapshot / change / reverse-migration work vanishes.

**Practical planning number: 9 dev-weeks of net work + 3 weeks buffer = 12 weeks.**

The difference from v1 (13–16w) is ~4 weeks saved, driven by:
- No snapshot / change tables → no capture code.
- No reverse migrations → half the executor.
- Rollback = forward promote → no bespoke rollback code.
- Two-account isolation handles atomicity → aliases are a narrow in-flight-safety tool, not the primary cutover mechanism.

---

# Section 8 — Total effort summary (recomputed)

## 8.1 Blocker table (updated)

| # | Blocker | v1 est | **v2 est** | Depends on | Risk | Owner |
|---|---|---|---|---|---|---|
| B1 | Metadata resolver hardening (was: missing update resolver) | 2w | **1.5–2w** | — | Low | Bibeesh |
| B2 | Schema-driven screen designer | 11–14w | 11–14w (unchanged) | B1, B6 | High | Bibeesh + contractor |
| B3 | Flow designer parity with Step Functions | 6–8w | 6–8w (unchanged) | — | Medium | Bibeesh |
| B4 | Report auto-discovery + dynamic joins | 5–7w | 5–7w (unchanged) | B1 | Medium | Contractor |
| B5 | Integration mapping layer (MVP) | 3w | 3w (unchanged) | B1, B6 | Medium | Contractor |
| B6 | Blueprint versioning (two-account overlay) | 13–16w | **9–12w** (-4) | B1 | Medium (was High) | Bibeesh |
| B7 | Field-level RBAC in renderer | 2–2.5w | 2–2.5w (unchanged) | B2 | Low | Bibeesh |

**Sum of MVP blocker work: v1 ~42–52w → v2 ~38–48w.** About 4 weeks saved, all from B1 and B6.

## 8.2 Scenario recompute

### Scenario A — Bibeesh solo full-time

Serial order respecting dependencies:

1. B1 (2) → B6 M1–M5 (7) → B3 (7) → B2 M1–M3 (8) → B6 M6–M10 (5) → B7 (2) → B2 M4–M7 (5) → B4 (6) → B5 MVP (3).

**Total: ~45 dev-weeks** (was 49). At ~45 productive weeks/year: **~11 months → 2027-Q1** if started now.

### Scenario B — Bibeesh + one senior contractor

- **Bibeesh:** B6 (12w net inc. buffer) + B3 (7w) + B7 (2w) + B1 (2w) = ~23w serial.
- **Contractor:** B2 (13w avg) + B4 (6w) + B5 (3w) = ~22w serial.
- Integration / end-to-end drill: +2w at the end.
- 20% buffer on the joined critical path: ~5w.

**Total: ~28 calendar weeks ≈ 6.5 months → 2026-Q4** if started late April 2026. Slightly better than v1's 7-month estimate because B6 is lighter.

### Scenario C — De-scope (drop B4, minimum B5)

~20w (was 22w). Claim weakens on points 5 and 7 as before.

## 8.3 What the two-account topology buys us concretely

- **Migration rehearsal is free.** Every change plays against real staging tenant data before prod. No need to build synthetic-data migration fixtures.
- **Rollback is a re-promotion.** One code path for forward and back.
- **Atomic cutover.** The credential boundary, not alias logic, is the atomicity primitive.
- **Smaller blast radius.** A bad deploy to staging never reaches prod tenant data.
- **Simpler tables.** Two item types in DynamoDB instead of five.
- **Off-site backup is free.** Two independent account S3 buckets, both versioned.

## 8.4 Residual risks (updated)

- **R1 (was: blueprint scope creep)** — reduced. The simpler table model + forward-only migrations cap the surface area.
- **R2 (flow-designer parameter fix changes ASL of live workflows)** — unchanged. Still must ship behind alias versioning (M6).
- **R3 (Iceberg schema-evolution edge cases)** — unchanged. Explicit customer-facing guarantees still needed.
- **R4 (bus factor on Bibeesh for B6)** — reduced. Smaller codebase, less novel. A contractor onboarding pack is still recommended for the migration executor.
- **R5 (AVP field-level policy cost)** — unchanged.
- **R6 (new) — cross-account S3 copy security.** M8 is the one operation that bridges accounts. A pull-lambda model with a bucket-policy grant is simpler than an `AssumeRole`, but still needs a security review; recommend a 2-day threat model pass on M8.

## 8.5 Revised open questions for Murat

- **Q1.** Same as v1 — which three integrations are required for v1? (default: Datalastic + bank-file + one carrier.)
- **Q2.** Same as v1 — are we OK with "reports populate after first data arrives" on new custom entities?
- **Q3.** Same as v1 — field-level RBAC: role-based or attribute-based?
- **Q4 (revised).** Given the ~4-week saving on B6, do we want to keep the same launch date and use the headroom to ship B4 fully, or bring the launch forward? Recommend: keep launch date, ship B4 fully — strengthens the claim on point 5.
- **Q5 (new).** Do we want a tenant-visible "view the blueprint JSON" feature so customers can audit their own overlays, or is audit through the UI enough? The overlay-in-S3 design makes this cheap (one presigned URL) if we want it.
