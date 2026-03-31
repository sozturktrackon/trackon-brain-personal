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

## Proposed Billing (NOT AGREED)

- **$2.50/shipment is a PROPOSAL only** — sent to Josh and Joanna on March 30
- Josh has NOT responded as of March 31
- **Do not invoice until verbal acceptance received**
- Follow up on WhatsApp if no response by April 2
- Proposed mechanics:
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

## Current Status (March 31, 2026)

| | |
|---|---|
| **Mana proposal** | $2.50/shipment email sent to Josh and Joanna on March 30 |
| **Josh response** | No response on WhatsApp as of March 31 |
| **Agreement** | Verbal EUR 500/month only — no signed contract |
| **Emergency credits** | SeaRates provided 28 units — nearly exhausted |
| **Active shipments** | ~500/month at peak |
| **Expected revenue** | $1,000–$1,250/month at new rate |
| **Expected cost** | ~$550/month |
| **Expected margin** | $500–$700/month |

## Pending

- **Alexander (SeaRates)**: waiting for upgrade options and volume pricing
- **Count dispute**: SeaRates may be overcounting — Trackon has 529 unique shipments total vs. SeaRates February count exceeding that. Need Alexander to clarify counting methodology.
- **Josh (Mana)**: no WhatsApp response as of March 31
- If DFA needs to approve, SeaRates email is the key evidence (third party cost, not margin padding)
- Mana may request to hold EUR 500 rate for one month while getting internal approval — acceptable given relationship
- **New angle**: If SeaRates is overcounting, the actual cost may be lower than assumed. Wait for Alexander's response before finalizing Mana pricing.

## Mana Carrier Volume Analysis (352 total shipments)

| Carrier | Code | Shipments | % | Cumulative | Free API |
|---|---|---|---|---|---|
| CMA CGM | 2960 | 111 | 31.5% | 31.5% | Yes |
| MSC | 1482 | 82 | 23.3% | 54.8% | Yes (code exists in tradingdocs-backend) |
| Maersk | 13 | 35 | 9.9% | 64.8% | Yes (best documented) |
| Hapag-Lloyd | 2655 | 26 | 7.4% | 72.2% | Yes |
| COSCO | 2820 | 21 | 6.0% | 78.1% | Yes |
| ONE | 4660 | 18 | 5.1% | 83.2% | Yes |
| Evergreen | 2880 | 13 | 3.7% | 86.9% | Yes |
| OOCL | 2662 | 12 | 3.4% | 90.3% | Yes |
| HMM (combined) | 2731+4740 | 12 | 3.4% | 93.8% | Yes |
| Blue Anchor | 908 | 10 | 2.8% | 96.6% | Unlikely |
| Yang Ming | 940 | 4 | 1.1% | 97.7% | Yes |
| Others (5 carriers) | — | 8 | 2.3% | 100% | Mixed |

**Key finding**: Top 5 carriers = 78% of volume, all with free APIs. Top 9 = 94%.
Blue Anchor (10 shipments) is the only meaningful carrier without a clear public API.

## Revised Strategy — Direct Carrier Integration

See [[decisions/2026-carrier-direct-api-strategy]] for full decision record.

**Instead of fighting with Josh over $2.50/shipment, eliminate the cost:**
- Build direct API integrations for top 5 carriers (78% of volume, zero cost)
- Keep SeaRates for remaining 22% long tail — $1,650/year plan now lasts full 12 months
- Total cost drops from $6,600/year to ~$1,650/year
- At EUR 500/month from Mana = ~$4,350/year margin regardless of Josh negotiation

**Build order:**
1. CMA CGM — this week (31.5%)
2. MSC — port from tradingdocs-backend (23.3%)
3. Maersk — April (9.9%)
4. Hapag-Lloyd — April (7.4%)
5. COSCO — April (6%)

## Revised Economics

