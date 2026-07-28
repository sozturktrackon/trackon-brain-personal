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

## Two scenarios — establish which applies

**A. Trackon FZCO is NOT VAT-registered:** No RCM obligation; expensing was fully correct. Check registration obligation though: mandatory threshold (AED 375k/12mo) counts taxable supplies AND imports; zero-rated exports count as taxable supplies (exception from registration available if supplies are wholly zero-rated — worth confirming status with accountant).

**B. Trackon FZCO IS VAT-registered:** Non-declaration of RCM is a compliance gap. Substantively net-zero (output 5% = input 5% when input recovery is full), so no unpaid tax — exposure is administrative (incorrect-return penalties). Fix: start declaring RCM going forward; accountant to judge whether voluntary disclosure for past periods is warranted.

## The bigger fish

Workspace is ~AED 250/yr of VAT — immaterial. But the same treatment applies to **every foreign supplier that doesn't charge UAE VAT**. AWS is the big one (TrackonAI infra) — note AWS EMEA SARL may charge UAE VAT directly on invoices (check invoices: if 5% VAT line present → input VAT, recoverable, no RCM needed; if absent → RCM applies). Same check for: Anthropic/OpenAI, GitHub, Atlassian, Syncfusion, Oracle Cloud, etc.

## Action

One question to the accountant: *"Are we VAT-registered, and if so, are we declaring reverse charge on foreign software/cloud invoices that carry no UAE VAT? If we haven't been, do past periods need a voluntary disclosure?"*

## Impact on Econz vs Google decision

Tilts further toward **Google direct**: Google charges no VAT (RCM is net-zero paperwork), while Econz's 5% (AED 214.20) is cash out that only comes back through the very VAT-return process Trackon hasn't been using. If not VAT-registered at all, Econz's VAT is a hard cost.

*Not tax advice — verify with the accountant.*
