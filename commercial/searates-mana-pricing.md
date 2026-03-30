---
type: decision
status: active
tags: [mana, searates, pricing, tracking, vendor-cost, confidential]
created: 2026-03-30
updated: 2026-03-31
source: SeaRates_Pricing_Analysis.md
related: [customers/mana/overview, products/trackonai/journey-tracking, _personal/commercial/deal-notes.md]
---

# ID SeaRates Mana Pricing - Switch Mana vessel tracking from flat EUR 500/month to $2.50/shipment billing

| | |
|---|---|
| **THE PROBLEM** | Trackon provides vessel tracking to [[customers/mana/overview|Mana Agro DMCC]] via SeaRates API. The current verbal agreement (EUR 500/month flat) is unsustainable — SeaRates credits burn 4x faster than expected because SeaRates counts unique shipments per calendar month, not per journey lifetime. A shipment active across 2 months = 2 credits. Mana voyages span 3–4 months (worsened by Red Sea situation), so the 1,500-shipment annual plan exhausts in 3 months instead of 12. Actual annual cost: $6,600 vs. EUR 6,000 revenue. How should we restructure billing to be margin-positive? |
| **OPTIONS CONSIDERED** | 1. Continue EUR 500/month flat — simple but unsustainable, Trackon loses money at current volumes. 2. **$2.50 per unique shipment tracked per calendar month — chosen.** Billing based on maximum unique shipments tracked in a given month. Aligns Trackon cost with Trackon revenue. At ~500 active shipments/month: ~$1,000–$1,250 revenue vs. ~$550 cost = ~$500–$700 margin. 3. Pass SeaRates cost through at markup — transparent but exposes vendor pricing to customer. |
| **EVIDENCE** | SeaRates plan: $1,650/year prepaid for 1,500 unique shipments. Burned through in 3 months (Jan–Mar 2026). Cross-month double counting is the root cause, worsened by Red Sea situation extending voyage durations from 1–2 months to 3–4 months. Mana active shipment pool: ~300 new/month × 3+ months active = ~500+ at any time. March 2026: credits exhausted, API_KEY_LIMIT_REACHED errors (Journey #21436 failed). SeaRates credited 28 emergency units. **Count discrepancy identified**: Trackon's system records 529 total unique shipments across both tenants since API start — less than SeaRates' February count alone. Suspected overcounting by SeaRates. |
| **REASONING** | Optimized for: sustainable margin while preserving the Mana relationship. Facts: per-shipment billing aligns cost and revenue; tracking stops automatically on delivery or invoice payment, naturally limiting credit burn. Logic: $2.50/shipment × 500 shipments = $1,250/month revenue; SeaRates cost ~$550/month at current burn rate; margin ~$500–$700/month. Tradeoffs: more complex billing than flat rate — requires monthly report listing unique shipments as invoice backup; Mana accustomed to EUR 500 flat so transition needs justification (SeaRates email screenshot as third-party cost evidence, not forwarded directly to avoid vendor contact risk). |
| **REBUILD ASSESSMENT** | Yes — should have been per-shipment from the start. Flat rate obscured the true cost structure. |

## Agreement Status

- No signed agreement in place — verbal EUR 500/month deal only
- Two agreements drafted and sent to Josh (Mana) — neither signed
- Contract execution requires DFA (owner of Mana) — known bottleneck
- **Decision: proceed via monthly invoicing without a formal contract**
- Implied acceptance expected once Mana pays the first invoice

## Billing Mechanics

- $2.50 per unique shipment tracked per calendar month
- Billing based on **maximum unique shipments** tracked in a given month
- Tracking stops automatically on delivery or invoice payment
- Trackon to produce a monthly report listing unique shipments as invoice backup

## What Happened (March 2026)

- Ran out of tracking credits — new shipments started failing with API_KEY_LIMIT_REACHED
- Example: Journey #21436 failed tracking
- SeaRates credited 28 additional units as temporary fix
- Email sent to Josh and Joanna (CC) on 30 March 2026
- SeaRates email screenshot attached as proof (not forwarded directly to avoid vendor contact risk)

## SeaRates Vendor Negotiation (March 31, 2026)

- **Email sent to Alexander (SeaRates)** requesting upgrade options and higher-volume pricing
- Flagged Red Sea situation as root cause of extended voyage durations (1–2 months → 3–4 months)
- **Challenged SeaRates counting**: Trackon system records 529 total unique shipments across both tenants since API start, yet SeaRates' February count alone exceeds this. Screenshots shared as evidence.
- Asked for: upgrade options, pricing for higher volume plans
- **Pending**: Alexander's response with plan options and pricing

## Pending

- **Alexander (SeaRates)**: waiting for upgrade options and volume pricing
- **Count dispute**: SeaRates may be overcounting — Trackon has 529 unique shipments total vs. SeaRates February count exceeding that. Need Alexander to clarify counting methodology.
- **Josh (Mana)**: waiting for WhatsApp response on $2.50/shipment billing
- If DFA needs to approve, SeaRates email is the key evidence (third party cost, not margin padding)
- Mana may request to hold EUR 500 rate for one month while getting internal approval — acceptable given relationship
- **New angle**: If SeaRates is overcounting, the actual cost may be lower than assumed. Wait for Alexander's response before finalizing Mana pricing.

## Open Technical Questions

1. Can we build a local tracker that monitors active shipment pool size month-over-month and projects SeaRates credit consumption?
2. Can we estimate the break-even per-shipment rate dynamically based on average voyage duration?
3. Is there a way to optimise API calls — e.g. skip weekends, skip shipments within first 5 days of tracking — to reduce SeaRates burn without degrading service?
4. Should we cache SeaRates responses and only re-query after X hours to reduce API call count toward the 90,000/year cap?