| Scenario | SeaRates/year | Direct API | Total cost | Mana revenue | Margin |
|---|---|---|---|---|---|
| Current (all SeaRates) | $6,600 | $0 | $6,600 | ~$6,000 | **-$600** |
| Top 5 direct + SeaRates tail | ~$1,650 | ~$0 | ~$1,650 | ~$6,000 | **~$4,350** |
| Top 9 direct + SeaRates tail | ~$800 | ~$0 | ~$800 | ~$6,000 | **~$5,200** |
| All direct (no SeaRates) | $0 | ~$0 | ~$0 | ~$6,000 | **~$6,000** |

## Jira Epic (approved architecture)

**[TNT-540](https://trackonsoftware.atlassian.net/browse/TNT-540)** — Direct Carrier Tracking — Reduce SeaRates dependency by 78%
- Assigned to: Hamza
- Estimated: 4 weeks

TLB-2658 superseded — created before full architecture analysis.

**Approved architecture:** Extend `fetch_journey_tracking.py` in trackon-aws-backend with carrier routing layer. No new Lambda functions, no new infrastructure. SeaRates fallback for unintegrated carriers.

| Sub-task | Key | Summary |
|---|---|---|
| 1 | [TNT-541](https://trackonsoftware.atlassian.net/browse/TNT-541) | Port carrier auth → carrier_auth.py |
| 2 | [TNT-542](https://trackonsoftware.atlassian.net/browse/TNT-542) | Hapag-Lloyd adapter (DCSA API — lowest risk) |
| 3 | [TNT-543](https://trackonsoftware.atlassian.net/browse/TNT-543) | CMA CGM adapter (31.5% volume) |
| 4 | [TNT-544](https://trackonsoftware.atlassian.net/browse/TNT-544) | MSC adapter (session login) |
| 5 | [TNT-545](https://trackonsoftware.atlassian.net/browse/TNT-545) | Maersk + COSCO adapters |
| 6 | [TNT-546](https://trackonsoftware.atlassian.net/browse/TNT-546) | Integration + SeaRates fallback + tests |

## Confirmed Implementation Detail (code review 2026-03-31)

**SCAC code is already available per journey in Oracle.**
- Stored in `TBL_SHIPPING_LINES.SCAC_CODE`, joined via `TBL_JOURNEY.SHIPPING_LINE_ID_SEQ`
- All major carriers already mapped (MAEU, MSCU, CMDU, HLCU, COSU, etc.)
- Current script passes SCAC as retry fallback only — needs to always pass on first call

**EC2 script change is 2 lines** in `process_journey()` at line 1570:
```
Before: call_searates_api(api_key, num, typ)
After:  call_tracking_service(function_url, num, typ, sealine=journey.shipping_line_scac_code)
```

**Tracking priority order** (unchanged): Booking Carrier (BK) → Booking Forwarder (BK) → BOL (BL) → BOL as BK.
Container tracking is deliberately disabled (reuse risk).

**Two separate tracking systems exist today:**
- Legacy (Mana): EC2 cron → `oracle_vessel_tracking.py` → SeaRates → Oracle TBL_JOURNEY
- TrackonAI: EventBridge → `fetch_journey_tracking.py` Lambda → SeaRates → DynamoDB
- Mana uses the Legacy path. The Lambda Function URL bridges both.

## Existing Code to Reuse

| File | Lines | Reusable For |
|---|---|---|
| `tradingdocs-backend/src/lambdas/fetch_container_tare_weight.py` | 4,001 | Auth patterns for all 5 carriers (Maersk OAuth, MSC session/S3, CMA scraping, Hapag portal, COSCO eLines) |
| `trackon-aws-backend/src/lambdas/fetch_journey_tracking.py` | 896 | SeaRates fallback, SCAC mapping, change detection, credit system |
| `trackon-build/utils/oracle_vessel_tracking.py` | 2,025 | SCAC code mappings, Legacy Oracle update patterns |

## Next Actions

- [ ] Follow up Josh on WhatsApp if no response by April 2
- [ ] Ozan starts TLB-2658: GQL resolver + CMA CGM adapter (Week 1)
- [ ] Port MSC auth from fetch_container_tare_weight.py (Week 2)
- [ ] Build cache layer on SeaRates for remaining carriers (30-40% API burn reduction)
- [ ] Continue Alexander count dispute — win = immediate cost relief on SeaRates tail
