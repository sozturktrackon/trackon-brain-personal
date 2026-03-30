---
type: decision
status: active
tags: [csv-export, agrisar, dispute, confidential]
created: 2024-01-01
updated: 2026-03-30
related: [decisions/2024-csv-only-data-export]
---
# CSV-Only Export — Customer-Specific Context (Confidential)

Moved from `decisions/2024-csv-only-data-export.md` during vault sanitization.

## Agrisar-Specific Context

- Multiple customers — most notably Agrisar — have requested direct database access or raw schema exports from Trackon Legacy
- Agrisar specifically sought to grant their third-party developer access to the Oracle DB schema to build custom integrations and reports
- Creates friction with power-user customers (especially Agrisar)
- Agrisar has pushed back hard on this — risk of commercial tension or contract non-renewal if not managed carefully
- Must distinguish clearly: "your data, our schema." Customers own their trade data and can export it anytime via CSV. The schema structure is Trackon's proprietary implementation.
