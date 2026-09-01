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

This is the **first actual departure in Trackon's history**, but it is **Hamza's SECOND resignation** — he resigned once before and Murat talked him into staying. That history is why Murat feels he has to accept it this time (confirmed by Murat, 2026-09-01). He took it hard — he did not want to lose Hamza this way and wished it had worked out otherwise.

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

- [x] Decided (2026-09-01): accept, warmly. Murat is accepting "this time" (implies earlier resignation attempts were talked down) with a personal, grateful email — he values Hamza highly and is grateful for his patience through all the changes Murat introduced.
- [x] Acceptance letter finalized 2026-09-01 (Murat's own edits applied; sent from his own mailbox, not sales@). Confirms last working day 2026-09-30, credits UDA sale + reports + unseen daily customer work, states gradual access reduction during handover, door stays open.
- [x] Phantom equity: NOT an issue. Murat confirmed (2026-09-01) no equity was ever actually shared or formalized; the 5% in [[_personal/team/equity-arrangements]] was a planned allocation only. Hamza holds nothing.
- [ ] Verify contractual entity (DMCC vs FZCO) and notice-period terms.
- [ ] Handover plan if the resignation stands — see knowledge-loss risks below.

## Access restriction plan (gradual, per decision above — communicated openly to Hamza)

Murat's belief (2026-09-01): his AWS accounts are linked to his email. VERIFY — that only holds if AWS login is federated (IAM Identity Center / SSO with Google as IdP). If he has a plain IAM user with long-lived access keys, those keys work regardless of email status. Check IAM → Users (his user, access keys, last-used) and whether Identity Center is in use.

Staging:
- **Day 1 (with acceptance email)**: customer databases, customer systems/tenant logins, AWS production. Handover does not require live customer data. Retrieve assets FIRST (training video library, local Athena report SQL).
- **During September**: narrow as each handover item completes (GitHub after code/SQL handover, Jira/Zendesk after ticket handover).
- **Sep 30**: suspend Google account (kills SSO incl. AWS if federated), final salary paid.

### Audit findings (2026-09-01, live recon — read from AWS + GitHub this session)

- **GitHub**: org member as `hamzayb` (trackon-software org)
- **TrackonAI portal**: Cognito user `hamzayb@trackonsoftware.com` in prod pool `ap-south-1_y1OhTgLij` — ENABLED/CONFIRMED
- **AWS TrackonAI acct (980921753434)**: NO personal IAM user for Hamza; only shared IAM user `deploy` with one active access key (created 2025-02-07). If Hamza did Athena/CLI work he used these SHARED keys → rotate on exit. No IAM Identity Center instance found.
- **AWS TradingDocs acct (871773732706)**: IAM users agrisars3, cloudfronts3, sozturk — no Hamza.
- **Not verifiable from here**: Oracle DB accounts per customer, SSH authorized_keys on legacy EC2s (tenant inventory is runner-side in db_deploy_prod.sh), APEX workspace users, Legacy app users, Google Workspace, Jira/Zendesk, DeskTime.

### Scripts (in `_personal/team/offboarding/`)

- `hamza-access-audit.sh` — read-only, run anytime to see current state
- `hamza-access-revoke.sh stage1|stage2|stage3 [--execute]` — dry-run by default; stage1 = day-1 portal cutoff + manual same-day list, stage2 = GitHub removal after handover, stage3 = final-day checklist

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

## Legacy / credit (Murat, 2026-09-01)

- The **UDA sale was achieved thanks to Hamza's efforts** — Murat credits him with it explicitly in the acceptance email.
- His other defining contribution: the diligent build-out of the comprehensive report suite across the journey.
- Beyond the headline items: **day-to-day customer work as an "unknown soldier"** — quiet, constant, largely invisible support of customers. Murat had been actively trying to make this work more visible before the resignation.

## Gmail connector incident (2026-09-01) — process note

- The claude.ai Gmail connector on Murat's Claude account is authorized against **sales@trackonsoftware.com**, NOT his personal mailbox. An acceptance-letter draft was mistakenly created there (never sent); Murat deleted it himself.
- Rule going forward: **never use the Gmail connector without Murat's explicit instruction**, and verify the connected mailbox identity before any write. Murat to decide whether to disconnect the connector (claude.ai Settings → Connectors, or myaccount.google.com/connections as sales@).

## Knowledge-loss risk if he leaves

Hamza is the sole owner of ([[company/team/hamza]]):
- All reporting work (SQL reporting on Legacy + TrackonAI; Athena migration reports TNT-554, 558–563 mostly incomplete)
- Legacy dashboard development
- Training content — his training video library is still unpublished (was pending Murat uploading to YouTube)
- Accounting domain expertise (GL, aging, trial balance, e-invoicing)
- Customer onboarding/implementation lead
