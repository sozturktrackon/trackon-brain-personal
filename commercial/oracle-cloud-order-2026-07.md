---
type: vendor-quote
status: pending-review
tags: [oracle, oci, vendor, cloud, quote, confidential]
created: 2026-07-10
updated: 2026-07-11
source: Oracle ordering document PDF (1224634431.a1_OrderingDocumentWatermarked.pdf, ~/Downloads)
related: [_personal/commercial/syncfusion-renewal.md, _personal/commercial/deal-log.md]
---

# Oracle Cloud (OCI) Ordering Document — $15,000 Universal Credits, 12 months

Related: [[_personal/commercial/syncfusion-renewal|Syncfusion Renewal]], [[_personal/commercial/deal-log|Deal Log]]

Draft ordering document (watermarked "NOT FOR SIGNATURE") received 2026-07-10 from Oracle Systems Limited, Dubai Internet City.

## Commercial summary

| | |
|---|---|
| Contract order reference | 1224634431.a1 |
| Customer of record | **TRACKON SOFTWARE DMCC** (old suffix — company is now FZCO) |
| Contact | Murat S, sozturk@trackon.com (old domain) |
| Product | B88206 — Oracle PaaS and IaaS Universal Credits |
| Credits | 15,000 annual, 12-month services period |
| Total | **USD 15,000** |
| Payment | Net 60 from invoice, **quarterly in advance** |
| Offer valid through | **15-JUL-2026** (5 days from issue) |
| Discount | **0.0% on every cloud service category** — pure list-price rate card |

## Key terms to be aware of

- **Overage**: usage beyond the annual credit amount is invoiced at list rate-card prices (pages 3–29 of the doc).
- **No refunds**: unused credits at end of the 12-month period are forfeited.
- **End of term**: unless Trackon emails cloudterminations_ww@oracle.com to terminate, Oracle converts the account to Pay-as-You-Go. Full annual credit amount is owed even if unused.
- Governing agreement: Oracle Cloud Services Agreement v062223 (oracle.com/contracts).

## Flags before signing

1. **Wrong legal entity**: order names "TRACKON SOFTWARE DMCC" — the DMCC→FZCO suffix change is in progress (certificate + Mashreq request in ~/Downloads, Jul 2026). Ask Oracle to reissue under the FZCO name or the invoice/VAT chain will mismatch.
2. ~~Zero discount~~ — **resolved 2026-07-10**: Oracle confirmed discounts start at much larger commitments (~$100K+). At $15K, list price is normal; Murat accepts this.
3. Offer expires 15-JUL-2026 — but expiry dates on Oracle quotes are a sales lever; a reissued quote is trivial for them.

## Rationale (Murat, 2026-07-10)

The $15K/year commitment covers all cloud infrastructure needs for the legacy product ([[products/trackon-legacy|Trackon Legacy]]) — this replaces/covers what was on AWS for legacy. At that spend level the commit is justified and the 0% discount is acceptable; Oracle's discount tiers only kick in around $100K+ commitments.

## Early termination / cancellation (reviewed 2026-07-11)

- **No exit**: the 12-month commit is non-cancellable (OCSA v062223 allows termination for cause only). If business is lost mid-year, the full $15K is still owed; quarterly billing spreads cash flow but creates no exit points. Unused credits are non-refundable.
- **PAYG alternative**: since the order carries 0% discount, unit prices equal Pay-As-You-Go list prices. PAYG gives identical rates with zero commitment and cancel-anytime flexibility. Question for Oracle rep before signing: what does the annual commit give us at 0% discount that PAYG doesn't?

## Status (2026-07-11)

**SIGNED** — Murat signed the agreement (confirmed 2026-07-11). $15K/12-month Universal Credits commitment is live. Notes that no longer apply: PAYG-instead-of-commit consideration (moot). Still worth checking: whether the signed order was issued to FZCO or DMCC — if DMCC, ask Oracle to correct the entity for invoicing/VAT.

## End-of-term playbook (services period ends ~Jul 2027)

- Commitment does **not** auto-renew into another year. Default behavior: auto-converts to **Pay As You Go** (usage billing, no commitment).
- To terminate fully: email **cloudterminations_ww@oracle.com** at end of the services period and tear down resources.
- Unused credits forfeited; full $15K owed regardless of consumption. **Check consumption at month 9–10 (~Apr–May 2027)** — if under-using, shift eligible legacy workloads onto OCI to burn paid credits.
- **Decision point ~Jun 2027**: replenish (negotiate discount then) / drift to PAYG / terminate.
