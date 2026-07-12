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

## What the contract does / does NOT include (clarified 2026-07-12)

- **Does NOT** grant any Oracle DB license rights: no on-prem, no embedded/redistribution (ESL/ASFU), no perpetual licenses. It is a plain cloud subscription under OCSA v062223.
- **Does** allow running Oracle DB for customers *within OCI* via license-included DB services (e.g., Base Database Enterprise $0.4301/OCPU/hr; BYOL rate $0.1935 for license owners) — but that is available on any paid OCI account incl. PAYG, not a benefit of the commit.
- Net benefit of commit vs PAYG: quarterly Net-60 invoicing (vs card billing) + Support Rewards eligibility (only if paying Oracle on-prem support).

## Churn risk exposure (2026-07-12)

Fixed $15K commit vs PAYG means customer churn risk is Murat's for this contract year (e.g., a Legacy customer cancels, or Trackon terminates Agrisar). Mitigations:

- Exposure = unused portion only (churned share × remaining months), not the full $15K.
- Credits are fungible across ALL OCI services — redirect freed credits to staging/dev, backups/DR, AWS workload migration, OCI GenAI, etc.
- Trackon-initiated terminations (e.g., Agrisar) can be timed near contract year-end (~spring 2027) to minimize stranded credits.
- Next cycle: PAYG, or commit only to a certain floor (overage prices identically to PAYG anyway).

## Consumption forecast vs commit (2026-07-12)

- Baseline: current Oracle-on-AWS spend ≈ **$1,200/month**, mostly AWS Reserved Instances: staging DB prepaid ~60 days (to ~mid-Sep 2026), UDA prod DB prepaid ~120 days (to ~mid-Nov 2026).
- **All three commitments (AWS staging prepay, AWS UDA prepay, OCI $15K) are sunk** — timing should minimize AWS *on-demand* exposure only. True deadlines: staging → OCI by mid-Sep; UDA prod → OCI by mid-Nov; on-demand bits ASAP. Migrating staging earlier is fine (rehearses runbook, costs nothing marginal).
- Full OCI run-rate only from ~month 5 → est. **$8–10K consumed by Jul 2027, $5–7K stranded**. Worse if "OCI 40% cheaper than AWS" (rep claim) holds. Soak surplus: OCI staging env now, ORDS Salesforce API, APEX pilot, DR/backups (see [[products/trackon-legacy/legacy-apex-modernization-assessment|APEX assessment]]).
- **UDA caveat**: UDA is a TrackonAI migration candidate ([[products/trackon-legacy/legacy-roadmap|roadmap]]) — its OCI workload may disappear next contract year. Renewal Jul 2027: PAYG or much smaller commit, based on observed run-rate.

## End-of-term playbook (services period ends ~Jul 2027)

- Commitment does **not** auto-renew into another year. Default behavior: auto-converts to **Pay As You Go** (usage billing, no commitment).
- To terminate fully: email **cloudterminations_ww@oracle.com** at end of the services period and tear down resources.
- Unused credits forfeited; full $15K owed regardless of consumption. **Check consumption at month 9–10 (~Apr–May 2027)** — if under-using, shift eligible legacy workloads onto OCI to burn paid credits.
- **Decision point ~Jun 2027**: replenish (negotiate discount then) / drift to PAYG / terminate.
