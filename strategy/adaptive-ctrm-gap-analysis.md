---
title: TrackonAI Adaptive CTRM Gap Analysis
updated: 2026-04-21
owner: sozturk
status: draft
related:
  - products/trackonai/trackonai-roadmap.md
  - products/trackonai/trackonai-overview.md
  - decisions/
---

# TrackonAI — Adaptive CTRM Gap Analysis

Grounded in code. Every claim cites a file path; where evidence is absent, the section says so explicitly.

- Backend repo: `../../../trackon-aws-backend`
- Frontend repo: `../../../react-ui`
- Brain vault: `../../` (this file)
- Analysis date: 2026-04-21

## Product definition under test

Adaptive CTRM = a commodity trading platform where a customer admin can perform all seven of the following at runtime, without writing code and without a vendor developer:

1. Add/modify an entity with RBAC inheritance
2. Add/modify a field with validation + computed values
3. Design/modify a screen (layout, visibility, actions) for that entity
4. Add/modify a workflow triggered by entity CRUD
5. Surface new entities/fields in reports and dashboards
6. Generate documents that reference the new fields
7. Integrate with external systems that pick up new fields without code changes

All of the above must be versionable with diff, rollback, and safe data migration.

---

# Section 1 — Inventory of What Exists

## 1.a Entity metadata model

