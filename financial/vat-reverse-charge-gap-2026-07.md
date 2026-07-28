---
type: finding
status: open
tags: [vat, tax, compliance, reverse-charge, fta, confidential]
created: 2026-07-28
updated: 2026-07-28
source: conversation (Murat, during Econz/Google Workspace evaluation)
related: [_personal/commercial/google-workspace-econz-offer-2026-07.md, _personal/financial/loan-balance-transfer-2026-04.md]
---

# VAT reverse-charge gap — imported services never declared

Related: [[_personal/commercial/google-workspace-econz-offer-2026-07|Google Workspace Econz Offer]]

## Finding (Murat, 2026-07-28)

Trackon has **never applied the reverse charge mechanism (RCM)** on imported services (Google Workspace, and presumably AWS and other foreign SaaS). Foreign supplier fees were booked purely as expenses and deducted.

Note the distinction Murat's statement conflated:
- **Expense deduction** = corporate tax (9%) treatment — this was done and is correct in both scenarios.
- **VAT RCM** = separate 5% mechanism: a VAT-registered UAE business receiving services from abroad must self-declare 5% output VAT and simultaneously deduct the same 5% as input VAT in the same return. Net tax = zero, but the declaration is mandatory.

## Status confirmed (Murat, 2026-07-28)

- **Trackon FZCO IS VAT-registered.**
- **AWS charges 5% UAE VAT on its invoices** → AWS is normal input VAT, NOT an RCM case.

So the RCM gap applies to suppliers whose invoices carry **no UAE VAT line**: Google Workspace confirmed (~€68/yr of net-zero undeclared RCM — immaterial per year); check the rest (Anthropic/OpenAI, GitHub, Atlassian, Syncfusion, Oracle Cloud, etc.). Gap is real but administrative: no unpaid tax (output 5% = input 5% in same return); fix going forward, accountant judges voluntary disclosure for past periods.

## NEW question — potentially real money: is AWS input VAT being reclaimed?

Murat's description ("paid the whole fee as an expense, deducted all as expense") raises the question of whether the 5% VAT AWS charges is being **reclaimed as input VAT in the returns** or just expensed gross. If expensed gross and unreclaimed: that's recoverable cash equal to 5% of the entire AWS spend (TrackonAI production infra — likely the largest single recoverable amount), plus the same for any other VAT-charging supplier. Input VAT can typically be recovered via voluntary disclosure/adjustment within the statutory time limits — the older it gets, the more falls out of reach.

## Action

Two questions to the accountant:
1. *"Are we reclaiming input VAT on AWS (and other 5%-VAT supplier) invoices in our returns, or expensing them gross? If unreclaimed, how much of the past spend is still recoverable?"*
2. *"Are we declaring reverse charge on foreign invoices with no UAE VAT line (Google Workspace etc.)? If not, start now — do past periods need a voluntary disclosure?"*

## Impact on Econz vs Google decision

Tilts further toward **Google direct**: Google charges no VAT (RCM is net-zero paperwork), while Econz's 5% (AED 214.20) is cash out that only comes back through the very VAT-return process Trackon hasn't been using. If not VAT-registered at all, Econz's VAT is a hard cost.

*Not tax advice — verify with the accountant.*
