---
type: customer
status: active
tags: [agrisar, legal, dispute, commercial, confidential]
created: 2024-01-01
updated: 2026-03-30
related: [customers/agrisar/overview]
---
# Agrisar — Open Issues (Confidential)

Customer: [[customers/agrisar/agrisar-overview|Agrisar]] | Related: [[decisions/2024-csv-only-data-export|CSV Export Policy]], [[_personal/legal/agrisar-account-notes|Account Notes]], [[_personal/legal/msa-rollout-strategy|MSA Strategy]]

Moved from `customers/agrisar/open-issues.md` during vault sanitization.

## Active Legal Issues

### 1. DB Schema Access Dispute
- **Status**: Ongoing
- Agrisar continues to request direct Oracle DB access and schema documentation
- Trackon position: firmly denied per CSV-only export policy
- Agrisar has involved their own third-party developer who has separately requested DB credentials
- Risk: Agrisar may frame this as a data portability / ownership issue in MSA negotiations
- Trackon response: customer data is fully exportable via CSV at any time; schema IP is separate from data ownership

### 2. MSA Negotiation Status
- **Status**: In progress
- MSA + ISV rollout underway with ALBM Excello Law (Richard Ding)
- Agrisar pushing for modifications to standard IP ownership clauses
- 12-month legacy pricing grace period offered as concession
- <!-- TODO: Track latest negotiation round and outstanding redlines -->

### 3. Third-Party Developer Access
- **Status**: Denied
- Agrisar requested Trackon grant their external developer access to production environment and DB
- Denied on security, IP, and liability grounds
- MSA explicitly codifies: no third-party access without Trackon written consent
- Risk: Agrisar may attempt to position this as a support failure ("we need integrations you won't build")

## Active Commercial Issues

### 4. Pricing Post-MSA
- **Status**: Agreed in principle
- 12-month grace period at current (legacy) pricing after MSA signature
- Post-grace pricing to be renegotiated — <!-- TODO: Define target pricing and timeline -->
- Risk: Agrisar may delay MSA signature to extend legacy pricing indefinitely

### 5. Support Scope Clarity
- **Status**: To be defined in MSA
- Historical support was ad-hoc with no formal SLA
- MSA will define support tiers, response times, and what constitutes "included" vs. billable work
- <!-- TODO: Define support tier structure for Agrisar -->
