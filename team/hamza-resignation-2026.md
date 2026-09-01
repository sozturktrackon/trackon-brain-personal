---
type: team
status: active
tags: [team, hamza, resignation, hr, confidential]
created: 2026-09-01
updated: 2026-09-01
related: [company/team/hamza, _personal/team/equity-arrangements, _personal/strategy/bibeesh-bus-factor-risk]
---
# Hamza Resignation (2026-09-01) — Confidential

## What happened

- 2026-09-01: Argument between Murat and Hamza in the team group chat (same day as the resignation email).
- 2026-09-01 11:17: Hamza sent a formal resignation email to Murat.

## Resignation letter facts (verbatim from email)

- Dated 01-09-2026, addressed to "The CEO, Trackon Software DMCC, JLT Dubai"
- Subject: "Resignation from Software Release Configuration Manager"
- Reason stated: personal reasons
- Effective from: **2026-09-01**
- Notice period: one month
- Last working day: **2026-09-30**

Notes on the letter itself:
- Role named in the letter is "Software Release Configuration Manager" — brain records his actual role as Implementation Head ([[company/team/hamza]]). Likely his contractual title.
- Entity named is "Trackon Software DMCC" (brain elsewhere says FZCO) — check which entity his contract is actually with before processing the exit.

## Decision (Murat, 2026-09-01)

- Accept the resignation; notice period runs to **2026-09-30**, salary paid in full at month end. No pay-in-lieu / early-release fight.
- Access is restricted **gradually and openly** during September — Hamza is told up front that access narrows as handover completes. NOT a single-day sweep.
- Hamza is an **international employee (remote, India)** — no UAE visa to cancel; exit is contract + payroll + access only.

## Open questions / to decide

- [ ] Accept as-is, or talk first? The argument immediately preceded the email — this may be heat-of-the-moment rather than a settled decision.
- [x] Phantom equity: NOT an issue. Murat confirmed (2026-09-01) no equity was ever actually shared or formalized; the 5% in [[_personal/team/equity-arrangements]] was a planned allocation only. Hamza holds nothing.
- [ ] Verify contractual entity (DMCC vs FZCO) and notice-period terms.
- [ ] Handover plan if the resignation stands — see knowledge-loss risks below.

## Access restriction plan (gradual, per decision above — communicated openly to Hamza)

Murat's belief (2026-09-01): his AWS accounts are linked to his email. VERIFY — that only holds if AWS login is federated (IAM Identity Center / SSO with Google as IdP). If he has a plain IAM user with long-lived access keys, those keys work regardless of email status. Check IAM → Users (his user, access keys, last-used) and whether Identity Center is in use.

Staging:
- **Day 1 (with acceptance email)**: customer databases, customer systems/tenant logins, AWS production. Handover does not require live customer data. Retrieve assets FIRST (training video library, local Athena report SQL).
- **During September**: narrow as each handover item completes (GitHub after code/SQL handover, Jira/Zendesk after ticket handover).
- **Sep 30**: suspend Google account (kills SSO incl. AWS if federated), final salary paid.

Full item list:

- [ ] Customer Oracle DB logins (Legacy, per tenant instance) + rotate shared schema/app passwords he knows — LARGEST exposure
- [ ] SSH keys on EC2 (trackon-build deploy boxes), VPN certs/accounts, IP allowlists
- [ ] AWS IAM user + long-lived access keys (he has prod data access from the Athena migration)
- [ ] GitHub org removal (identity: HAMZA BOHARI)
- [ ] TrackonAI tenant admin users — audit per-tenant user lists, disable his accounts
- [ ] Jira, Zendesk, DeskTime (ID 382061)
- [ ] Rotate shared secrets he knows: jira_deploy.env creds, API keys, shared-vault items
- [ ] Google Workspace: SUSPEND, do not delete (preserves mailbox for handover/dispute evidence)
- [ ] Check DB audit logs + CloudTrail for unusual exports/bulk queries since the argument
- [ ] Data clause in the waiver/settlement: deletion of company + customer data from personal devices (he's in Pune on own hardware — contract is the only lever over local copies), reaffirm confidentiality

## Knowledge-loss risk if he leaves

Hamza is the sole owner of ([[company/team/hamza]]):
- All reporting work (SQL reporting on Legacy + TrackonAI; Athena migration reports TNT-554, 558–563 mostly incomplete)
- Legacy dashboard development
- Training content — his training video library is still unpublished (was pending Murat uploading to YouTube)
- Accounting domain expertise (GL, aging, trial balance, e-invoicing)
- Customer onboarding/implementation lead
