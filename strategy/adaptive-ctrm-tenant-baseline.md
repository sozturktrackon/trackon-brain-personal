---
title: TrackonAI Tenant Baseline & Bootstrap Model
updated: 2026-04-21
owner: sozturk
status: draft
related:
  - adaptive-ctrm-gap-analysis.md
  - adaptive-ctrm-gap-analysis-v2.md
  - adaptive-ctrm-b6-verification.md
---

# TrackonAI — Tenant Baseline & Bootstrap Model

Prerequisite context for the blueprint-versioning design in [adaptive-ctrm-gap-analysis-v2.md](adaptive-ctrm-gap-analysis-v2.md) §5. Every claim cites code.

Repos: backend = [../../../trackon-aws-backend](../../../trackon-aws-backend), frontend = [../../../react-ui](../../../react-ui).

---

# Section 1 — Tenant provisioning flow

## 1.1 End-to-end sequence, step by step

Trigger: `tenant_initialize` Lambda invoked with `{tenantId, adminEmail, stripeCustomerId, stripeSubscriptionId, subscriptionLevel, subscriptionMaxUsers}`. Source: [src/resolvers/tenant_initialize.py:20-156](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L20-L156).

1. **Validate inputs.** Tenant-id regex `^[a-z0-9\-]+$` at [tenant_initialize.py:27](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L27); reserved `{www, auth}` at [tenant_initialize.py:9](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L9); `adminEmail` required at [tenant_initialize.py:39-41](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L39-L41).
2. **Load 26 env vars** (S3 bucket, SFN ARN, table name, user-pool ID, 12+ Lambda ARNs) at [tenant_initialize.py:50-105](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L50-L105).
3. **Start the `tenant_initialize` Step Function** at [tenant_initialize.py:108-156](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L108-L156). Execution name `ExecutionForTenant{tenantId}_{YYYYMMDDHHMMSS}`. The input payload includes every Lambda ARN the per-tenant CFN stack needs to wire.

Then the Step Function at [src/statemachine/tenant_initialize.asl.json](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json) runs:

4. **`GetDDBItem`** ([tenant_initialize.asl.json:5-21](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L5-L21)) — reads `PK=T#{tenantId}`, `SK=#TENANTRESOURCES` from `UniversalDDBTable` to detect existing tenant.
5. **`CheckIfItemExists`** ([:22-36](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L22-L36)) — chooses CreateStack vs UpdateStack based on presence.
6. **`CreateCloudFormationStack` / `UpdateCloudFormationStack`** ([:37-254](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L37-L254)) — AWS SDK direct integration `cloudformation:createStack` / `updateStack` against `TemplateURL = https://{S3Bucket}.s3.amazonaws.com/tenant-template.yaml`. Passes 25 parameters including `TenantId`, `MainStackName`, `DDBTable`, `Environment`, `UserPoolId`, every function ARN. Capabilities `CAPABILITY_IAM, CAPABILITY_NAMED_IAM, CAPABILITY_AUTO_EXPAND`.
7. **`WaitForStackCompletion`** → **`CheckStackCompletion`** → **`IsStackComplete`** loop ([:255-294](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L255-L294)) — 30-second wait + `describeStacks` until `CREATE_COMPLETE` / `UPDATE_COMPLETE` or `CREATE_FAILED` / `UPDATE_FAILED` (the last two go to `FailState` at [:509-513](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L509-L513)).
8. **`UpdateDynamoDB`** ([:295-323](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L295-L323)) — writes `stepFunctionArn` = `JsonToString(Stacks[0].Outputs)` into `PK=T#{tenantId}, SK=#TENANTRESOURCES`, with GSI1 keys so it's discoverable cross-tenant.
9. **`FormatTimestamp`** ([:324-333](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L324-L333)) — derives `YYYY-MM` billing period.
10. **`CreateTenantRecord`** ([:334-402](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L334-L402)) — `dynamodb:updateItem` on `PK=TENANT, SK={tenantId}` writing tenantId, adminEmail, creationDate, stripe fields, subscriptionLevel, subscriptionMaxUsers, status=`active`, `sanctionsEnabled=false`, `sanctionsQueriesRemaining=0`.
11. **`CheckIfUserExists`** ([:403-421](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L403-L421)) — Cognito `adminGetUser`; `UserNotFoundException` → branch to create.
12. **`GenerateRandomPassword`** ([:422-430](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L422-L430)) — `States.Format('{}!1Az', States.UUID())`.
13. **`CreateCognitoUser`** ([:431-452](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L431-L452)) — `cognitoidentityprovider:adminCreateUser` with email + `email_verified=True`, `MessageAction=SUPPRESS`.
14. **`Parallel`** ([:457-508](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L457-L508)) — two branches in parallel:
    - `AddUserToGroup`: `adminAddUserToGroup` into `{tenantId}_Admin`.
    - `SendEmail`: SES `sendEmail` with temp password (subject: "TrackonAI Account got created", cc `support@trackonsoftware.com`).

## 1.2 What the per-tenant CloudFormation stack actually creates

Template: [templates/tenant-template.yaml](../../../trackon-aws-backend/templates/tenant-template.yaml) (2,048 lines). Resources created on each new tenant:

- **Cognito groups**: `{TenantId}_Admin` ([:585-592](../../../trackon-aws-backend/templates/tenant-template.yaml#L585-L592)) and `{TenantId}_User` ([:594-601](../../../trackon-aws-backend/templates/tenant-template.yaml#L594-L601)) attached to the shared `UserPoolId`.
- **Per-tenant S3 bucket**: `TenantSpecificS3Bucket` ([:604-638](../../../trackon-aws-backend/templates/tenant-template.yaml#L604-L638)) named `${StackName}-data`. Versioning enabled. Lifecycle transitions to STANDARD_IA at 30 days, GLACIER at 90, expire at 365. CORS open for all origins.
- **Per-tenant IAM roles**: `TenantAdminRole` ([:660-680](../../../trackon-aws-backend/templates/tenant-template.yaml#L660-L680)), `TenantUserRole` ([:682-704](../../../trackon-aws-backend/templates/tenant-template.yaml#L682-L704)), plus a `TenantStepFunctionExecutionRole` (referenced).
- **Per-tenant Athena S3 bucket** with versioning enabled at [tenant-template.yaml:1304-1309](../../../trackon-aws-backend/templates/tenant-template.yaml#L1304-L1309).
- **Per-tenant Bedrock agents + aliases**: `AWS::Bedrock::Agent` × 2 at [:1097](../../../trackon-aws-backend/templates/tenant-template.yaml#L1097) (contract agent) and [:1393](../../../trackon-aws-backend/templates/tenant-template.yaml#L1393) (split agent); `AWS::Bedrock::AgentAlias` × 2 at [:1220](../../../trackon-aws-backend/templates/tenant-template.yaml#L1220) and [:1411](../../../trackon-aws-backend/templates/tenant-template.yaml#L1411) with alias name `${TenantId}-${Environment}`.
- **Per-tenant AVP policy store**: nested stack output `TenantAVPPolicyStore` at [:1960-1962](../../../trackon-aws-backend/templates/tenant-template.yaml#L1960-L1962).
- **33 per-tenant Step Functions.** Deployed via `AWS::Serverless::StateMachine` resources, each reading an ASL definition out of the shared `state_machine_definitions/` S3 prefix. Names enumerated from the template:

  ```
  ConvertEntityStateMachine-${Environment}-${TenantId}
  ShipmentStateMachine-${Environment}-${TenantId}
  SimpleShipmentStateMachine-${Environment}-${TenantId}
  ApprovalStateMachine-${Environment}-${TenantId}
  ShipmentStepStateMachine-${Environment}-${TenantId}
  CreateEntityStateMachine-${Environment}-${TenantId}
  DeleteEntityStateMachine-${Environment}-${TenantId}
  ExtractDocumentDataStateMachine-${Environment}-${TenantId}
  UpdateEntityStateMachine-${Environment}-${TenantId}
  DoQcCycleStateMachine-${Environment}-${TenantId}
  PlainActivityStateMachine-${Environment}-${TenantId}
  ApproveContractStateMachine-${Environment}-${TenantId}
  ApprovePaymentRequestStateMachine-${Environment}-${TenantId}
  ApproveAmendmentStateMachine-${Environment}-${TenantId}
  CancelContractStateMachine-${Environment}-${TenantId}
  CallbackContractStateMachine-${Environment}-${TenantId}
  CloseContractStateMachine-${Environment}-${TenantId}
  SingleDocumentProcessingStateMachine-${Environment}-${TenantId}
  GenericEntityExtractionStateMachine-${Environment}-${TenantId}
  GenericMultiLevelPromptStateMachine-${Environment}-${TenantId}
  ValidateChecklistsStateMachine-${Environment}-${TenantId}
  FetchJourneyTrackingStateMachine-${Environment}-${TenantId}
  VesselAnalysisStateMachine-${Environment}-${TenantId}
  DIValidationSingleDocStateMachine-${Environment}-${TenantId}
  DIValidationStateMachine-${Environment}-${TenantId}
  AutoResolveDiscrepanciesStateMachine-${Environment}-${TenantId}
  GenerateDiscrepancySummaryStateMachine-${Environment}-${TenantId}
  CargoOperationStateMachine-${Environment}-${TenantId}
  RecalculateProfitabilityStateMachine-${Environment}-${TenantId}
  HedgeDailyMtmStateMachine-${Environment}-${TenantId}
  HedgeSettlementStateMachine-${Environment}-${TenantId}
  HedgeMtmPriceTriggerStateMachine-${Environment}-${TenantId}
  HedgeRecommendationStateMachine-${Environment}-${TenantId}
  ```

  (grep-counted: 33 `AWS::Serverless::StateMachine` resources in [tenant-template.yaml](../../../trackon-aws-backend/templates/tenant-template.yaml)).

- **`DataLoaderTrigger` custom resource** at [tenant-template.yaml:732-740](../../../trackon-aws-backend/templates/tenant-template.yaml#L732-L740):

  ```yaml
  DataLoaderTrigger:
    Type: Custom::DataLoader
    DependsOn: TenantSpecificS3Bucket
    Properties:
      ServiceToken: !Ref TenantDataLoaderLambdaArn
      TableName: !Ref DDBTable
      S3Bucket: !Ref S3Bucket
      TenantId: !Ref TenantId
      TenantSpecificS3Bucket: !Ref TenantSpecificS3Bucket
  ```

  This fires [src/resolvers/tenant_data_loader.py](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py) synchronously as part of stack creation.

## 1.3 What `tenant_data_loader` seeds into the new tenant

Source: [tenant_data_loader.py:300-509](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L300-L509). Called during CFN stack create/update as a custom resource.

1. **Copy all report `.docx` templates** from the shared deploy bucket to the tenant's private bucket ([tenant_data_loader.py:17-75](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L17-L75)): from `s3://{source}/reports/templates/` to `s3://{tenant-bucket}/templates/`. Binary templates are physically duplicated per tenant. `skipReportTemplates=true` skips this step (see flag at [:332-339](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L332-L339)).
2. **Fetch [`entity/metadata.json`](../../../trackon-aws-backend/src/graphql/entity/metadata.json)** (47,879 lines — every entity definition shipped with the platform) at [tenant_data_loader.py:360-365](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L360-L365).
3. **Fetch [`entity/reports.json`](../../../trackon-aws-backend/src/graphql/entity/reports.json)** (17 report-template records) at [:373-375](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L373-L375). Each entry has `tenantId: "${tenantId}"` placeholder that is substituted ([:457](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L457)).
4. **Fetch [`entity/initial_data.json`](../../../trackon-aws-backend/src/graphql/entity/initial_data.json)** (294,850 lines — seed rows: units of measure, countries, ports, currencies, chart-of-accounts, default LOVs, etc.) at [:380-388](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L380-L388). Skippable with `skipInitialData=true`.
5. **Fetch [`entity/additional_data.json`](../../../trackon-aws-backend/src/graphql/entity/additional_data.json)** (216 lines) at [:398-404](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L398-L404). Always loaded.
6. **Batch-write** three classes of items into the universal DynamoDB table at [:419-509](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L419-L509):
   - **Metadata rows**: `PK=T#{tenantId}#METADATA#ENTITY, SK=ENTITY#{entityName}` — one per shipped entity. ([:423-446](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L423-L446)).
   - **Report-template rows**: `PK=T#{tenantId}#METADATA#REPORT, SK=REPORT#{templateId}` — one per `reports.json` entry. ([:451-481](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L451-L481)).
   - **Data rows**: initial + additional seed records under each entity's PK/SK ([:486-509](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L486-L509)).

## 1.4 Initial entity metadata received

**Evidence for "baseline":** every new tenant receives the entire [src/graphql/entity/metadata.json](../../../trackon-aws-backend/src/graphql/entity/metadata.json) (47,879 lines). The file is treated by [tenant_data_loader.py:414](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L414) as "a list of entity definitions" and every row is duplicated into the tenant's DynamoDB partition. The platform ships ~120–150 entities (exact count = number of objects in `metadata.json`; search "METADATA_HISTORY" gives it index 38,672; other entities above/below). Examples include CONTRACT, POSITION, JOURNEY, INVOICE, SUB_ACCOUNT, PRODUCT, HEDGE_POSITION, METADATA_HISTORY, REPORT_TEMPLATE, etc.

## 1.5 Initial workflows received

Every new tenant immediately gets the **33 Step Functions listed in §1.2**. These are *all* the ASL definitions shipped with the platform, deployed in-place with `${TenantId}` in the name. No `WORKFLOW` DynamoDB rows are created by the loader — those are only created when an admin builds a custom workflow in the flow designer ([src/resolvers/create_workflow.py](../../../trackon-aws-backend/src/resolvers/create_workflow.py)). So the distinction is:

- **Platform workflows** (33): deployed as AWS Step Function resources by CFN. Discoverable via `aws stepfunctions list-state-machines --name-prefix …`.
- **Custom workflows** (0 on day 1): DynamoDB `WORKFLOW` rows created on demand by the flow designer; these create *additional* Step Function resources via [create_workflow.py:430](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L430).

## 1.6 Initial AVP policies received

From [tenant-template.yaml:1960-1962](../../../trackon-aws-backend/templates/tenant-template.yaml#L1960-L1962) a per-tenant AVP policy store is created via a nested `TenantPermissionsStack`. Not found in repo: the contents of that nested stack (the policy-template list). Runtime observations of what actually exists in a fresh tenant's policy store require a live AWS API call, not evidence from this repo. What *is* confirmed from [src/resolvers/create_entity.py:37-139](../../../trackon-aws-backend/src/resolvers/create_entity.py#L37-L139):

- When an entity with `useAvp=true` is created, a creator-policy is attached (`FullPermissionToAUserPolicyTemplateId`).
- Backfill lambda [src/lambdas/backfill_avp_creator_policies.py](../../../trackon-aws-backend/src/lambdas/backfill_avp_creator_policies.py) exists for retrofit — admin-triggered, not automatic.

So on day 1 a new tenant has: an empty-ish per-tenant AVP policy store with template(s) wired but **no data-specific policies** until users start creating rows.

## 1.7 Initial report templates, document templates, integration configs

- **Report metadata** ([entity/reports.json](../../../trackon-aws-backend/src/graphql/entity/reports.json)): 17 rows — Post-Loading Tally, Commercial Invoice, Packing List, Pre-Loading Tally, Sales Contract, Purchase Contract, Booking Request, Proforma Invoice, Documentary Instruction, Pre Shipment Advice, GenericSampleInvoice, Booking Confirmation, Shipment Advice, Bill Of Exchange, Contract, Contract Amendment, Shipping Instruction. All tagged `tenantId: "${tenantId}"` placeholder, substituted on load.
- **Document `.docx` templates**: copied from shared `s3://{source}/reports/templates/*` to tenant-private `s3://{tenant-bucket}/templates/*` ([tenant_data_loader.py:17-75](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L17-L75)).
- **Integration configs**: **not found.** No `INTEGRATION_CONFIG` entity in metadata.json; no per-tenant integration rows written by the loader. Every integration (Datalastic, Stripe, exchange rates, Bedrock, WhatsApp, Email) is hard-coded in Lambdas (verified earlier in [adaptive-ctrm-gap-analysis.md](adaptive-ctrm-gap-analysis.md) §1.p) and implicitly shared across tenants.

## 1.8 Is there a concept of a "baseline"?

**Yes — but it is the platform release itself.** The baseline is the four JSON files in [src/graphql/entity/](../../../trackon-aws-backend/src/graphql/entity/) (`metadata.json`, `reports.json`, `initial_data.json`, `additional_data.json`) plus the 33 ASL files in [src/statemachine/](../../../trackon-aws-backend/src/statemachine/) plus the `.docx` files in [reports/templates/](../../../trackon-aws-backend/reports/templates/). Every tenant created after deploy `v2.X` inherits the v2.X baseline. Tenants created earlier keep a frozen copy in their DynamoDB rows — they do not auto-upgrade. There is no mechanism in the repo that re-runs `tenant_data_loader` against an existing tenant to pick up the new baseline; you would have to manually CFN-update the tenant stack or run the loader via a custom invocation.

---

# Section 2 — Shared vs per-tenant configuration

Matrix with code evidence for each artefact.

| Artefact | Scope | Evidence |
|---|---|---|
| **1. Entity metadata definitions** | **Per-tenant (copy of shared baseline)** | PK pattern `T#{tenantId}#METADATA#ENTITY`, SK `ENTITY#{entityName}` at [create_entity_metadata.py:135-136](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py#L135-L136) and seed-write at [tenant_data_loader.py:424-425](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L424-L425). The shared baseline lives in [entity/metadata.json](../../../trackon-aws-backend/src/graphql/entity/metadata.json); each tenant receives its own copy at provisioning time and diverges thereafter via [create_entity_metadata.py](../../../trackon-aws-backend/src/resolvers/create_entity_metadata.py) upserts. |
| **2. Workflow / Step Function definitions** | **Per-tenant (named + resourced)** | Naming `{Name}-{Environment}-{TenantId}` at [tenant-template.yaml](../../../trackon-aws-backend/templates/tenant-template.yaml) (33 entries listed in §1.2). Custom workflows keep the same pattern at [create_workflow.py:152-156](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L152-L156). ASL *definitions* are shared (read from the common S3 prefix `state_machine_definitions/`) but each tenant gets its own SFN resource. |
| **3. Report SQL queries (Athena)** | **Shared** (hand-written) | Files in [athena/reporting_queries/](../../../trackon-aws-backend/athena/reporting_queries/) (journey_report.sql, arap_age_analysis.sql, open_contract_details.sql, …). Executed against per-tenant Iceberg tables via database name `t_{tenantId}` (see [ddb_streams_changelog.py:169](../../../trackon-aws-backend/src/lambdas/ddb_streams_changelog.py#L169) catalog lookup). Queries are authored once, parameterised by tenant. |
| **4a. Document templates (DOCX binaries)** | **Copied per-tenant to private bucket** | Copy loop at [tenant_data_loader.py:17-75](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L17-L75): `s3://{shared}/reports/templates/*` → `s3://{tenant-bucket}/templates/*`. A tenant may customise their copy without affecting others. |
| **4b. Report metadata rows** | **Per-tenant (copy of shared baseline)** | 17 rows seeded into `PK=T#{tenantId}#METADATA#REPORT` at [tenant_data_loader.py:451-481](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L451-L481); each row's `tenantId: "${tenantId}"` placeholder replaced via `replace_variables` at [tenant_data_loader.py:522-551](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py#L522-L551). |
| **5. AVP policies** | **Per-tenant policy store** | `TenantAVPPolicyStore` output from per-tenant CFN stack at [tenant-template.yaml:1960-1962](../../../trackon-aws-backend/templates/tenant-template.yaml#L1960-L1962). Lookup via tenant resources at [avp_operations.py:32-98](../../../trackon-aws-backend/src/resolvers/avp_operations.py#L32-L98). Each tenant has its own policy store; principals are tenant-scoped (`APP::User#{email}`) though the user pool is shared (see row 7). |
| **6. Integration configurations** | **Shared (code-level)** | Lambdas are deployed once in the main stack ([templates/cloudformation.yaml](../../../trackon-aws-backend/templates/cloudformation.yaml)): Datalastic ([fetch_datalastic_data.py](../../../trackon-aws-backend/src/lambdas/fetch_datalastic_data.py)), Stripe ([stripe_webhook_handler.py](../../../trackon-aws-backend/src/lambdas/stripe_webhook_handler.py)), exchange rates ([populate_exchange_rates.py](../../../trackon-aws-backend/src/lambdas/populate_exchange_rates.py)), Bedrock ([bedrock_caller.py](../../../trackon-aws-backend/src/lambdas/bedrock_caller.py)), Email ([send_email_with_attachment.py](../../../trackon-aws-backend/src/lambdas/send_email_with_attachment.py)), WhatsApp ([send_whatsapp_notification.py](../../../trackon-aws-backend/src/lambdas/send_whatsapp_notification.py)). Secrets (Datalastic, Stripe) come from shared AWS Secrets Manager. Tenant-scoped loops inside the Lambdas (e.g. populate_exchange_rates iterates tenants) — but the *code* is shared and field mappings are hard-coded. |
| **7a. Cognito user pool** | **Shared** | Single `UserPoolId` env var passed through [tenant_initialize.py:55](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L55) to every tenant. Per-tenant *groups* created inside it ([tenant-template.yaml:585-601](../../../trackon-aws-backend/templates/tenant-template.yaml#L585-L601)) — `{tenantId}_Admin` and `{tenantId}_User`. |
| **7b. UI components and layout (React)** | **Shared build** | One React build served to all tenants. [src/user.jsx:5-16](../../../react-ui/src/user.jsx#L5-L16) derives `tenantId` from the subdomain (`{tenant}.trackon.ai`, `{tenant}.eu.trackon.ai`, `{tenant}.ap.trackon.ai` per Makefile naming). Entity layouts (formLayout) come from per-tenant metadata at runtime (verified in [adaptive-ctrm-b2-verification.md](adaptive-ctrm-b2-verification.md)), but the React code and page routes are identical across all tenants. Confirmed: no tenantId conditional branching in UI source ( `tenantId ==='` / `tenantId =='` searches in `react-ui/src` return zero hits ). |
| **8. S3 buckets (tenant data)** | **Per-tenant** | `TenantSpecificS3Bucket` named `${StackName}-data` at [tenant-template.yaml:604-638](../../../trackon-aws-backend/templates/tenant-template.yaml#L604-L638). Versioning on. Lifecycle to STANDARD_IA → GLACIER. |
| **9. S3 buckets (deploy / state machines / layers)** | **Shared per-env** | `tai-deploy-{env}-{region-suffix}` at [Makefile:24-25](../../../trackon-aws-backend/Makefile#L24-L25). One bucket per (environment, region). |
| **10. DynamoDB table (`UniversalDDBTable{Environment}`)** | **Shared per-env** | Single table per environment at [templates/cloudformation.yaml:514-605](../../../trackon-aws-backend/templates/cloudformation.yaml#L514-L605) with tenant prefixing in PK. |
| **11. Bedrock agents** | **Per-tenant** | `AWS::Bedrock::Agent` × 2 and `AWS::Bedrock::AgentAlias` × 2 per tenant at [tenant-template.yaml:1097, 1220, 1393, 1411](../../../trackon-aws-backend/templates/tenant-template.yaml#L1097). Alias name `${TenantId}-${Environment}`. |

---

# Section 3 — Existing CI/CD deployment pipeline

## 3.1 Makefile targets

Source: [Makefile](../../../trackon-aws-backend/Makefile). Top-level targets and their role:

| Target | Line | What it does |
|---|---|---|
| `setup_venv` | [64-65](../../../trackon-aws-backend/Makefile#L64-L65) | `python3 -m venv myenv` |
| `clean` | [67-72](../../../trackon-aws-backend/Makefile#L67-L72) | Remove venv, `./dependencies/*`, `./temp_for_zip`, lambda zip |
| `hash` | [74-75](../../../trackon-aws-backend/Makefile#L74-L75) | Print `CODE_HASH` (sha256 of src + requirements) |
| `install_requirements` | [77-78](../../../trackon-aws-backend/Makefile#L77-L78) | `pip install -r requirements.txt -t ./dependencies` |
| `upload_layer` | [80-89](../../../trackon-aws-backend/Makefile#L80-L89) | Upload 9 Lambda layer zips (pandaspyarrow, docxtpl, pyiceberg, pillow, jinja, pyarrow, google, stripe, pymupdf) to `s3://{S3_BUCKET}/layers/` |
| `$(LAMBDA_PACKAGE)` | [91-98](../../../trackon-aws-backend/Makefile#L91-L98) | Build `build/lambda_package.zip` (src + dependencies) |
| `package` | [100-104](../../../trackon-aws-backend/Makefile#L100-L104) | `aws cloudformation package` against `TEMPLATE_FILE` |
| `before_deploy` | [106-108](../../../trackon-aws-backend/Makefile#L106-L108) | Echo hashes for traceability |
| `upload_state_machines` | [110-113](../../../trackon-aws-backend/Makefile#L110-L113) | Upload every ASL in `src/statemachine/*.json` to `s3://{S3_BUCKET}/state_machine_definitions/` |
| `upload_templates` | [115-118](../../../trackon-aws-backend/Makefile#L115-L118) | Upload every `templates/*.yaml` to S3 |
| `upload_entities` | [120-123](../../../trackon-aws-backend/Makefile#L120-L123) | Upload every `src/graphql/entity/*.json` to `s3://{S3_BUCKET}/entity/` |
| `upload_report_templates` | [125-140](../../../trackon-aws-backend/Makefile#L125-L140) | Upload every `.docx` / `.jrxml` / `.pdf` under `reports/templates/` |
| `upload_tenant_template` | [142-143](../../../trackon-aws-backend/Makefile#L142-L143) | Upload `tenant-template.yaml` |
| `upload_vtl` | [145-148](../../../trackon-aws-backend/Makefile#L145-L148) | Upload every `src/resolvers/vtl/*.vtl` |
| **`deploy`** | [150-181](../../../trackon-aws-backend/Makefile#L150-L181) | **Chain: before_deploy → upload_state_machines → upload_vtl → upload_templates → upload_entities → package → `aws cloudformation deploy`.** Passes 18 parameter overrides. Environment-targeted by `ENVIRONMENT` and `AWS_REGION` variables. |
| `cleanup-versions` | [183-191](../../../trackon-aws-backend/Makefile#L183-L191) | Invoke `{stack}-cleanup-lambda-versions` to prune old Lambda versions |
| `delete` | [193-194](../../../trackon-aws-backend/Makefile#L193-L194) | `aws cloudformation delete-stack` |
| `test` | [196-198](../../../trackon-aws-backend/Makefile#L196-L198) | `pytest tests/` |
| `deploy-tenant` | [200-205](../../../trackon-aws-backend/Makefile#L200-L205) | Call `TenantInitializeFunctionUrl` HTTPS endpoint with `{tenantId}` (triggers the SFN in §1.1) |
| `docker-deploy` | [207-233](../../../trackon-aws-backend/Makefile#L207-L233) | Build + push `Dockerfile.docling` to ECR, update Lambda function code |
| `compile-function` | [235-250](../../../trackon-aws-backend/Makefile#L235-L250) | Re-point a Lambda at a docker image |
| `docker-build-libreoffice` / `docker-push-libreoffice` / `update-lambda-libreoffice` | [252-278](../../../trackon-aws-backend/Makefile#L252-L278) | Same for LibreOffice container |

**Which targets deploy to staging vs prod:** the Makefile itself is env-agnostic — `make deploy ENVIRONMENT=staging` and `make deploy ENVIRONMENT=prod` are the only distinguishing calls. Stack names and bucket names are computed from `ENVIRONMENT`:

- `STACK_NAME = trackon-aws-backend-stack-staging` (us-east-1) or `tai-staging-eu` / `tai-staging-ap` — [Makefile:24](../../../trackon-aws-backend/Makefile#L24).
- `STACK_NAME = trackon-aws-backend-stack-prod` or `tai-prod-eu` / `tai-prod-ap` — same line.
- `S3_BUCKET = trackon-deploy-bucket-trackonai-staging` vs `-prod` — [Makefile:25](../../../trackon-aws-backend/Makefile#L25).

## 3.2 CI configs (GitHub Actions)

All in [.github/workflows/](../../../trackon-aws-backend/.github/workflows/). Twelve files:

| Workflow | Trigger | Target | Credentials |
|---|---|---|---|
| [deploy-staging.yaml](../../../trackon-aws-backend/.github/workflows/deploy-staging.yaml) | `push` to `main` | `make deploy ENVIRONMENT=staging` in us-east-1 | `AWS_ACCESS_KEY_ID` + `AWS_SECRET_ACCESS_KEY` (staging account) |
| [deploy-prod.yaml](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml) | `push` of `v*` tag | `make deploy ENVIRONMENT=prod LOG_LEVEL=ERROR` in us-east-1 | `PROD_AWS_ACCESS_KEY_ID` + `PROD_AWS_SECRET_ACCESS_KEY` (prod account) |
| [deploy-pr.yaml](../../../trackon-aws-backend/.github/workflows/deploy-pr.yaml) | `workflow_dispatch` with env input | `make deploy ENVIRONMENT={dev\|staging\|prod}` in us-west-1 | `AWS_ACCESS_KEY_ID` (staging creds — **us-west-1 override**) |
| [manual-deploy-dev.yaml](../../../trackon-aws-backend/.github/workflows/manual-deploy-dev.yaml) | `workflow_dispatch` with PR number | `make deploy ENVIRONMENT=dev` in us-east-1 | `AWS_ACCESS_KEY_ID` (staging creds) |
| [metadata-check.yaml](../../../trackon-aws-backend/.github/workflows/metadata-check.yaml) | `push` / `pull_request` touching `src/graphql/entity/metadata.json` | `python utils/metadata_check.py` — validates that pk/sk formula attributes are marked required, IDGeneration attributes exist. Already a blueprint-integrity gate. | none (read-only) |
| [lint.yaml](../../../trackon-aws-backend/.github/workflows/lint.yaml) | `push` to any branch / `pull_request` to any-but-main (odd filter logic) | `black`, `isort`, `flake8` | none |
| [test.yaml](../../../trackon-aws-backend/.github/workflows/test.yaml) | `workflow_dispatch` with branch input | `pytest --cov` | none (mock AWS region us-west-1/us-east-1) |
| [cleanup.yaml](../../../trackon-aws-backend/.github/workflows/cleanup.yaml) | `pull_request closed` (merged) | `aws cloudformation delete-stack` for PR-scoped stacks (pattern `trackon-aws-backend-stack-{PR}` and `tenant-*-resources-{PR}`) | `AWS_ACCESS_KEY_ID` (staging) |
| [docker-deploy.yaml](../../../trackon-aws-backend/.github/workflows/docker-deploy.yaml) | (not read in full) | `make docker-deploy` — dev/staging | staging creds |
| [prod-docker-deploy.yaml](../../../trackon-aws-backend/.github/workflows/prod-docker-deploy.yaml) | manual | `make docker-deploy` — prod | `PROD_AWS_ACCESS_KEY_ID` |
| [layer-deploy.yaml](../../../trackon-aws-backend/.github/workflows/layer-deploy.yaml) | `workflow_dispatch` with env input | `make upload_layer ENVIRONMENT=…` | staging creds |
| [layer-deploy-prod.yaml](../../../trackon-aws-backend/.github/workflows/layer-deploy-prod.yaml) | `workflow_dispatch` | `make upload_layer ENVIRONMENT=prod` | `PROD_AWS_ACCESS_KEY_ID` |

## 3.3 Mechanisms that distinguish staging from production

Exhaustive list, all from the repo:

1. **GitHub Actions secrets**: `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` = staging-account long-lived keys. `PROD_AWS_ACCESS_KEY_ID` / `PROD_AWS_SECRET_ACCESS_KEY` = production-account keys. Only [deploy-prod.yaml:14-15](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml#L14-L15), [prod-docker-deploy.yaml](../../../trackon-aws-backend/.github/workflows/prod-docker-deploy.yaml), and [layer-deploy-prod.yaml](../../../trackon-aws-backend/.github/workflows/layer-deploy-prod.yaml) reference the `PROD_` secrets.
2. **Makefile `ENVIRONMENT` parameter** — affects stack name, S3 bucket name, region suffix ([Makefile:24-29](../../../trackon-aws-backend/Makefile#L24-L29)). Default `dev`.
3. **Stack naming convention**: `trackon-aws-backend-stack-{env}` (us-east-1 legacy) or `tai-{env}-{region-suffix}` (new regions).
4. **S3 deploy bucket naming**: `trackon-deploy-bucket-trackonai-{env}` (us-east-1) or `tai-deploy-{env}-{region-suffix}`.
5. **Region subdomain for tenant DNS**: `{tenant}.trackon.ai` (us-east-1), `{tenant}.eu.trackon.ai`, `{tenant}.ap.trackon.ai` — [Makefile:28-29](../../../trackon-aws-backend/Makefile#L28-L29).
6. **Log level**: prod runs `LOG_LEVEL=ERROR` by default ([deploy-prod.yaml:57](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml#L57)) vs INFO elsewhere.
7. **Provisioned concurrency**: `ENABLE_PROVISIONED_CONCURRENCY` flag defaults off ([Makefile:35](../../../trackon-aws-backend/Makefile#L35)); intended "for production primary region only" (Makefile comment at [:33-34](../../../trackon-aws-backend/Makefile#L33-L34)).
8. **Tenant-template domain map**: the CFN `EnvironmentMap` (referenced at [tenant-template.yaml:725](../../../trackon-aws-backend/templates/tenant-template.yaml#L725)) maps `Environment` → `domain`, distinguishing staging/prod DNS.
9. **Bedrock agent alias name** includes `${Environment}` — same agent-alias pattern per env.
10. **ACCOUNT_ID**: discovered at deploy time via `aws sts get-caller-identity` ([Makefile:212, 238, 256, 271](../../../trackon-aws-backend/Makefile#L212)) — never hard-coded; naturally differs per account.

**No cross-account IAM role.** Not found: any `sts:AssumeRole` with a cross-account principal in workflows or Makefile. Isolation is pure credential-based.

## 3.4 Developer → staging path

```
developer commits → pushes branch → PR opened
  → lint.yaml runs (black/isort/flake8)
  → metadata-check.yaml runs if metadata.json touched
  → merge to main
  → deploy-staging.yaml triggers (push: main)
    → checkout, pip install, make clean, make build/lambda_package.zip
    → make deploy ENVIRONMENT=staging
    → CloudFormation update on staging-account stack
    → make cleanup-versions invoked at end
```

## 3.5 Developer → production path

```
maintainer creates annotated tag matching v*
  → git push --tags
  → deploy-prod.yaml triggers (push: tags/v*)
    → same build steps but with PROD_AWS_ACCESS_KEY_ID
    → make deploy ENVIRONMENT=prod LOG_LEVEL=ERROR
    → CloudFormation update on prod-account stack
```

## 3.6 Manual approval between staging and prod

**Not found.** There is no GitHub `environment` protection rule, no `workflow_dispatch` gate, no approval step in `deploy-prod.yaml`. The gate is social: a human must decide to tag `v*`. Once the tag is pushed, prod deploy runs automatically.

## 3.7 Separate buckets, tables, SFN namespaces

Confirmed. Derived from the distinguishing mechanisms in §3.3:

- **S3 buckets**: `trackon-deploy-bucket-trackonai-staging` vs `-prod` (deploy bucket), plus `{stack}-data` and `{stack}-athena` per tenant per env.
- **DynamoDB table**: `UniversalDDBTable{Environment}` — different physical table per env. Cross-env reads impossible without the other account's credentials.
- **Step Function namespaces**: every per-tenant SFN name carries `${Environment}` (e.g. `CreateEntityStateMachine-staging-hfd` vs `CreateEntityStateMachine-prod-hfd`). Account-scoped so names can overlap in principle, but the `${Environment}` suffix defends against accidental overlap in the shared-user-pool scenario.
- **Cognito user pool**: the `UserPoolId` env var is per-env (passed into CFN at deploy). Users in staging cannot log into prod.

---

# Section 4 — Customer-specific variations today

## 4.1 Hard-coded tenant IDs in code

Search pattern: `"ags"`, `"agrisar"`, `"hfd"`, `"afg"`, `"demo"`, `"aghospital"`, `"mana"`, and equality comparisons on `tenantId` across both repos.

**Backend hits:**
- [src/lambdas/backfill_avp_creator_policies.py:28, 31, 34, 37](../../../trackon-aws-backend/src/lambdas/backfill_avp_creator_policies.py#L28-L37) — in-code docstring examples using `"hfd"` as a sample tenant id:
  ```
  {"tenantId": "hfd"}
  {"tenantId": "hfd", "entityName": "CONTRACT"}
  {"tenantId": "hfd", "entityName": "CONTRACT", "dryRun": true}
  {"tenantId": "hfd", "entityName": "CONTRACT", "limit": 100}
  ```
  These are example payloads in comments, not conditional logic.
- [docs/avp.md](../../../trackon-aws-backend/docs/avp.md) — 20+ uses of `tenantId: "hfd"` in GraphQL examples. Docs only.
- [migrate_hfd_progress.json](../../../trackon-aws-backend/migrate_hfd_progress.json), [migrate_demo_progress.json](../../../trackon-aws-backend/migrate_demo_progress.json), [migrate_afg_progress.json](../../../trackon-aws-backend/migrate_afg_progress.json) — migration progress trackers for three real tenants (`hfd`, `demo`, `afg`). Data artefacts, not runtime code.

**UI hits:** search `"ags"|"agrisar"|"hfd"|"afg"|"demo"|"aghospital"|"mana"|tenantId ==='|tenantId =='` over [react-ui/src](../../../react-ui/src) → **no matches found**. No UI branch compares `tenantId` to a literal.

**Verdict:** zero hard-coded tenant-id branching in runtime code. `hfd`/`afg`/`demo` appear only in docs, migration-progress JSON, and as example payloads in comments.

## 4.2 Feature flags / conditional logic on `tenantId`

Search: equality comparisons, dictionary lookups keyed by tenant, etc.

- **Runtime branching found:** `is_reserved_tenant_id` at [tenant_initialize.py:12-17](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L12-L17) rejects `{www, auth}`. That is the only tenant-id-aware conditional in backend runtime.
- **No feature-flag framework found.** Grep for `featureFlag`, `feature_flag`, `LaunchDarkly`, `GrowthBook` returns no matches in either repo. Grep for `tenantId ===` / `tenantId ==` in UI also returns no matches.
- **Tenant parameters table:** a `PARAMETER` / `COMPANY_PARAMETER` entity exists as runtime data (referenced in [generate_report.py:66-122](../../../trackon-aws-backend/src/resolvers/generate_report.py#L66-L122): `SIGNATURE_POSITION`, `STAMP_HEIGHT_PIXELS`, `SIGNATURE_HEIGHT_PIXELS`). This is tenant-configurable at runtime via standard entity CRUD — it is the de-facto feature-flag mechanism today.

## 4.3 Tenant-specific configuration files

**Not found.**
- No `config/{tenantId}.json` pattern.
- No per-tenant env-var scheme (all env vars are stack-wide).
- No separate Cognito user pools per tenant — single shared pool with per-tenant groups (see §2 row 7a).
- `initial_data.json` / `additional_data.json` / `metadata.json` ship identical content to every tenant.

## 4.4 Mechanisms that allow a tenant to diverge without a code deploy

1. **Tenant-scoped `COMPANY_PARAMETER` rows** (the runtime parameters table). Signature positions, stamp dimensions, subscription flags — all adjustable per-tenant via normal entity CRUD.
2. **Entity metadata upsert** — tenant admin uses EntityBuilder, metadata is overwritten for that tenant only (per B1 verification).
3. **Custom workflows** — WORKFLOW entity rows create additional per-tenant Step Functions ([create_workflow.py:430](../../../trackon-aws-backend/src/resolvers/create_workflow.py#L430)). Unique to that tenant; does not affect the platform 33.
4. **Per-tenant report-template rows** — admin can update the `REPORT_TEMPLATE` item to point to a customised `.docx` uploaded to the tenant's own bucket.
5. **AVP policies** — per-tenant policy store can carry arbitrary role/permission structures.

**No runtime mechanism exists for diverging integrations, diverging workflow *definitions* (only custom wrappers), diverging core CTRM logic, or diverging core entity-CRUD Lambdas** — those are shared code.

## 4.5 Legacy-product customer notes (Agrisar context)

The brain reference to "Agrisar requiring a separate Oracle timezone instance" concerns the **Trackon Legacy** product, not TrackonAI. Evidence:

- [customers/agrisar/agrisar-overview.md:4](../../customers/agrisar/agrisar-overview.md#L4) — `tags: [agrisar, trackon-legacy, tradingdocs]`. No `trackonai` tag.
- [customers/agrisar/agrisar-health.md:28-33, 48-49](../../customers/agrisar/agrisar-health.md#L28-L33) — TLB-2455, TLB-2592, "Steps logic change: make parametric so existing customers except Agrisar not affected" — all in the `TLB-` (Trackon Legacy Backend) Jira project.
- Legacy Oracle references in [archive/trackon-aws-backend/templates/appsync-resources.yaml](../archive/trackon-aws-backend/templates/appsync-resources.yaml) (archive tree) — not in the active [trackon-aws-backend](../../../trackon-aws-backend/).
- Active `trackon-aws-backend` grep for `oracle|Oracle|ORACLE|timezone|Timezone` returned zero non-archive hits.

**For TrackonAI specifically, there are no documented customer-specific variations in code today.** The Agrisar-style per-customer divergence lives entirely in the Legacy product's Oracle/Java codebase at [../../../trackon-build](../../../trackon-build/), not in `trackon-aws-backend`.

---

# Section 5 — Sandbox and test tenant strategy

## 5.1 Designated test tenant in staging

**Evidence suggests `demo` is the test tenant.** Basis:
- [migrate_demo_progress.json](../../../trackon-aws-backend/migrate_demo_progress.json) exists alongside real-customer `migrate_hfd_progress.json` / `migrate_afg_progress.json`, suggesting `demo` is maintained through the same migration process as live tenants — i.e. it is a first-class tenant, not a synthetic one.
- No explicit "test tenant" marker (`isTest: true`, `tenantType`) in metadata.json or in the provisioning flow.
- No `RESERVED_TENANT_IDS` entry for `demo` ([tenant_initialize.py:9](../../../trackon-aws-backend/src/resolvers/tenant_initialize.py#L9) lists only `{www, auth}`).

**Not conclusively confirmed from the repo.** The repo does not formally label any tenant as "the test tenant". The concept appears to be operator-knowledge, not code-enforced.

## 5.2 Test-tenant data vs production

No per-tenant `isTest`, no reset policy, no data-isolation flag found. `demo` appears to behave identically to any other tenant, except that it is probably the one operators use for rehearsal. Since staging and prod are separate AWS accounts (§3), `demo` on staging and `demo` on prod could be distinct; confirmation requires live account inspection.

## 5.3 Can a production customer test a blueprint change before promotion?

**No — not found.** The only test surface today is:
- Push to `main` → runs in staging account against whatever tenants exist there (including `demo` if it is the nominated staging scratch tenant).
- Push `v*` tag → runs in prod account against real customer tenants.

There is no "staging copy of production tenant X" pattern, no data-masking job, and no way to run a production customer's overlay against staging infrastructure with their actual data. A customer who wants to pilot a schema change must do it live on their production tenant; if it breaks, rollback = `updateEntityMetadata` with the prior shape, plus whatever the Iceberg/Athena schema-evolution layer can reverse (not all shapes).

## 5.4 Gap documentation

Blueprint staging is **not meaningless** — the two-account split already gives us environment-level staging for platform code. But it does leave three gaps that blueprint versioning must address directly:

1. **No customer-data-isolated rehearsal tenant.** A prod-customer cannot "fork" their tenant into staging to validate a schema/workflow change before applying. Blueprint versioning needs an explicit "staging deploy of this overlay against tenant X's staging snapshot" workflow, or at minimum a well-documented "replicate tenant X to staging" tool.
2. **No formal sandbox tenant.** `demo` as a de-facto staging tenant is unannotated in code; new developers cannot discover it without asking. The blueprint design should either (a) introduce a `tenantType: sandbox|production` attribute on the TENANT row, or (b) document which tenant IDs are reserved for rehearsal.
3. **No automated data-shape drift check between staging and prod.** A migration validated in staging against `demo` can still fail against a real customer tenant whose data has edge cases `demo` does not. Blueprint promotion should include a pre-flight that runs the migration in dry-run against the target tenant's actual data before committing.

---

# Section 6 — Implications for blueprint versioning design

## 6.1 Existing infrastructure the design must integrate with (not replace)

1. **`UniversalDDBTable{Environment}` (one per env)** — [templates/cloudformation.yaml:514-605](../../../trackon-aws-backend/templates/cloudformation.yaml#L514-L605). Blueprint items (pointer, deployment audit) must go here, using existing PK/SK patterns. No new table.
2. **Per-tenant CFN stack `{MainStack}-{tenantId}`** — this is the existing unit of "one tenant's infrastructure". Any new per-tenant resources (custom SFN aliases, new S3 prefixes for overlay storage) should be added as resources in [tenant-template.yaml](../../../trackon-aws-backend/templates/tenant-template.yaml) so they flow through the already-working `tenant_initialize` SFN and through the existing stack-update path.
3. **`tenant_data_loader.py` custom-resource pattern** — [tenant-template.yaml:732-740](../../../trackon-aws-backend/templates/tenant-template.yaml#L732-L740) + [tenant_data_loader.py](../../../trackon-aws-backend/src/resolvers/tenant_data_loader.py). The blueprint promotion-to-prod step should either extend this loader or invoke a sibling loader that replays an overlay JSON into the tenant's DDB rows. It already knows how to batch-write metadata, report metadata, and initial data.
4. **`tenant_data_exporter.py`** — [tenant_data_exporter.py:15-33](../../../trackon-aws-backend/src/resolvers/tenant_data_exporter.py#L15-L33) already exports layouts (`formLayout`, `sideLayout`, `tabLayout`, `layouts`) in its `FIELD_ORDER`. This is the de-facto snapshot primitive. Blueprint snapshot-capture should extend this rather than write its own.
5. **`METADATA_HISTORY`** — the append-only audit entity at [entity/metadata.json:38672-38870](../../../trackon-aws-backend/src/graphql/entity/metadata.json#L38672-L38870). Already captures every `createEntityMetadata` upsert. Extend with sibling history rows for workflow / report-template / AVP changes rather than build a parallel store.
6. **`AutoPublishAlias: live` on Lambdas** — [templates/cloudformation.yaml:305](../../../trackon-aws-backend/templates/cloudformation.yaml#L305). The alias pattern is already in production at the Lambda layer. Extending it to Step Functions (CreateStateMachineVersion / CreateStateMachineAlias / UpdateStateMachineAlias) follows the established idiom.
7. **Per-tenant S3 bucket with versioning** — [tenant-template.yaml:604-638](../../../trackon-aws-backend/templates/tenant-template.yaml#L604-L638). Off-site overlay backup is free; just `PutObject` the overlay JSON into `s3://{tenant-bucket}/blueprints/{version}.json`.
8. **Two-account CI/CD wiring via GitHub secrets** — [deploy-staging.yaml](../../../trackon-aws-backend/.github/workflows/deploy-staging.yaml) / [deploy-prod.yaml](../../../trackon-aws-backend/.github/workflows/deploy-prod.yaml). Blueprint code ships as part of every platform deploy; there is no separate blueprint CI/CD pipeline to build.

## 6.2 Existing patterns blueprint storage should follow

1. **Naming convention**: anything per-tenant gets `{Name}-{Environment}-{TenantId}` (matching the 33 existing SFNs). Blueprint versioning artefacts (SFN versions/aliases) should extend the pattern to `{Name}-{Environment}-{TenantId}-v{N}` / `{Name}-{Environment}-{TenantId}-live`.
2. **Credential boundary = account boundary.** The design must not introduce a cross-account IAM role unless there is no alternative. A prod-side pull-lambda reading the staging overlay bucket via a bucket policy (as v2 §5.4 already proposes) matches the existing "no assume-role" discipline.
3. **DynamoDB PK prefix `T#{tenantId}`** for tenant-scoped items, plus the `TENANT_*` shared prefix for tenant-registry items — matches what [tenant_initialize.asl.json:300-320](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json#L300-L320) already does.
4. **"Shared platform code, per-tenant data"** is the lens to use: the blueprint *overlay* is per-tenant data. The blueprint *code* (deploy SFN, migration executor, pointer schema, diff engine) is shared platform code and ships through the existing CI/CD.
5. **Env-suffixed shared resources**: every shared item that exists twice (staging + prod) carries `{Environment}` in its name — `UniversalDDBTable{Environment}`, `{StackName}-{env}`, etc. Blueprint deploy SFN name must follow the same pattern.
6. **Source of truth = metadata + source control**: the 4 JSON files in [src/graphql/entity/](../../../trackon-aws-backend/src/graphql/entity/) + the 33 ASL files in [src/statemachine/](../../../trackon-aws-backend/src/statemachine/) are the canonical platform-baseline today. Tenant overlays must layer *on top of* that baseline, not replace the pattern.

## 6.3 Prerequisite gaps the blueprint design must close

1. **No identified sandbox tenant.** v2 §5.4 assumes "real staging tenant data" exists for rehearsal. If the de-facto sandbox is `demo`, the design should (a) codify this by marking `demo` (or a new `sandbox-{customer}` tenant) with an `isSandbox` attribute on the TENANT row, and (b) ensure the blueprint-deploy SFN refuses to target a sandbox tenant from a prod-account invocation. Without this, "staging deploy validates against real-shape data" is aspirational.
2. **No mechanism to refresh an existing tenant from the shipped baseline.** When the platform ships a new entity in `metadata.json`, existing tenants do not pick it up automatically (§1.8). Blueprint versioning needs to decide: does promoting a platform tag `v2.42.0` to prod automatically extend existing tenants' `T#{tenantId}#METADATA#ENTITY` rows with the new entity? If yes, we need an idempotent re-apply step; if no, we need explicit UI to let an admin opt-in to the upgrade.
3. **No workflow-definition audit trail.** METADATA_HISTORY does not capture [update_workflow.py](../../../trackon-aws-backend/src/resolvers/update_workflow.py) changes. Without this, half of the blueprint "what changed between v16 and v17" question cannot be answered from existing data. Required pre-work: ~0.5 wk to shim `record_to_history` equivalents into workflow/report/AVP mutation paths.
4. **No per-tenant data-shape drift check.** A staging deploy against `demo` does not guarantee safety against customer tenants. Design should include a pre-flight dry-run against the target tenant's actual data before committing promote-to-prod.

## 6.4 Sharp edges the design must handle carefully

1. **33 per-tenant Step Functions × N tenants.** Every workflow-definition change currently requires a CFN stack update on every tenant stack to redeploy the ASL. Blueprint-level workflow versioning must decide whether to (a) version the *shared* ASL blobs in S3 (and let the existing CFN stack update roll the change across all tenants on next deploy), or (b) version the ASL *per tenant* (expensive at scale). v2's alias-flip proposal needs to be reconciled with this CFN-update-per-tenant reality.
2. **`tenant_data_loader` is a CFN custom resource, not a runtime-callable API.** It fires once during stack create/update. To re-seed a tenant with a new baseline without a full stack update, the loader either needs to be refactored into a GraphQL-invokable Lambda or a sibling runtime loader needs to exist.
3. **Binary `.docx` templates are copied per tenant at provisioning time.** If a customer edits their copy, a platform template update does not override it — divergence is silent and permanent. Blueprint promotion of report-template changes must respect whether the tenant's copy has been modified since provisioning, or explicitly warn that a customer edit will be clobbered.
4. **Lambda `AutoPublishAlias` + SnapStart create a new Lambda version on every deploy.** [README.md:37-38](../../../trackon-aws-backend/README.md#L37-L38). The `cleanup-versions` target ([Makefile:183-191](../../../trackon-aws-backend/Makefile#L183-L191)) keeps only the two most recent versions. If blueprint rollback tries to re-invoke an old Lambda version, it may have been deleted by cleanup. Blueprint rollback for code-carrying artefacts (not pure data) must be scoped to data-level reversion only.
5. **Shared user pool.** A user signs in once per env and then the subdomain picks the tenant. If blueprint promotion changes a tenant's Cognito group permissions, active sessions may be silently stale. Not a blocker — worth documenting.
6. **Agrisar-style divergence lives in the Legacy stack, not here.** Don't import design constraints from Legacy's per-customer branching into TrackonAI blueprint versioning; TrackonAI is parametric-by-design today and should stay that way. A blueprint overlay is not a place to cram conditional branching on `tenantId` — it is a place to store tenant-scoped data (entities, workflows, layouts, mappings).

---

# Summary — top 3 constraints v2 §5 must respect

1. **Blueprint overlays are tenant-scoped data, not a re-architecture of tenant provisioning.** The existing `tenant_initialize` SFN, per-tenant CFN stack, `tenant_data_loader` custom resource, and shared-platform-code model at [tenant-template.yaml](../../../trackon-aws-backend/templates/tenant-template.yaml) + [tenant_initialize.asl.json](../../../trackon-aws-backend/src/statemachine/tenant_initialize.asl.json) are the foundation. Blueprint versioning extends this by adding a pointer row + audit row in `UniversalDDBTable{Environment}`, an overlay JSON in the per-tenant S3 bucket (versioning already on), and a deploy SFN that re-invokes a Lambda variant of `tenant_data_loader`. It must not introduce a parallel tenant lifecycle.

2. **The two-account split is credential-based, not IAM-role-based.** The prod account never receives a cross-account assume-role grant. The blueprint promote-to-prod step must use a pull model (prod-side Lambda reads staging S3 bucket via bucket policy) — mirroring the way the existing pipeline ships code via per-account secrets. Do not introduce `AssumeRole` unless absolutely required.

3. **The sandbox story is missing and blueprint versioning must close it before the "staging deploy against real-shape data" promise is meaningful.** Without a first-class sandbox tenant (codified with an attribute, not just operator knowledge of `demo`), the benefit of "validate in staging account before prod" is theoretical. v2 §5.4 should either (a) adopt `demo` formally as the rehearsal tenant and gate prod promotion on a successful `demo`-apply, or (b) introduce a per-customer "staging copy" tenant spun up on demand before a promotion — which in turn requires making `tenant_data_loader` a runtime-callable Lambda rather than a CFN custom resource.