Storage is DynamoDB single-table (`UniversalDDBTable{Environment}`, see [templates/cloudformation.yaml:514-605](../../../trackon-aws-backend/templates/cloudformation.yaml#L514-L605)). Definitions are keyed by `T#{tenantId}#METADATA#ENTITY` / `ENTITY#{entityName}`.

- Create resolver: [resolvers/create_entity_metadata.py:81-190](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L81-L190) — writes metadata to DynamoDB and evolves the S3 Tables (Iceberg) schema at lines 160-168.
- In-memory loader + 5-min cache: [utils/entity_manager.py:33-93](../../../trackon-aws-backend/src/utils/entity_manager.py#L33-L93) (`load_definitions_from_dynamodb`, `get_entity_definitions`).
- State-aware lookup: [utils/entity_manager.py:95-127](../../../trackon-aws-backend/src/utils/entity_manager.py#L95-L127) (`find_entity_definition_with_states`).
- Key formula engine (placeholder substitution, GSI numeric padding): [utils/entity_manager.py:129-186](../../../trackon-aws-backend/src/utils/entity_manager.py#L129-L186) (`compute_formula`).
- Supports: attributes (type, required, defaultValue, immutable), referential constraints (refEntity/refAttribute), entity params (`useAvp`, `useStatus`, `editOnDefinitions`, `extractionEntity`), PK/SK + up to 3 GSI key formulas, entity states, detail entities, nested attributes, LOV options, extraction prompts, workflow triggers metadata.
- UI builder: [src/components/Entity/EntityBuilder.tsx:68-400](../../../react-ui/src/components/Entity/EntityBuilder.tsx) — full CRUD for attributes; surfaces constraints + entity params.
- Entity schema graph: [src/graphql/entity/](../../../trackon-aws-backend/src/graphql/entity/).

**Limitations (evidence-based):**
- **No `update_entity_metadata` resolver found** — only `create_entity_metadata.py` exists in [src/resolvers/](../../../trackon-aws-backend/src/resolvers/). Schema evolution is write-once, asynchronous.
- No per-field validation rules (regex, min/max, conditional) in metadata schema — only `required`/`immutable` flags.
- No computed-field expressions; only key-generation formulas (regex placeholder substitution).
- Unreplaced placeholders silently become the literal string `"NONE"` ([entity_manager.py:179-183](../../../trackon-aws-backend/src/utils/entity_manager.py#L179-L183)).

## 1.b Runtime validation rules

- Required-field presence: [resolvers/create_entity.py:444-459](../../../trackon-aws-backend/src/resolvers/create_entity.py#L444-L459).
- Type coercion: [utils/entity_manager.py:188-236](../../../trackon-aws-backend/src/utils/entity_manager.py#L188-L236) (`format_dynamodb_data`, N/S/BOOL only).
- Referential integrity (batch_get_item): [create_entity.py:255-353](../../../trackon-aws-backend/src/resolvers/create_entity.py#L255-L353).
- Tenant-ID regex: [lambdas/check_tenant_id.py](../../../trackon-aws-backend/src/lambdas/check_tenant_id.py) (`^[a-z0-9_]+$`, reserved list).
- Analytics-parameter LOV + ISO-8601 regex: [utils/analytics_query_manager.py](../../../trackon-aws-backend/src/utils/analytics_query_manager.py) (`validate_parameter_value`).

**Limitations:** No min/max, no regex on entity fields, no conditional required, no field-level RBAC scope in validation path.

## 1.c Computed fields and formulas

- Key formula engine: [utils/entity_manager.py:129-186](../../../trackon-aws-backend/src/utils/entity_manager.py#L129-L186) — regex substitution only (`{tenantId}`, `{id}`, `{fieldName}`). No arithmetic, no date ops, no conditional.
- Computed keys applied on create: [create_entity.py:439-442](../../../trackon-aws-backend/src/resolvers/create_entity.py#L439-L442).
- Computed-at timestamps: [lambdas/calculate_profitability.py](../../../trackon-aws-backend/src/lambdas/calculate_profitability.py), [lambdas/dashboard_metrics_scheduler.py](../../../trackon-aws-backend/src/lambdas/dashboard_metrics_scheduler.py) — ad-hoc, not metadata-driven.

**Not found in repo:** generic expression engine for field-level computed values; client-side formula evaluation; derived-value recomputation on update.

## 1.d RBAC via AVP (Cedar / Amazon Verified Permissions)

- AVP resolver: [resolvers/avp_operations.py:25-350](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L25-L350) — `AVPResolver` class.
- Policy-store ID retrieval from tenant stack outputs: [avp_operations.py:32-98](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L32-L98).
- Authorization check Lambda: [lambdas/authorization_check.py](../../../trackon-aws-backend/src/lambdas/authorization_check.py).
- Creator-policy grant on entity create: [create_entity.py:37-139](../../../trackon-aws-backend/src/resolvers/create_entity.py#L37-L139) (`grant_creator_avp_access`), template `FullPermissionToAUserPolicyTemplateId`.
- Creator-policy backfill: [lambdas/backfill_avp_creator_policies.py:11-300](../../../trackon-aws-backend/src/lambdas/backfill_avp_creator_policies.py#L11-L300).
- Principal format `APP::User#{email}`, Resource `APP::Entity#{entityName}#{entityId}`, Cognito groups → `APP::Role` parents ([avp_operations.py:194-199](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L194-L199)).

**Limitations:**
- Template-linked policies grant **full access**; no fine-grained (read/write/field-level) scope visible.
- System-user bypass ([avp_operations.py:171-182](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L171-L182)) — no audit trail for system ops.
- Backfill is **manual Lambda invocation**; no automatic policy inheritance when a new entity is added.

## 1.e Generic data entry screens

- Dialog form renderer: [src/components/Entity/dialogFormTemplate.tsx:1-400](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx) and the large `getDialogElement()` dispatcher at [dialogFormTemplate.tsx:1517-2000](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1517).
- Field-type dispatch is a hard-coded if/else chain over `columnData.editType` (multi-select, dropdown, date, numeric, text, etc.) — **each type is hand-written Syncfusion JSX**.
- Layout form: [src/components/Entity/sfForm.tsx:19-80](../../../react-ui/src/components/Entity/sfForm.tsx#L19-L80) — accordion sections, Bootstrap grid columns derived from row length.
- Filter form: [src/components/Entity/FilterFormTemplate.tsx](../../../react-ui/src/components/Entity/FilterFormTemplate.tsx).
- Metadata contract (schema awareness): [src/components/Entity/entityManager.tsx:116-225](../../../react-ui/src/components/Entity/entityManager.tsx#L116-L225) — `Metadata.formLayout`, `addRecordFormLayout`, `editRecordFormLayout`, `tabLayout`, `sideLayout` (last two defined but underused).

**Schema-aware: 50%.** Layout structure (sections/order) is data-driven; field rendering is hard-coded.

## 1.f Workflow / flow designer UI

- Editor: [src/views/pages/Flows/WorkflowEditor.tsx:1-300](../../../react-ui/src/views/pages/Flows/WorkflowEditor.tsx) — Syncfusion `DiagramComponent` with BPMN plugin; no React Flow / dnd-kit.
- Node palette (17 node types): [src/views/pages/Flows/NodePalette.tsx:72-1023](../../../react-ui/src/views/pages/Flows/NodePalette.tsx) — `addInfo._entities` defines parameters per node.
- Parameter renderer: [src/views/pages/Flows/components/NodeFieldRenderer.tsx](../../../react-ui/src/views/pages/Flows/components/NodeFieldRenderer.tsx) — supports `TextBox`, `NumberBox`, `DropDown`, `FlowChoice`, `FlowWorkFlow`. `User` and entity-reference types fall back to TextBox.
- Sub-workflow selector: [components/FlowWorkFlow.tsx:51-180](../../../react-ui/src/views/pages/Flows/components/FlowWorkFlow.tsx#L51-L180).

See Section 4 for complete deep dive.

## 1.g Step Functions per tenant

- 35 ASL state machines under [src/statemachine/](../../../trackon-aws-backend/src/statemachine/).
- Build pipeline: [utils/step_function_management.py:38-400](../../../trackon-aws-backend/src/utils/step_function_management.py) — `build_state_machine()`, `build_states()`, `inject_node_parameters()`, `generate_parallel_state()`.
- Node → ASL templates: [src/lambdas/flow_node_templates.json](../../../trackon-aws-backend/src/lambdas/flow_node_templates.json).
- Tenant-provisioning machine: [statemachine/tenant_initialize.asl.json](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json) + [resolvers/tenant_initialize.py:20-167](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L20-L167).
- Workflow deploy (create): [resolvers/create_workflow.py:58-200+](../../../trackon-aws-backend/src/resolvers/create_workflow.py) — `check_state_machine_exists`, `deploy_state_machine`.
- Naming: `{name}-{environment}-{tenant_id}` ([create_workflow.py:152](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L152)).
- Deploy command: [Makefile:110-150](../../../trackon-aws-backend/Makefile#L110-L150) uploads ASL JSON to S3.

**Limitations:**
- **No state-machine versioning / aliases** — updates in-place via `UpdateStateMachine`; no rollback primitive. Running executions continue on old definition; nothing orchestrates cut-over.
- No template library; every workflow rebuilds from scratch.
- Failed deploy leaves orphan state machines (no cleanup visible).

## 1.h Workflow triggers from entity CRUD

- Service: [utils/workflow_triggers_service.py:65-257](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L65-L257) — `handle_workflow_triggers()`.
- Called synchronously on CREATE: [create_entity.py:521-531](../../../trackon-aws-backend/src/resolvers/create_entity.py#L521-L531). UPDATE/DELETE assumed similar in update/delete resolvers.
- Condition model: single exact-match on `attribute == value` ([workflow_triggers_service.py:152-172](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L152-L172)) — no comparison operators, no boolean composition.
- DDB Streams → changelog (S3 Tables): [lambdas/ddb_streams_changelog.py:76-300](../../../trackon-aws-backend/src/lambdas/ddb_streams_changelog.py#L76-L300).
- DDB Streams → webhooks: [lambdas/ddb_streams_webhooks.py](../../../trackon-aws-backend/src/lambdas/ddb_streams_webhooks.py).

**Limitations:**
- Trigger eval is **synchronous** in the resolver — slow triggers delay API response.
- No retry if `start_execution` fails ([line 253-254](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L253-L254) logs only).
- Tagging disabled (`# tags=tags,` commented out at [line 246](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L246)).

## 1.i Report engine

- Analytics execution resolver: [resolvers/analytics_query.py:38-294](../../../trackon-aws-backend/src/resolvers/analytics_query.py#L38-L294).
- Saved queries: [resolvers/saved_analytics_query.py:35-63](../../../trackon-aws-backend/src/resolvers/saved_analytics_query.py#L35-L63).
- Pre-built SQL: [athena/reporting_queries/](../../../trackon-aws-backend/athena/reporting_queries/) (journey_report.sql, arap_age_analysis.sql, open_contract_details.sql, shipment_pnl.sql, hedge_pnl_report.sql, …) — **hand-written, join-specific**.
- Executor: [lambdas/changelog_query_executor.py](../../../trackon-aws-backend/src/lambdas/changelog_query_executor.py).
- S3 Tables / Iceberg manager: [utils/s3tables_manager.py](../../../trackon-aws-backend/src/utils/s3tables_manager.py) (`evolve_schema`, `evolve_view`).
- Entity → table mapping: `{entityName}_log` in S3 Tables; materialised **only on first mutation** through [ddb_streams_changelog.py:76-100](../../../trackon-aws-backend/src/lambdas/ddb_streams_changelog.py#L76-L100).

**Limitations:**
- Entity-list "available for reports" is **static** — no resolver returns `listReportEntities`.
- New entities do not auto-appear until a row is mutated.
- UI report builder shows only stored `ANALYTICS_QUERY` / `REPORT_TEMPLATE` records.

## 1.j Document generation

- Jinja2 / docxtpl engine: [resolvers/generate_report.py:1-1426](../../../trackon-aws-backend/src/resolvers/generate_report.py), context prep at [1264-1298](../../../trackon-aws-backend/src/resolvers/generate_report.py#L1264-L1298), env at [1213-1224](../../../trackon-aws-backend/src/resolvers/generate_report.py#L1213-L1224) (extensions `do`, `loopcontrols`; filters `format_currency`, `format_date`; tests `empty`).
- Undeclared-variable discovery: `template.get_undeclared_template_variables()` at [1202](../../../trackon-aws-backend/src/resolvers/generate_report.py#L1202).
- Template metadata CRUD: [resolvers/create_report_template.py](../../../trackon-aws-backend/src/resolvers/create_report_template.py), [resolvers/update_report_template.py](../../../trackon-aws-backend/src/resolvers/update_report_template.py).
- Image / signature / stamp logic: [generate_report.py:187-415](../../../trackon-aws-backend/src/resolvers/generate_report.py#L187-L415).
- PDF convert: separate Lambda (`PDF_CONVERTER_FUNCTION_ARN`).
- Templates live in S3 (`templateKey`), metadata JSON in DynamoDB — no schema validation of the metadata blob.

**Limitation:** Templates can reference whatever Jinja variable they like, but the resolver must pre-fetch the data; no automatic related-entity hydration.

## 1.k Integration layer

Built-ins (all hand-coded field mappings):

- Datalastic (vessel ownership + port calls): [lambdas/fetch_datalastic_data.py:1-250+](../../../trackon-aws-backend/src/lambdas/fetch_datalastic_data.py), mapping at [168-195, 536-564](../../../trackon-aws-backend/src/lambdas/fetch_datalastic_data.py#L168-L195).
- Journey tracking (carrier APIs): [lambdas/update_journey_tracking.py:63-81](../../../trackon-aws-backend/src/lambdas/update_journey_tracking.py#L63-L81), [lambdas/fetch_journey_tracking.py](../../../trackon-aws-backend/src/lambdas/fetch_journey_tracking.py).
- Exchange rates (floatrates.com scrape): [lambdas/populate_exchange_rates.py:118-136](../../../trackon-aws-backend/src/lambdas/populate_exchange_rates.py#L118-L136).
- Stripe (subscription webhooks): [lambdas/stripe_webhook_handler.py](../../../trackon-aws-backend/src/lambdas/stripe_webhook_handler.py), [stripe_checkout_handler.py](../../../trackon-aws-backend/src/lambdas/stripe_checkout_handler.py), [stripe_portal_handler.py](../../../trackon-aws-backend/src/lambdas/stripe_portal_handler.py).
- Email (SES): [lambdas/send_email_with_attachment.py](../../../trackon-aws-backend/src/lambdas/send_email_with_attachment.py), `FIELD_LABELS` dict at [44-89](../../../trackon-aws-backend/src/lambdas/send_email_with_attachment.py#L44-L89) — 44 hard-coded contract field names.
- WhatsApp: [lambdas/send_whatsapp_notification.py:122-127](../../../trackon-aws-backend/src/lambdas/send_whatsapp_notification.py#L122-L127), [lambdas/process_whatsapp_reply.py](../../../trackon-aws-backend/src/lambdas/process_whatsapp_reply.py).
- Bedrock: [lambdas/bedrock_caller.py](../../../trackon-aws-backend/src/lambdas/bedrock_caller.py), [lambdas/process_with_bedrock.py](../../../trackon-aws-backend/src/lambdas/process_with_bedrock.py), [process_with_bedrock2.py](../../../trackon-aws-backend/src/lambdas/process_with_bedrock2.py).

**Not found in repo:** SearRates, SAP, Xero, bank-file connectors.

## 1.l CTRM primitives (Position, MTM, exposure, contract lifecycle)

- Position linking + UOM conversion: [resolvers/link_positions.py:51-1374](../../../trackon-aws-backend/src/resolvers/link_positions.py).
- Opposite-position discovery: [resolvers/list_opp_positions.py:23-31](../../../trackon-aws-backend/src/resolvers/list_opp_positions.py#L23-L31) (PurchaseContract↔SalesContract, Inventory→SalesContract).
- Profitability: [resolvers/calculate_profitability.py](../../../trackon-aws-backend/src/resolvers/calculate_profitability.py), staleness: [lambdas/mark_profitability_stale.py](../../../trackon-aws-backend/src/lambdas/mark_profitability_stale.py), recalc step function: [statemachine/recalculate_profitability_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/recalculate_profitability_step_function.asl.json).
- Hedge MTM: [lambdas/calculate_hedge_mtm.py](../../../trackon-aws-backend/src/lambdas/calculate_hedge_mtm.py) — Futures / Options (Call/Put) / Swaps / Forwards.
- Hedge close: [lambdas/close_hedge_position.py:28-160](../../../trackon-aws-backend/src/lambdas/close_hedge_position.py#L28-L160).
- Daily hedge MTM orchestration: [statemachine/hedge_daily_mtm_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/hedge_daily_mtm_step_function.asl.json).
- Contract approval: [statemachine/approve_contract_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/approve_contract_step_function.asl.json).
- Booking: [resolvers/book_purchase_sale.py:47-150](../../../trackon-aws-backend/src/resolvers/book_purchase_sale.py#L47-L150).
- Cargo ops: [statemachine/cargo_operation_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/cargo_operation_step_function.asl.json).

**Not found in repo:** counterparty credit-limit / exposure engine, initial-margin computation, portfolio VaR. Counterparty exposure is not implemented.

## 1.m Blueprint / configuration storage

- Changelog writer: [lambdas/write_changelog.py:46-100](../../../trackon-aws-backend/src/lambdas/write_changelog.py#L46-L100) — S3 Tables append, grouped by entity.
- Stream processor: [lambdas/ddb_streams_changelog.py:76-300](../../../trackon-aws-backend/src/lambdas/ddb_streams_changelog.py#L76-L300).
- Backfill / destroy: [lambdas/backfill_changelog.py](../../../trackon-aws-backend/src/lambdas/backfill_changelog.py), [lambdas/destroy_changelog.py](../../../trackon-aws-backend/src/lambdas/destroy_changelog.py).

**Evidence:** **No blueprint versioning exists today.** Entity metadata, workflow ASL, report templates, AVP policies — all stored as current-state records only. `updatedAt` timestamp is the only versioning signal. Changelog only captures *data* changes, not *definition* changes.

## 1.n Admin UI

- Main admin page: [src/views/pages/Administration/index.tsx:19-100](../../../react-ui/src/views/pages/Administration/index.tsx#L19-L100). Tabs: Users, Groups, Policies, Counters, NotificationSubscribers, CompanySetup, ValueListGroups, Import.
- Users/Groups/Policies/Counters/ValueListGroups/CompanySetup/Import — subfolders under [src/views/pages/Administration/](../../../react-ui/src/views/pages/Administration/).
- Entity schema editor: [EntityBuilder.tsx](../../../react-ui/src/components/Entity/EntityBuilder.tsx) (reachable from entity management page).
- Workflow editor: [src/views/pages/Flows/](../../../react-ui/src/views/pages/Flows/).

**Missing (not found in repo):**
- Screen designer UI.
- Blueprint version list, diff, promotion flow.
- Integration-mapping editor.
- Report builder with dynamic entity/join picker.
- Audit-log viewer for definition changes.

## 1.o Screen layout model

**Hybrid: metadata-driven structure + hard-coded field renderers.**

- Layout contract in metadata: [entityManager.tsx:116-225](../../../react-ui/src/components/Entity/entityManager.tsx#L116-L225) — `FormLayout`, `TabLayout`, `SideLayout` interfaces.
- Accordion renderer: [dialogFormTemplate.tsx:2776-2840](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L2776-L2840).
- Per-field JSX hard-coded: [dialogFormTemplate.tsx:1517-2000](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1517-L2000) — big if/else chain over `editType`.
- Grid filter layout: [components/Entity/GridFilter/GridFilter.tsx:145-342](../../../react-ui/src/components/Entity/GridFilter/GridFilter.tsx#L145-L342).

**No per-tenant layout override.** Layouts are global per entityMetadata; same form everywhere.

## 1.p Integration field mapping

Every examined integration hard-codes entity field names in Python string literals. Representative evidence:

- `fetch_datalastic_data.py` dict at [536-564](../../../trackon-aws-backend/src/lambdas/fetch_datalastic_data.py#L536-L564).
- `update_journey_tracking.py` payload at [63-81](../../../trackon-aws-backend/src/lambdas/update_journey_tracking.py#L63-L81).
- `populate_exchange_rates.py` create payload at [118-136](../../../trackon-aws-backend/src/lambdas/populate_exchange_rates.py#L118-L136).
- `send_email_with_attachment.py` FIELD_LABELS at [44-89](../../../trackon-aws-backend/src/lambdas/send_email_with_attachment.py#L44-L89) (44 literal contract field names).
- `stripe_webhook_handler.py` line 227: hard-coded `stripeCustomerId`, `stripeSubscriptionId`, `subscriptionLevel`.
- `send_whatsapp_notification.py:122-127](../../../trackon-aws-backend/src/lambdas/send_whatsapp_notification.py#L122-L127).

**No integration Lambda queries metadata at runtime.** Adding a field to an entity never reaches any integration.

---

# Section 2 — Seven-point test, graded honestly

| # | Adaptive CTRM test | Grade | Evidence of current state | What admin hits today |
|---|---|---|---|---|
| 1 | Add/modify entity with RBAC inheritance | **Partial** | Create path exists ([create_entity_metadata.py:81-190](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L81-L190)); UI ([EntityBuilder.tsx](../../../react-ui/src/components/Entity/EntityBuilder.tsx)). **No update resolver** — entity metadata is write-once. Creator policy is granted only if `useAvp=true` ([create_entity.py:37-139](../../../trackon-aws-backend/src/resolvers/create_entity.py#L37-L139)); role-based policies for *new* entities must be backfilled manually ([backfill_avp_creator_policies.py](../../../trackon-aws-backend/src/lambdas/backfill_avp_creator_policies.py)). | Admin can create an entity but cannot change it after the fact; other roles won't get permissions until an engineer runs backfill. |
| 2 | Add/modify a field with validation + computed values | **Fail** | No update path for metadata attributes; no regex/min/max/conditional validation in schema; no field-level expression engine (only key-generation placeholders at [entity_manager.py:129-186](../../../trackon-aws-backend/src/utils/entity_manager.py#L129-L186)). | Admin has no UI to add a field after creation; no place to declare a validation rule; no formula language for derived fields. |
| 3 | Design/modify a screen | **Fail** | Layouts live in metadata but field renderers are a hard-coded Syncfusion JSX cascade ([dialogFormTemplate.tsx:1517-2000](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1517-L2000)). No designer UI anywhere in `src/views/pages/`. No conditional visibility, no action buttons, no tabs configured per tenant. | Admin can't lay out a screen; any change requires editing metadata JSON by hand, and any new field type requires React code. |
| 4 | Add/modify a workflow triggered by entity CRUD | **Partial** | BPMN designer exists ([WorkflowEditor.tsx](../../../react-ui/src/views/pages/Flows/WorkflowEditor.tsx)) but exposes 17 nodes vs 35 production step functions; parameter-injection pipeline ([step_function_management.py:125-136](../../../trackon-aws-backend/src/utils/step_function_management.py#L125-L136)) silently drops Wait/Approval/AiStep/Timeout params; no Map/Pass/Retry/Catch nodes. Trigger evaluation is exact-match only ([workflow_triggers_service.py:152-172](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L152-L172)). | Admin designs a workflow, but many nodes silently misbehave; common patterns (batch, retry, conditional trigger) are impossible. |
| 5 | Surface new entities/fields in reports | **Fail** | Reports use hand-written SQL (`athena/reporting_queries/*.sql`); no `listReportEntities` resolver; `{entityName}_log` Iceberg table only materialises after first mutation ([ddb_streams_changelog.py:76-100](../../../trackon-aws-backend/src/lambdas/ddb_streams_changelog.py#L76-L100)); no join generator. | A new entity does not appear in the report builder; an admin can't build a parameterised report without an engineer writing SQL. |
| 6 | Generate documents that reference new fields | **Partial** | Jinja2 templates dynamically enumerate variables ([generate_report.py:1202](../../../trackon-aws-backend/src/resolvers/generate_report.py#L1202)). Missing variables → empty string (silent). But templates depend on a pre-fetched context; the resolver is keyed to known entity types, and the DOCX must be authored in Word. | Admin could reference a new field in a template if it's in the context the resolver already builds — but the resolver has to know to fetch it. Non-trivial in practice. |
| 7 | Integrations pick up new fields without code changes | **Fail** | Every integration hard-codes field names (Section 1.p). No mapping descriptor entity, no generic adapter Lambda. | New fields are invisible to every integration until an engineer ships a new Lambda version. |
| — | Versionable with diff / rollback / migration | **Fail** | No blueprint tables, no ASL alias versioning ([step_function_management.py](../../../trackon-aws-backend/src/utils/step_function_management.py)), no snapshot store, no migration executor. Changelog is data-only. | No rollback of configuration; a broken metadata change has no undo. |

**Overall: 0 Pass, 3 Partial, 4 Fail (+ versioning Fail)** — not defensible as "Adaptive CTRM" today.

---

# Section 3 — Gap list, prioritized

## Blockers (must ship before claiming Adaptive CTRM)

### B1. Entity metadata is write-once — no `update_entity_metadata`
- **Gap:** [src/resolvers/](../../../trackon-aws-backend/src/resolvers/) has `create_entity_metadata.py` but no `update_entity_metadata.py`. Admins cannot change a field after definition.
- **Blocks:** points 1 and 2 of the seven-point test.
- **Evidence:** file list confirms create-only; [s3tables_manager.py](../../../trackon-aws-backend/src/utils/s3tables_manager.py) already supports Iceberg schema evolution, so the plumbing exists.
- **Approach:** new `update_entity_metadata.py` resolver; diff old vs new; call `evolve_schema`/`evolve_view` for S3 Tables; invalidate cache in `entity_manager.py`; gated by blueprint promotion (see B6).
- **Effort:** ~2 weeks (1 wk resolver + diff + cache invalidation, 1 wk tests + UI wiring in EntityBuilder).

### B2. Schema-driven screen designer + generic renderer
- **Gap:** no designer UI; field rendering is a hard-coded JSX cascade ([dialogFormTemplate.tsx:1517-2000](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1517-L2000)). Blocks point 3 entirely.
- **Approach:** JSON ScreenLayout descriptor (see Section 4b) + `<FieldRenderer>` component + dnd-kit designer. Descriptor stored per entity/tenant, versioned with blueprint.
- **Effort:** ~11–14 dev-weeks (Section 4b.8).

### B3. Flow designer parity with Step Functions
- **Gap:** UI exposes 17 nodes; backend has 35 state machines. Injection pipeline silently drops parameters. No Map/Pass/Retry/Catch.
- **Blocks:** point 4.
- **Evidence:** Section 4 deep dive; [step_function_management.py:125-136](../../../trackon-aws-backend/src/utils/step_function_management.py#L125-L136), [NodePalette.tsx](../../../react-ui/src/views/pages/Flows/NodePalette.tsx), [flow_node_templates.json](../../../trackon-aws-backend/src/lambdas/flow_node_templates.json).
- **Approach:** fix `inject_node_parameters` for top-level fields (Wait/Timeout/Approval emails/AI), add Map/Pass/Retry-config nodes, expose hedging + financial workflows, wire workflow `parameters` into execution input ([start_workflow.py:77-96](../../../trackon-aws-backend/src/resolvers/start_workflow.py#L77-L96)).
- **Effort:** ~6–8 dev-weeks (2 wks P1 injection fixes, 3 wks new node types + retry UI, 2 wks hedge category, 1 wk execution-input plumbing + tests).

### B4. Report auto-discovery + dynamic join builder
- **Gap:** no `listReportEntities`; reports are hand-written SQL; no join generator. Blocks point 5.
- **Approach:** new `list_report_entities` resolver reading metadata; `REPORT_BUILDER_TEMPLATE` entity with `{{baseTableName}}` placeholders; metadata-driven join generator from `referentialConstraints`; step-function hook in [create_entity_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/create_entity_step_function.asl.json) to register a default browse query per new entity.
- **Effort:** ~5–7 dev-weeks (0.5 resolver, 1.5 template + renderer, 1 dynamic report resolver, 0.5 step function wiring, 1 UI, 1 testing/edges).

### B5. Integration mapping layer
- **Gap:** every integration hard-codes fields. Blocks point 7.
- **Approach:** `INTEGRATION_FIELD_MAPPING` entity (Section 6); generic `apply_integration_mapping` Lambda; migrate integrations one at a time with fallback to current behaviour.
- **Effort:** ~7–9 dev-weeks (1 wk infra + 1 wk per integration × 5 + 1 wk buffer). Only Datalastic + one journey/carrier integration are *strictly* required for the v1 claim (~3 wks).

### B6. Blueprint versioning (5-table design + alias flip + migration executor)
- **Gap:** no versioning exists. Blocks the "versionable with diff, rollback, safe migration" requirement that runs across all seven points.
- **Approach:** 5 DynamoDB item types (BLUEPRINT / VERSION / SNAPSHOT / CHANGE / DEPLOYMENT) on the existing universal table; new resolvers in `src/resolvers/blueprint_*.py`; alias-based Step Function versioning replacing in-place `UpdateStateMachine`; migration executor for the eight change types (Section 5.5); admin UI.
- **Effort:** ~13 dev-weeks (Section 5.6), 16 wks with integration buffer.

### B7. Field-level RBAC surfaced in the renderer
- **Gap:** AVP only grants instance-level full access ([avp_operations.py:149-250](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L149-L250)); no field-level policy; no renderer consultation. Without it, "screens per role" is impossible — half of point 3 disappears.
- **Approach:** extend authorization_check to return a field-read/write map; add `rbacRules` section in ScreenLayout descriptor; renderer hides/locks fields.
- **Effort:** ~2–2.5 dev-weeks (part of Section 4b.8 M4).

## Should-fix (weaken the claim but don't block launch)

### S1. Validation rules language
- **Gap:** metadata has only `required`/`immutable`; no regex, min/max, conditional required. Point 2 is only half delivered without this.
- **Approach:** add `validation` block to attribute metadata (JSON Logic predicates + primitive constraints); validate in [create_entity.py:444-459](../../../trackon-aws-backend/src/resolvers/create_entity.py#L444-L459) and the future `update_entity_metadata`.
- **Effort:** ~1.5 wks.

### S2. Computed-field expression engine
- **Gap:** only key-generation placeholder substitution exists. Derived values can't be declared in metadata.
- **Approach:** vendor a small expression language (JSONLogic or Jexl) evaluated in `format_dynamodb_data` + UI live-eval in `<FieldRenderer>`.
- **Effort:** ~2 wks.

### S3. Workflow trigger condition language
- **Gap:** only exact-match in [workflow_triggers_service.py:152-172](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L152-L172).
- **Approach:** replace with JSONLogic predicate evaluated against `new_data` + `previous_data`.
- **Effort:** ~1 wk.

### S4. Async trigger dispatch
- **Gap:** synchronous `start_execution` in the CRUD resolver delays API response; failed starts are fire-and-forget.
- **Approach:** SQS buffer between resolver and trigger service with DLQ + retry.
- **Effort:** ~1 wk.

### S5. Integration audit + retry
- **Gap:** most integrations log errors but do not retry or alert.
- **Approach:** emit CloudWatch metric + structured log + optional DLQ per integration.
- **Effort:** ~1 wk.

### S6. Counterparty exposure engine
- **Gap:** not implemented. Not strictly required by "Adaptive CTRM" definition but expected in a CTRM product.
- **Approach:** new POSITION aggregator over SUB_ACCOUNT; credit-limit definitions per counterparty; real-time exposure recomputation on position change.
- **Effort:** ~4 wks.

### S7. Descriptor lint + referential-integrity CLI
- **Gap:** when a field is renamed/deleted, downstream descriptors (screens, reports, templates, workflows) silently break.
- **Approach:** lint Lambda + CI gate; auto-migrate descriptors on metadata update.
- **Effort:** ~1.5 wks.

## Nice-to-have

### N1. AI-assisted layout suggestions inside the screen designer (Canva-style)
### N2. Pre-built node packs per domain (treasury, logistics, KYC)
### N3. Scheduled-deploy windows for blueprint promotion
### N4. Read-only "what-if" diff UI comparing two staging branches
### N5. Cross-tenant shared blueprints (opt-in)
### N6. SAP/Xero/bank-file connectors (once the mapping layer lands)

---

# Section 4 — Flow designer deep dive

## 4.1 Current UI node inventory (17 node types)

Source: [NodePalette.tsx:72-1023](../../../react-ui/src/views/pages/Flows/NodePalette.tsx), rendered via [NodeFieldRenderer.tsx](../../../react-ui/src/views/pages/Flows/components/NodeFieldRenderer.tsx).

| Node | Line | Parameters | Backend target |
|---|---|---|---|
| StartStep | 63-92 | DESCRIPTION | Start logic in [step_function_management.py:89-101](../../../trackon-aws-backend/src/utils/step_function_management.py#L89-L101) |
| EndStep | 94-122 | DESCRIPTION | Succeed state |
| Choice | 124-152 | DESCRIPTION, CHOICE (FlowChoice branches) | Choice state, rules at [step_function_management.py:253-357](../../../trackon-aws-backend/src/utils/step_function_management.py#L253-L357) |
| WaitNode | 154-186 | MONTHS/DAYS/HOURS/MINUTES/SECONDS | `flow_node_templates.json:11-16` — **hard-coded 30s** |
| ErrorNode | 188-218 | DESCRIPTION | Fail state |
| ApprovalStep | 223-259 | DESCRIPTION, APPROVALEMAILTO/CC/TEMPLATE, TimeOutSeconds, HearBeatSeconds | ApprovalStateMachineArn |
| ShipmentStep | 261-308 | DESCRIPTION, CHECKPOINT, ACCOUNT, assignedTo, ReportTemplates, TimeOut/Heartbeat | ShipmentStepStateMachineArn |
| EmailNode | 310-348 | DESCRIPTION, EMAIL | SendEmailLambdaArn |
| PlainActivity | 350-379 | DESCRIPTION, TimeOut/Heartbeat | PlainActivityStateMachineArn |
| ExtractDocumentData | 381-415 | DESCRIPTION, DOCUMENTKEY, ENTITYNAMES, MODELID, PROMPT | ExtractDocumentDataStateMachineArn |
| ProcessDocument | 417-460 | DESCRIPTION, ENTITYID | SingleDocumentProcessingStateMachineArn |
| ValidateChecklists | 463-505 | DESCRIPTION | ValidateChecklistsStateMachineArn |
| FetchJourneyTracking | 507-549 | DESCRIPTION | FetchJourneyTrackingStateMachineArn |
| VesselAnalysis | 555-598 | DESCRIPTION, ENTITYID | VesselAnalysisStateMachineArn |
| QCCycle | 600-643 | DESCRIPTION | QCCycleStateMachineArn → [do_qc_cycle_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/do_qc_cycle_step_function.asl.json) |
| WhatsApp | 979-1023 | DESCRIPTION, NUMBER, MESSAGE | SendWhatsAppLambdaArn |
| ParallelNode | 648-693 | DESCRIPTION | Parallel state ([step_function_management.py:192-231](../../../trackon-aws-backend/src/utils/step_function_management.py#L192-L231)) |
| FlowNode | 695-734 | DESCRIPTION, WORKFLOW (selector) | Nested state-machine invoke |
| AiStep | 736-785 | DESCRIPTION, PROMPT, AIMODEL, COMPONENT | ProcessWithBedrockFunction |

Parameter-renderer coverage ([NodeFieldRenderer.tsx](../../../react-ui/src/views/pages/Flows/components/NodeFieldRenderer.tsx)): `TextBox`, `NumberBox`, `DropDown` (inline datasource), `FlowChoice`, `FlowWorkFlow`. `User` and entity-reference types fall back to plain TextBox (lines 134-192).

## 4.2 Backend Step Functions inventory (35 machines)

Source: [src/statemachine/](../../../trackon-aws-backend/src/statemachine/).

Key machines exercised in production but not in the UI palette:

- `hedge_daily_mtm_step_function.asl.json` — batch MTM via Map state.
- `hedge_mtm_price_trigger_step_function.asl.json` — price-triggered hedging.
- `hedge_recommendation_step_function.asl.json` — hedge-rec generation.
- `hedge_settlement_step_function.asl.json` — swap/reset settlement.
- `recalculate_profitability_step_function.asl.json` — batch profitability.
- `auto_resolve_discrepancies_step_function.asl.json` — auto-resolve DI.
- `task_token_collector_step_function.asl.json` — long-running task tokens.
- `approve_contract_step_function.asl.json`, `cancel_contract_step_function.asl.json`, `close_contract_step_function.asl.json`, `callback_contract_step_function.asl.json`, `approve_amendment_step_function.asl.json`, `convert_entity_step_function.asl.json`, `approve_payment_request_step_function.asl.json`, `cargo_operation_step_function.asl.json` — lifecycle orchestrators not surfaced.
- `tenant_initialize.asl.json` — system only; calls CloudFormation, Cognito, DynamoDB SDK directly. Rightly not a user workflow.

Full ARN substitution list: [create_workflow.py:193-252](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L193-L252).

## 4.3 Gap analysis

### 4.3.a Backend actions missing from the palette

| Missing capability | Production evidence |
|---|---|
| Hedge domain (daily MTM, recommendation, settlement, price-trigger) | `hedge_*.asl.json` |
| Contract lifecycle (approve/cancel/close/callback/convert) | `approve_contract_*`, `close_contract_*`, `convert_entity_*`, `approve_amendment_*` |
| Profitability recalc | `recalculate_profitability_step_function.asl.json` |
| Auto-resolve discrepancies | `auto_resolve_discrepancies_step_function.asl.json` |
| Batch / Map iteration | `hedge_daily_mtm_step_function.asl.json` uses `Type: Map, MaxConcurrency: 5` |
| Pass / data transform | Used in `hedge_daily_mtm_step_function.asl.json` Pass states |
| Retry + Catch config | Every production machine has retries; UI has none |
| Task-token (activity) callback | `task_token_collector_step_function.asl.json` |
| Direct AWS SDK tasks (CloudFormation / DynamoDB / SES / SQS) | `tenant_initialize.asl.json` |

### 4.3.b UI nodes with broken end-to-end wiring

| Node | Broken behaviour | Root cause |
|---|---|---|
| WaitNode | UI time inputs ignored; waits always 30s | [flow_node_templates.json](../../../trackon-aws-backend/src/lambdas/flow_node_templates.json) hard-codes `"Seconds": 30` and [step_function_management.py:125-136](../../../trackon-aws-backend/src/utils/step_function_management.py#L125-L136) doesn't promote to top-level |
| ApprovalStep | Email TO/CC/template lost | No `${PLACEHOLDER}` in approval template; injector only writes into `Input.parameters` |
| ShipmentStep | `assignedTo` (User), `ACCOUNT` stored as raw strings | NodeFieldRenderer lacks User / entity-ref handlers |
| ExtractDocumentData | `ENTITYNAMES` sent as string, backend expects array | UI type = `TextBox`; ASL expects `[]` |
| AiStep | `COMPONENT` dropdown ignored, modelId hard-coded | AiStep handled in `build_states()` with inline ASL, not the template |
| Any Task node | `TimeOutSeconds` / `HearBeatSeconds` collected but not injected | Injector doesn't write to `TimeoutSeconds` / `HeartbeatSeconds` of the state |

### 4.3.c Workflow parameters never reach execution

[start_workflow.py:77-96](../../../trackon-aws-backend/src/resolvers/start_workflow.py#L77-L96) builds the execution input from `tenantId`, `entityName`, `entityId`, `record` only. The stored `workflow.parameters` blob (per-node config) is not passed. Even if injection were fixed, runtime configuration overrides are impossible.

### 4.3.d Trigger condition language too weak

[workflow_triggers_service.py:152-172](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L152-L172) is exact-match only. Cannot express `status changed to Active AND quantity > 0`.

## 4.4 What needs to change (within existing architecture)

Ordered by cost × value.

1. **Rewrite `inject_node_parameters`** ([step_function_management.py:125-136](../../../trackon-aws-backend/src/utils/step_function_management.py#L125-L136)) to (a) sum Wait duration into `state["Seconds"]`, (b) write Task `TimeoutSeconds` / `HeartbeatSeconds`, (c) inject approval email fields into `Input`, (d) inject AI `prompt` / `modelId` / `component` into `Payload`, (e) convert `ENTITYNAMES` to array.
2. **Add Map and Pass nodes** with corresponding templates in `flow_node_templates.json` and handlers in `build_states()`.
3. **Add retry/catch config** in `PropertiesPanel.tsx` + ASL injection in `build_states()`.
4. **Implement User / entity-reference field types** in `NodeFieldRenderer.tsx`.
5. **Expose hedge + contract-lifecycle + profitability categories** as new nodes backed by existing state machines; extend ARN-substitution map in [create_workflow.py:193-252](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L193-L252).
6. **Pass workflow parameters into execution input** in [start_workflow.py:77-96](../../../trackon-aws-backend/src/resolvers/start_workflow.py#L77-L96).
7. **Replace exact-match triggers with JSONLogic** in [workflow_triggers_service.py:152-172](../../../trackon-aws-backend/src/utils/workflow_triggers_service.py#L152-L172).
8. **Use Step Functions alias versioning** (required by B6 blueprint versioning).

**Total flow-designer effort to reach parity: ~6–8 dev-weeks.**

---

# Section 4b — Screen designer design

## 4b.1 Current form/screen renderer

- Entry: [dialogFormTemplate.tsx:2776-2840](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L2776-L2840) — accordion renderer iterates `formLayout`.
- Layout model: [entityManager.tsx:116-225](../../../react-ui/src/components/Entity/entityManager.tsx#L116-L225) — `FormLayout`, `TabLayout`, `SideLayout`.
- Field-type dispatch: [dialogFormTemplate.tsx:1517-2000](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1517-L2000) — hard-coded Syncfusion JSX per `editType`.
- Grid/filter: [sfForm.tsx](../../../react-ui/src/components/Entity/sfForm.tsx), [GridFilter.tsx](../../../react-ui/src/components/Entity/GridFilter/GridFilter.tsx).
- Deps ([package.json](../../../react-ui/package.json)): Syncfusion ej2-react-* 30.2.x, `react-hook-form`, `yup`, React 18.3.1, `antd`, `@mui/material` (dormant). No `react-jsonschema-form`, no `dnd-kit`, no `react-dnd`.

## 4b.2 Schema awareness today

~50% schema-driven. Layout structure (sections/order) reads from metadata; field-renderer choice and JSX are hard-coded. Adding a new field type requires editing `getDialogElement`.

## 4b.3 Proposed JSON descriptor

Tabs → sections (columns, collapsible, visibility rule) → fields (type, label, help, gridColumnSpan, visibility, readOnlyIf, computedFrom, validation, options, refEntity). Top-level `actions[]` (submit / workflow / close), `rbacRules[]` (fieldId × role × read/write), `metadata.version` + `blueprintId`. Visibility expressed as JSONLogic. Full example in the research below — structural shape locked as:

```
ScreenLayout {
  screenLayoutVersion, entityName, layoutName, tabs[], actions[], rbacRules[], metadata
}
Field { fieldId, type, label, gridColumnSpan, required, readOnly, visibilityRule, validation, options, refEntity, displayField, onChangeActions, computedFrom }
```

JSON-Schema for the descriptor lives in `src/screen-designer/descriptor.schema.json` (new) and is enforced with `ajv` (add to [package.json](../../../react-ui/package.json) dependencies).

## 4b.4 Designer library choice

Options evaluated: `react-dnd`, `dnd-kit`, `react-grid-layout`, `Craft.js`, `react-jsonschema-form`.

**Recommendation: `dnd-kit` (@dnd-kit/core + @dnd-kit/sortable).** Reasoning:
- Smaller bundle (~50KB gz) vs react-dnd (~80KB).
- Nested sortables map naturally to tabs→sections→fields.
- ARIA accessibility baked in.
- First-class TypeScript + React 18 compatibility.

Designer surface: left palette (field types) · centre canvas (live preview using the same `<FieldRenderer>` the production renderer uses) · right inspector (field/section/tab/action/RBAC editors). Save/load via a new `screenLayouts` GraphQL resolver, descriptor validated with `ajv` pre-save.

## 4b.5 Metadata-integrity

Descriptor references fields by `fieldId`. On metadata update (delete/rename), an `updateScreenDescriptors` Lambda consumes an `EntityMetadataUpdated` SNS event and either (a) rewrites renames, (b) removes deleted fields, (c) flags type changes for manual review, and (d) writes the old descriptor as a versioned copy. A `lint-descriptors` CLI gates CI.

## 4b.6 Field-level RBAC

Extend [authorization_check.py](../../../trackon-aws-backend/src/lambdas/authorization_check.py) with `check_field_access(tenantId, entityName, fieldId, action, principal)` querying AVP with action namespace `{entity}.field.{field}.{read|write}`. Embed `rbacRules` in descriptor; renderer hides read-denied fields and sets `readOnly` on write-denied.

## 4b.7 Blueprint versioning integration

Descriptor stored in DynamoDB as entity `SCREEN_DESCRIPTOR#{entityName}#{layoutName}`; included in the blueprint snapshot capture (Section 5.3). Version tag + `blueprintId` in descriptor metadata.

## 4b.8 Effort estimate

11–14 dev-weeks total:

| Milestone | Weeks |
|---|---|
| 1. Descriptor format + AJV validator | 1.5–2 |
| 2. Generic `<FieldRenderer>` (replace getDialogElement dispatch) | 3–3.5 |
| 3. Designer UI + dnd-kit canvas + inspector | 3–3.5 |
| 4. RBAC integration | 2–2.5 |
| 5. Metadata sync + lint | 2–2.5 |
| 6. Blueprint versioning hookup | 1.5–2 |
| 7. Polish, E2E tests, docs | 2–3 |

Critical path: M1 → M2 → M3. M4/M5 can parallel M3 polish.

---

# Section 5 — Blueprint versioning design

## 5.1 Where the tables fit

Existing storage is one universal DynamoDB table ([cloudformation.yaml:514-605](../../../trackon-aws-backend/templates/cloudformation.yaml#L514-L605)) with PK/SK + 6 GSIs, stream on. All five blueprint artefacts reuse this table with new PK/SK patterns — **no new infrastructure tables required**:

| Item | PK | SK |
|---|---|---|
| BLUEPRINT (current state) | `T#{tenant}` | `BLUEPRINT#{id}` |
| BLUEPRINT_VERSION (immutable) | `T#{tenant}` | `BLUEPRINT_VERSION#{id}#v{n}` |
| BLUEPRINT_SNAPSHOT (gzip+base64 JSON) | `T#{tenant}` | `BLUEPRINT_SNAPSHOT#{snapshotId}` |
| BLUEPRINT_CHANGE (semantic diff) | `T#{tenant}` | `BLUEPRINT_CHANGE#{id}#v{n}#change{seq}` |
| BLUEPRINT_DEPLOYMENT (audit) | `T#{tenant}` | `BLUEPRINT_DEPLOYMENT#{deploymentId}` |

GSI1 on `BLUEPRINT#{id}` → version list; GSI2 on `BLUEPRINT_DEPLOYMENT#{id}` → deployment timeline.

Off-site backup: S3 versioned bucket at `s3://{bucket}/blueprints/{tenantId}/{blueprintId}/{version}/snapshot.json.gz`.

## 5.2 Module ownership

| Module | File (new) |
|---|---|
| CRUD + lifecycle | `src/resolvers/blueprint_operations.py` |
| Snapshot capture | `src/resolvers/blueprint_snapshot.py` |
| Semantic diff | `src/resolvers/blueprint_diff_engine.py` |
| Deploy + alias flip | `src/lambdas/blueprint_deploy.py` |
| Migration executor | `src/lambdas/blueprint_migration_executor.py` |
| S3 backup | `src/resolvers/blueprint_s3_backup.py` |

## 5.3 Integration points with current metadata store

| Artefact | Current storage | Capture | Restore |
|---|---|---|---|
| Entity definitions | DDB `METADATA#ENTITY#{name}` ([create_entity_metadata.py:81-190](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L81-L190)) | `capture_entity_definitions()` | Invoke create/update_entity_metadata (idempotent on hash) |
| Workflows | DDB WORKFLOW items + inline ASL ([create_workflow.py:22-27](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L22-L27)) | `capture_workflows()` includes graph + ASL | `update_workflow.py` + alias flip (5.4) |
| Screen descriptors | New entity `SCREEN_DESCRIPTOR#{name}#{layoutName}` | `capture_screen_descriptors()` | Put item + UI cache invalidate |
| Report templates | DDB metadata + S3 `.docx` ([create_report_template.py](../../../trackon-aws-backend/src/resolvers/create_report_template.py), [reports/templates/](../../../trackon-aws-backend/reports/templates/)) | Pull metadata + download S3 objects | Re-upload to S3 + put DDB |
| Document templates | S3 under `reports/templates/` | List + download | Re-upload |
| AVP policies | AVP policy store ([avp_operations.py:32-98](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L32-L98)) | `GetPoliciesAndSchema` API | `BatchWritePolicies` |
| Integration mappings | New `INTEGRATION_FIELD_MAPPING` (Section 6) | Query items | Put items |

## 5.4 Step Functions deploy changes

Current: [create_workflow.py:186-295](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L186-L295) creates/updates state machines in place; [update_workflow.py:62-98](../../../trackon-aws-backend/src/resolvers/update_workflow.py#L62-L98) does `UpdateStateMachine`.

Change to alias model:
1. On create: `create_state_machine` as `{name}-{env}-{tenant}-v1`; `create_alias` `{name}-{env}-{tenant}-live` → v1.
2. On workflow update in a draft blueprint: create a new version `vN` alongside; record ARN in `BLUEPRINT_VERSION.workflows[].stagingStateMachineArn`.
3. On promote-to-published: `update_alias` to point live → vN. Triggers (Section 1.h) call the **alias**, so in-flight executions on vN-1 complete undisturbed; all new executions use vN.
4. Rollback promote = point alias back to vN-1.

Files to touch: [create_workflow.py](../../../trackon-aws-backend/src/resolvers/create_workflow.py), [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py), `workflow_triggers_service.py` (swap ARN construction to alias ARN), [start_workflow.py](../../../trackon-aws-backend/src/resolvers/start_workflow.py).

## 5.5 Migration executor — change types & handlers

| Change type | Forward | Rollback |
|---|---|---|
| add_field_nullable | Add to metadata; S3 Tables evolve (already supported by `evolve_schema` in [s3tables_manager.py](../../../trackon-aws-backend/src/utils/s3tables_manager.py)) | Drop from metadata; column stays in Iceberg history |
| add_field_required_with_default | Metadata + backfill existing items (`UpdateItem` with `attribute_not_exists` guard) | Remove field; clean items |
| soft_delete_field | Mark deprecated in metadata; hide in UI; keep data | Un-mark deprecated |
| rename_field | Copy data to new name; add alias view in Iceberg | Copy back; drop new |
| add_entity | Call `create_entity_metadata` (idempotent by hash) | Archive entity |
| archive_entity | Set state=ARCHIVED, hide from lists | Restore state=ACTIVE |
| workflow_changed | Deploy new SF version; capture ARN | Alias flip back |
| report_template_changed | Upload new S3 object + put metadata | Restore prior S3 version (bucket is versioned) |
| avp_policy_changed | `BatchWritePolicies` new | `BatchWritePolicies` prior export |

All handlers are idempotent (read current state first, skip if match) and log to `BLUEPRINT_DEPLOYMENT.migrationLog`.

## 5.6 Milestone plan

| Milestone | Content | Dev-days |
|---|---|---|
| M1. CRUD + lifecycle | 5 entity types, GraphQL, auth | 10 |
| M2. Snapshot capture | Six capture functions + S3 backup | 15 |
| M3. Semantic diff | Entity/field/workflow/report/AVP diffs, UI-ready payload | 15 |
| M4. Lifecycle (draft/staging/published, rollback) | State transitions | 10 |
| M5. Alias flip | `blueprint_deploy.py` + `create/update_workflow.py` edits | 5 |
| M6. Migration executor | 9 handlers + tests | 12 |
| M7. Admin UI | Version list, diff view, promote/rollback | 5 |
| **Total** | | **72 dev-days ≈ 13 weeks** |

Add 20% buffer → **16 weeks** realistic.

---

# Section 6 — Integration field mapping

## 6.1 Current state

All examined integrations hard-code fields (details in Section 1.p):

- Datalastic: [fetch_datalastic_data.py:168-195, 536-564](../../../trackon-aws-backend/src/lambdas/fetch_datalastic_data.py#L168-L195).
- Journey tracking: [update_journey_tracking.py:63-81](../../../trackon-aws-backend/src/lambdas/update_journey_tracking.py#L63-L81).
- Exchange rates: [populate_exchange_rates.py:118-136](../../../trackon-aws-backend/src/lambdas/populate_exchange_rates.py#L118-L136).
- Stripe: [stripe_webhook_handler.py:227](../../../trackon-aws-backend/src/lambdas/stripe_webhook_handler.py#L227).
- Email: [send_email_with_attachment.py:44-89](../../../trackon-aws-backend/src/lambdas/send_email_with_attachment.py#L44-L89).
- WhatsApp: [send_whatsapp_notification.py:122-127](../../../trackon-aws-backend/src/lambdas/send_whatsapp_notification.py#L122-L127).
- Bedrock: [bedrock_caller.py](../../../trackon-aws-backend/src/lambdas/bedrock_caller.py).

**No grep result for any integration Lambda calling metadata-resolver.** Conclusion: new fields never reach integrations.

## 6.2 Mapping layer design

New entity `INTEGRATION_FIELD_MAPPING`:

```json
{
  "id": "DATALASTIC#JOURNEY#v1",
  "tenantId": "...",
  "integrationName": "datalastic",
  "sourceEntityName": "VesselOwnership",
  "targetEntityName": "JOURNEY",
  "fieldMappings": {
    "imo":         { "targetField": "imoNumber",   "type": "string", "required": true },
    "vessel_name": { "targetField": "vesselName",  "type": "string" },
    "flag":        { "targetField": "flag",        "type": "string", "transformer": "extractCountryCode" }
  },
  "status": "Active",
  "version": 1
}
```

Storage: same DynamoDB table, PK `T#{tenant}#MAPPING#INTEGRATION`, SK `{integration}#{source}#{target}#v{n}`.

New generic adapter Lambda `src/lambdas/apply_integration_mapping.py` reads the mapping, applies optional transformers, and calls `create_entity` / `update_entity`. Each existing integration Lambda changes to: fetch external API → call `apply_integration_mapping` with source payload (fallback to hard-coded logic behind a feature flag for 1 release).

## 6.3 Migration plan & effort

| Phase | Work | Weeks |
|---|---|---|
| 1 | Schema + adapter Lambda | 1 |
| 2 | Datalastic cut-over with fallback flag | 2 |
| 3 | WhatsApp, Email FIELD_LABELS, Bedrock, exchange rates | 4 |
| 4 | Remove fallbacks, lint | 1 |

**Total 7–9 dev-weeks. Minimum viable for the Adaptive CTRM claim: ~3 wks** (adapter + Datalastic + one carrier). Versioned inside the blueprint.

---

# Section 7 — Report auto-discovery

## 7.1 Current enumeration

Static. Evidence:
- [analytics_query.py:113-125](../../../trackon-aws-backend/src/resolvers/analytics_query.py#L113-L125) fetches a specific `ANALYTICS_QUERY` by id.
- Pre-written SQL under [athena/reporting_queries/](../../../trackon-aws-backend/athena/reporting_queries/): e.g. `journey_report.sql` joins `journey_log`, `sub_account_log`, `contract_trader_log`, `linking_log`, `product_log` by hand.
- UI: [src/graphql/queries/reportQueries.js:3-27](../../../react-ui/src/graphql/queries/reportQueries.js#L3-L27) — only `LIST_REPORT_TEMPLATES` / `GET_REPORT_TEMPLATE`; no `listReportEntities`.

No resolver returns "entities available for reporting"; no SQL template language.

## 7.2 What changes

1. New resolver `src/resolvers/list_report_entities.py`: query `PK = T#{tenant}#METADATA#ENTITY`, return name + attributes + `referentialConstraints` + `detailEntities`.
2. New entity `REPORT_BUILDER_TEMPLATE` storing parameterised SQL with `{{baseTableName}}` / `{{joinTable}}` placeholders.
3. New resolver `src/resolvers/generate_dynamic_report.py`: take base entity + join list, build JOINs from `referentialConstraints` in metadata, render SQL, execute through the existing changelog executor.
4. Patch [create_entity_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/create_entity_step_function.asl.json) to invoke a new `register_entity_in_report_layer` Lambda that auto-creates a default "Browse {entity}" query.
5. UI report builder consumes `listReportEntities` for the entity/join picker.

## 7.3 Joins today

Declared in metadata via `referentialConstraints` + `detailEntities`, but **not consumed** by the SQL layer. Join generator (pseudo-code in Section 7.3 of research) walks `referentialConstraints` to emit `INNER JOIN {other}_log ON {base}.{fk} = {other}.id`.

## 7.4 Entity → Iceberg table

[create_entity_metadata.py:151-168](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L151-L168) calls `create_or_evolve_view(create_view=False)` — table is created in Iceberg catalog immediately, **but only becomes populated after the first DDB-stream changelog event**. New entities therefore exist to Athena but queries return empty until data arrives.

## 7.5 Effort

~5.5–6.5 dev-weeks (0.5 resolver + 1.5 template + 1 generate + 0.5 step-function hook + 1 UI + 1 test/edges).

---

# Section 8 — Total effort summary

## 8.1 Blocker table

| # | Blocker | Dev-weeks | Depends on | Risk | Suggested owner |
|---|---|---|---|---|---|
| B1 | update_entity_metadata resolver | 2 | — | Low | Bibeesh |
| B2 | Screen designer + JSON descriptor + generic renderer | 11–14 | B1, B6 | High (UX + scope) | Bibeesh + contractor |
| B3 | Flow designer parity with Step Functions | 6–8 | — | Medium | Bibeesh |
| B4 | Report auto-discovery + dynamic joins | 5–7 | B1 | Medium | Contractor |
| B5 | Integration mapping layer (MVP: 3 integrations) | 3 (MVP) / 7–9 (full) | B1, B6 | Medium | Contractor |
| B6 | Blueprint versioning (5 tables + alias flip + migrations + admin UI) | 13–16 | — | High (most cross-cutting) | Bibeesh |
| B7 | Field-level RBAC in renderer | 2–2.5 | B2 | Low | Bibeesh |

**Sum of MVP blocker work: ~42–52 dev-weeks.**

## 8.2 Scenarios

### Scenario A — Bibeesh solo full-time

Assume 45 productive weeks per year after holidays / incidents / customer support. Sequence respecting dependencies:

1. B1 (2) → B6 M1–M4 (10) → B3 (7) → B2 M1–M3 (8) → B6 M5–M7 (6) → B7 (2) → B2 M4–M7 (5) → B4 (6) → B5 MVP (3).

**Total ≈ 49 weeks. Claim-defensible ≈ 12 months** (mid-2027 if started now).

### Scenario B — Bibeesh + one senior contractor

Parallel tracks:

- **Bibeesh:** B6 blueprint versioning (13–16 wks) · B3 flow designer (6–8) · B7 field RBAC (2) · B1 (2). Serial ≈ 25 wks.
- **Contractor:** B2 screen designer (11–14) · B4 report auto-discovery (5–7) · B5 integration mapping MVP (3). Serial ≈ 22 wks.

With a 2-week integration / blueprint merge at the end and 20% buffer: **≈ 30 weeks ≈ 7 months. Claim-defensible by end of 2026 Q4** if started Q2.

### Scenario C (not asked, but worth noting)

Dropping B4 to "hand-written SQL, engineer-assisted" and B5 to "Datalastic only" trims 8–10 weeks but weakens the claim on points 5 and 7. Acceptable only if we re-scope the marketing statement.

## 8.3 Recommended sequencing

1. **Week 0:** lock ScreenLayout descriptor schema and blueprint DDB PK/SK patterns — these are cross-cutting.
2. **Weeks 1–8:** B1 + B6 M1–M4 (Bibeesh) in parallel with B2 M1–M2 (contractor).
3. **Weeks 9–20:** B3 + B6 M5–M7 (Bibeesh) in parallel with B2 M3–M6 + B4 (contractor).
4. **Weeks 21–28:** B5 MVP + B7 + integration testing + rollback drills.
5. **Week 29–30:** demo-ready end-to-end customer admin flow: add entity → add field → design screen → design workflow → see it in a report → generate a document referencing it → push through a mapped integration → promote blueprint → rollback.

## 8.4 Risks

- **R1 — Blueprint scope creep:** 16 weeks is optimistic; every metadata type discovered adds snapshot/diff/migration work. Guard with a hard interface freeze after M1.
- **R2 — Screen-designer UX:** dnd-kit is the right primitive but the designer UX itself is a product surface customers will judge us on. Budget time for real customer feedback after M3.
- **R3 — Flow-designer parameter regressions:** fixing `inject_node_parameters` may break live tenant workflows. Mitigate via alias versioning (B6) before the fix ships.
- **R4 — Iceberg schema evolution edge cases:** type changes and field renames are not lossless. Document the guarantees you're willing to make to customers.
- **R5 — AVP field-level cost:** every field × role × action is a policy. Keep the policy model to role × resource × action with a field whitelist attribute; do not explode per-field policies.
- **R6 — Single-developer bus factor:** B6 concentrates on Bibeesh; if he's unavailable, 3+ months slip. Prepare one contractor onboarding pack against the blueprint module.

## 8.5 Open questions for Murat

- Which three integrations are *required* in the v1 Adaptive claim? (default recommendation: Datalastic + bank-file + one carrier tracker.)
- Do we accept "reports populate after first data arrives" or do we need synthetic first-row on entity create?
- Do we support in-flight workflow migrations (long-running executions through an alias flip) on v1 or document "flush before deploy"?
- For field-level RBAC, is role-based sufficient or do we need attribute-based (per-value) rules?
