---
type: commercial
status: active
tags: [einvoicing, asp, compliance, pricing, trackon-fzco, confidential]
created: 2026-09-10
updated: 2026-09-10
source: web research (mof.gov.ae register, vendor pricing pages), 2026-09-10
related: [decisions/2026-uae-einvoicing-mandate, company/legal/uae-einvoicing-asp-accreditation-md64-2025, _personal/financial/vat-reverse-charge-gap-2026-07]
---

# Trackon Software FZCO — own e-invoicing ASP: cost comparison (Sep 2026)

Context and non-monetary evaluation: [[decisions/2026-uae-einvoicing-mandate]].
Volume: ~10 invoices/month, ~120/yr. Need: manual web entry, no integration.
Deadline: ASP appointed by 31 Mar 2027, live 1 Jul 2027 (Trackon is < AED 50M revenue).

| Option | Accreditation (MoF, 10 Sep 2026) | Published price | Notes |
|---|---|---|---|
| **Zoho Books Standard** | Fully accredited (Zoho Software Trading LLC) | AED 60/mo billed yearly (AED 720/yr) or AED 69 month-to-month; 3 users; 5,000 invoices/yr; VAT tracking + direct VAT filing | E-invoicing terms for UAE not yet published; confirm no per-invoice fee and the 100 free exchanges/yr |
| Zoho Books Free | same | AED 0 | Only if FY revenue ≤ AED 200,000; not applicable to Trackon |
| **Wafeq Starter** | Pre-approved only | ~AED 690/yr annual (~AED 57/mo) or ~AED 69 month-to-month; "invoicing only" tier | E-invoicing included in all plans; Plus ~AED 960/yr, Premium ~AED 2,400/yr |
| Complyance | Fully accredited | Starter USD 125/mo (1,000 credits), Pro USD 249/mo; 14-day free trial with 1,000 credits | Credit model, 10 credits = USD 1; plans published for KSA/Malaysia, UAE not itemised |
| Casim, eezi (VATit), InvoiceNow.biz | Fully accredited | Not published; quote on request | Casim and eezi confirm manual-entry web portals |
| ClearTax | Fully accredited | Minimum USD 1,000/mo (meeting, Mar 2026) | Rejected |

Legal floor: every ASP must give 100 free e-invoice exchanges + reporting per end user per year
(MD 64/2025 Art 10(4)). Our 120/yr overshoots by ~20 exchanges; only matters for per-invoice
priced ASPs, not for Zoho/Wafeq subscriptions.

**Superseded 2026-09-10 (same day):** Murat clarified that Trackon's own invoices come from
Trackon Legacy, so the Zoho/Wafeq accounting-app route is off the table (see ADR). Trackon
will run its own invoices through the Legacy → ASP adapter. Cost target for our own volume:
AED 0 for the first 100 exchanges/yr (legal floor), a per-invoice overflow charge for ~20
more. Get API-tier quotes at 120/yr from Mac & Ross, Complyance, Flick, Covoro, Taxlabs; the
Zoho and Wafeq rows above stay as competitor price references only.
