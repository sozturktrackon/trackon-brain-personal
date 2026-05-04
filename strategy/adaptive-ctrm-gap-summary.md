---
title: Adaptive CTRM — 1-page executive summary
updated: 2026-04-21
owner: sozturk
status: draft
related:
  - adaptive-ctrm-gap-analysis.md
  - products/trackonai/trackonai-roadmap.md
---

# Adaptive CTRM — Executive Summary

Full analysis: [adaptive-ctrm-gap-analysis.md](adaptive-ctrm-gap-analysis.md). Grounded in code as of 2026-04-21 across [../../../trackon-aws-backend](../../../trackon-aws-backend) and [../../../react-ui](../../../react-ui).

## Current state (one paragraph)

TrackonAI has the **plumbing** for an adaptive platform — universal DynamoDB metadata table, S3 Tables/Iceberg with schema evolution, AVP for RBAC, 35 production Step Functions, a Jinja2 document engine, and a BPMN-style workflow editor — but the **runtime edit path a customer admin needs is incomplete on every one of the seven adaptive tests**. Entity metadata is write-once ([no `update_entity_metadata` resolver](../../../trackon-aws-backend/src/resolvers/)). Field rendering is a hard-coded Syncfusion JSX cascade in [dialogFormTemplate.tsx:1517-2000](../../../react-ui/src/components/Entity/dialogFormTemplate.tsx#L1517-L2000). The flow designer exposes 17 of 35 state-machine capabilities and silently drops half the parameters it collects. Reports are hand-written SQL; new entities don't auto-appear. Every integration hard-codes entity field names. And nothing is versioned — there is no blueprint table, no rollback, no safe migration primitive.

## Scorecard on the seven-point test

| # | Test | Grade |
|---|---|---|
| 1 | Add/modify entity with RBAC inheritance | **Partial** — create only; no update path; role policies backfilled manually |
| 2 | Add/modify field with validation + computed values | **Fail** — no update path, no validation language, no expression engine |
| 3 | Design/modify screens | **Fail** — no designer UI; field renderers hard-coded |
| 4 | Add/modify workflows triggered by CRUD | **Partial** — 17/35 nodes; injector drops params; triggers only exact-match |
| 5 | Surface new entities/fields in reports | **Fail** — no `listReportEntities`; SQL hand-written |
| 6 | Generate documents referencing new fields | **Partial** — Jinja2 works, but context is pre-fetched by hand |
| 7 | Integrations pick up new fields automatically | **Fail** — every integration hard-codes field names |
| — | Versionable with diff/rollback/migration | **Fail** — no blueprint tables, no Step Function aliases |

**0 Pass, 3 Partial, 4 Fail + versioning Fail.** Not defensible today.

## Top 5 blockers

1. **Blueprint versioning** (5-table design + Step Functions alias flip + migration executor + admin UI) — cross-cuts everything. **~13–16 dev-weeks**.
2. **Schema-driven screen designer** (JSON descriptor + generic `<FieldRenderer>` + dnd-kit designer + field-level RBAC). **~11–14 dev-weeks**.
3. **Flow designer parity** (fix [inject_node_parameters](../../../trackon-aws-backend/src/utils/step_function_management.py#L125-L136), add Map/Pass/Retry, expose hedge + contract-lifecycle nodes, pass workflow parameters into execution input). **~6–8 dev-weeks**.
4. **Report auto-discovery** (`listReportEntities` + `REPORT_BUILDER_TEMPLATE` + metadata-driven join generator + default-query hook in [create_entity_step_function.asl.json](../../../trackon-aws-backend/src/statemachine/create_entity_step_function.asl.json)). **~5–7 dev-weeks**.
5. **Integration mapping layer** (`INTEGRATION_FIELD_MAPPING` entity + generic adapter Lambda + migrate Datalastic / journey-tracker first). **~3 dev-weeks MVP, ~7–9 full**.

Plus two essentials folded into the above: **`update_entity_metadata` resolver** (~2 wks, no update path exists today) and **field-level RBAC** (~2 wks, surfaces in the renderer via AVP).

## Realistic timeline for the claim

| Scenario | Duration | Calendar date |
|---|---|---|
| **A — Bibeesh solo full-time** | ~49 dev-weeks serial | ~12 months → **2027-Q2** |
| **B — Bibeesh + one senior contractor** | ~30 weeks with overlap + 20% buffer | ~7 months → **2026-Q4** |
| **C — De-scope (drop B4, minimum B5)** | ~22 weeks | ~5 months → **2026-Q3** — but claim weakens on points 5 and 7 |

Recommendation: **Scenario B**, on-board a senior contractor who takes the screen designer + report builder track while Bibeesh owns blueprint versioning and the flow designer. Lock the ScreenLayout descriptor schema and the blueprint DDB PK/SK patterns in week 0 — they are the cross-cutting interfaces.

## Risks and open questions

- **R1.** Blueprint versioning scope creep — every metadata type discovered adds snapshot/diff/migration work. Mitigation: hard interface freeze after M1.
- **R2.** Flow-designer parameter fix will change the ASL of live tenant workflows. Must ship behind Step Function alias versioning (i.e. after blueprint M5).
- **R3.** Iceberg schema-evolution edge cases (type change, rename) are not lossless. Need explicit customer-facing guarantees.
- **R4.** Bus factor on Bibeesh for blueprint versioning. Prepare a contractor onboarding pack against that module.
- **Q1.** Which three integrations are required for the v1 Adaptive claim? (default proposal: Datalastic + one bank-file + one carrier tracker.)
- **Q2.** Do we accept "reports populate after first data arrives" or do we need synthetic first-row on entity create?
- **Q3.** Field-level RBAC: role-based enough, or attribute-based required?
- **Q4.** Can we re-scope marketing to "Composable CTRM" for v1 and call it "Adaptive CTRM" when B4 + full B5 ship, buying ~2 months?
