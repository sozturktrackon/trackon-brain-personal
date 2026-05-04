---
type: decision
status: active
tags: [tradingdocs, pricing, conversion, web]
created: 2026-05-04
updated: 2026-05-04
related: [products/tradingdocs/tradingdocs-roadmap, products/tradingdocs/tradingdocs-overview, decisions/2026-tradingdocs-shipment-counting]
---

# ID Pricing Page CTAs — Route paid tiers to demo, keep self-serve as secondary

| | |
|---|---|
| **THE PROBLEM** | tradingdocs.ai/pricing.html shows five tiers (Free, Starter $299/mo, Professional $799/mo, Business $1,799/mo, Enterprise custom). After several weeks live, the page produced zero demos and zero paid signups. The only conversions were a handful of free L/C check uploads — most appearing to be intelligence-gathering rather than buying intent. Why isn't the page producing meetings? |
| **OPTIONS CONSIDERED** | 1. **Keep "Get Started" → Stripe Checkout on every paid tier.** Status quo. Assumes self-serve B2B web checkout works at $299–$1,799/mo for trade-finance buyers. Evidence says it does not — corporate trade ops won't expense recurring SaaS without procurement, MSA, invoiced billing.<br>2. **Replace pricing with small-amount subscriptions only ($20–$99/mo) for self-serve, custom links for big deals (friend's suggestion).** Right instinct (web doesn't close large recurring subs cold) but wrong shape — TradingDocs is consumption-shaped (per L/C, per shipment) and the credit-pack top-ups already exist for usage-based pricing. Building a small monthly tier would just compete with the existing credit packs and shrink ACV.<br>3. **Demo-first CTAs on all paid tiers, keep self-serve as a secondary "or start now" link, leave Free and Enterprise tiles unchanged.** Primary action becomes a 20-min Calendly booking; Stripe Checkout stays available but de-emphasized. Pricing tiles still anchor expectations; deals close via post-demo custom Stripe link or invoice. **Chosen.** |
| **EVIDENCE** | Live page audit 2026-05-04: zero demos booked, zero paid subscriptions, only free-check uploads with intelligence-gathering pattern. Site source confirmed: all four paid CTAs (Starter/Pro/Business + Enterprise) routed to either Stripe Checkout (`subscribe.html`) or Enterprise-only Calendly. No "Book a Demo" path existed for the $299–$1,799 buyer. Existing customer archetypes (AGS, Mana, Longulf, Gemini) all closed via human contact, never self-serve. Top-ups ($40/$200/$400 in `stripe_topup_handler.py`) exist but are tenant-only, not on the marketing page. |
| **REASONING** | Optimizing for: producing qualified demos with the existing traffic, before fixing volume. Facts: trade-finance buyers (banks, trading desks, freight forwarders) require human-led sales process; they don't subscribe blind from a marketing page. Logic: making "Book a Demo" the primary CTA on Starter/Pro/Business converts even the small qualified-traffic flow we already have into meetings. Self-serve link stays for the rare buyer who's already convinced. Tradeoffs: (a) we lose any theoretical self-serve conversion at Starter — but we weren't getting any anyway, (b) we add load on Murat's calendar — acceptable, that's the whole point. |
| **REBUILD ASSESSMENT** | Y. The original "Get Started → Stripe" pattern was copied from generic SaaS templates without considering the buyer persona. Starting from scratch for a trade-finance B2B product, the primary CTA on a marketing page should always be a calendar booking; self-serve checkout is a secondary path for warm buyers. |

## What changed

- `tradingdocs-saas-webpage/html/partials/_pricing_plans.html`: Starter/Pro/Business CTAs changed from `subscribe.html?plan=*` ("Get Started") to `https://calendly.com/trackon/tradingdocs-demo` ("Book a Demo"), with secondary link "or start now without a call →" preserving the self-serve path. CSS class `.plan-subscribe-link` added.
- Free tier and Enterprise tier unchanged.
- Deployed 2026-05-04.

## Next steps (separate from this decision)

1. **Sample report PDF as new primary lead magnet** — replace dependence on the free L/C check (which selects for intelligence-gatherers because real buyers won't upload counterparty L/Cs to an unknown vendor). Sample report = synthetic L/C + our actual output formatting, email-gated.
2. **Customer logos and proof strip** above the pricing grid — at minimum AGS/Mana/Longulf if permission, plus stat strip ("X documents processed, Y discrepancies caught").
3. **Forced nurture on free-check submissions** — drip sequence (sample report, ICC fraud case, demo bait, SDR follow-up for qualified domains).
4. **Free L/C check** — keep live until sample-report PDF is up, then evaluate. Do not remove yet.

## Related

- [[products/tradingdocs/tradingdocs-roadmap|TradingDocs roadmap]]
- [[products/tradingdocs/tradingdocs-overview|TradingDocs overview]]
- [[decisions/2026-tradingdocs-shipment-counting|Shipment-counting decision]]
