---
type: commercial
status: active
tags: [pricing, deals, SLA, revenue, strategy]
created: 2026-03-30
updated: 2026-08-26
source: conversation-history
related: [customers/agrisar/agrisar-health, customers/mana/mana-health, _personal/commercial/deal-log, _personal/strategy/open-threads, _personal/prospects/spectrum]
---

# Pricing & Commercial Decisions

Customers: [[customers/agrisar/agrisar-health|Agrisar]], [[customers/mana/mana-health|Mana]] | Related: [[_personal/commercial/deal-log|Deal Log]], [[_personal/strategy/open-threads|Open Threads]]

## Benchmark: Market Comparison (as of Jan 2026)

| Solution | Cost Profile |
|----------|-------------|
| SAP Business One | 2–3x TrackOn monthly fee; hourly charges for support and customization on top |
| TrackOn Customer 1 | $10,000/month, 30 users, 2 branches → $333/user |
| TrackOn Customer 2 | ~$10,000/month, 20+ users → ~$500/user |
| Agrisar (Ashley) | ~$3,400/month, 35 users, 15 branches → $128/user |
| Turkish logistics | $1,250/month, 6 users |

---

## SLA Template — Agrisar (Drafted Jan 2026)

**Package proposed:** $2,500/month  
**Includes:**
- Priority response: Urgent 2h / High 4h (vs standard 8–24h)
- Queue priority — tickets never overridden by other customers
- 10 dedicated dev hours/month included
- Additional dev at discounted rate ($75/hour vs $100 standard)

**Ashley's response (Jan 22, 2026):** Deferred. "Budget constrained." Wants 2026 budget alignment. Requested 2025 contracts for auditors first.

**Murat's position:** SLA is optional add-on. Base TrackOn fees and TradingDocs are not negotiable.

---

## Shipment Tracking — Mana Pricing Decision

**Current:** $580/month API pass-through (SeaRates)  
**Issue:** Visible line item invites recurring dispute  
**Decision (Feb 2026):** Move to bundled "Shipment Tracking Service" monthly fee covering API cost + 60+ hours of unpaid development already delivered + ongoing maintenance  
**Rationale:** No individual line item to dispute; scales with contract value at renewal rather than triggering per-shipment negotiation

---

## E-Invoicing Cost Model (Jan 2026)

**Decision:** Pass ASP costs directly to customers — passthrough billing model  
**Structure:** Customer contracts directly with ASP; TrackOn charges for e-invoicing module/integration separately  
**Preferred ASP:** Flick Network (local UAE team, ERP-partner focused, JSON accepted)  
**Backup:** ClearTax  
**TrackOn's revenue from this:** E-invoicing module development fee (to be defined)  
**Timeline pressure:** ASP appointment required by July 2026; mandatory compliance Jan 2027 for AED 50M+ revenue companies

---

## Upsell Pipeline (Active)

| Customer | Product | Monthly Value | Status |
|----------|---------|--------------|--------|
| Agrisar | TradingDocs.AI | $1,000 | Agreed in principle, not activated |
| Agrisar | SeaRates API integration | $500 | Pitched, not confirmed |
| Agrisar | SLA Premium | $2,500 | Deferred by Ashley to 2026 |
| Turkish logistics | Upgrade to TrackOn AI pricing | $550 uplift | Planned at Gulfood |

---

## Development Pricing Policy

- Standard dev rate: $100/hour
- SLA-included dev: discounted to $75/hour
- Tracking system: 60+ hours delivered at no charge (historical; not to repeat without contract)
- General principle: Stop absorbing scope expansions without contract amendments

---

## Legacy API — Monetization Stance (2026-08-19)

The Trackon Legacy API is a **Trackon product surface, not a DFA deliverable** (framing decided 2026-07-29). DFA/Mana pays for their integration services + recurring support; Trackon retains the platform IP. **Every future Legacy customer wanting the API is charged again**: per-tenant enablement + their integration/endpoint work + their own recurring support fee. The reuse advantage is Trackon's margin (delivery gets faster/cheaper per customer), not a discount obligation. No exclusivity, royalty, or co-ownership is granted to DFA anywhere in the proposal or SDD; keep it that way, and do not advertise other tenants' use of the platform to DFA.

## Product Pricing Anchors (2026)

- **Pikiflow** (Murat, 2026-08-13): first few customers free (design partners); at go-live price **Jira-comparable, ~$15/user/month** as anchor. Open refinements: small platform minimum per tenant (real per-tenant infra: S3 Tables, DDB vector indexes, AVP); fetch-only workers possibly below the anchor.
- **TradingDocs LC Comparison**: standalone line was **$399/month**; strategic direction is bundling into TrackonAI to remove that line for SME deals ([[products/tradingdocs/tradingdocs-roadmap]]).
- **Longulf proposal (TradingDocs, Feb 2026)**: $22K year-1 = $10K implementation + $1K/mo — expired Mar 20; detail in [[_personal/prospects/longulf]].
- **Trackon Legacy rate card (AED, excl. VAT; used on Newco Jul 2026 and Spectrum Aug 2026 decks)**: shared platform fee **4,593/mo**; standalone single-AZ 10,475/mo; standalone multi-AZ (DR) 20,950/mo (+25–35k one-time setup); full user **765/user/mo**; dashboard module 9,188/mo; reporting instance 10,475/mo. Standard implementation for an established trading company USD 30–40k; discounted packages: Newco (greenfield) AED 15,000, Spectrum (POS app pre-built, but established multi-shop business needing discovery) AED 45,000, itemised. Murat's rule (2026-08-26): never under-price discovery on an existing business; requirements work is real time.
- **Legacy restricted-app user tier (decided 2026-08-26, Spectrum)**: users who only get the APEX mobile POS app (shop staff: sell, receive stock, expenses) are priced at **AED 190/user/mo, 75% below the full seat**. Rationale: focused app, no full ERP access; makes 30–40-user retail footprints affordable while HO seats stay at list. Reusable for any future Legacy customer with field/shop staff on the APEX apps.
- **TrackonAI in AED**: list USD 299/user = **AED 1,098/user/mo**, no platform fee. Shop/restricted users offered at the same AED 190 as Legacy (Spectrum Option B). TrackonAI implementation with custom mobile screens: AED 65,000 (Spectrum).
- **Subscription start rule (Murat, 2026-08-26, Spectrum)**: the subscription starts **when the customer's environment is provisioned (week 1 after acceptance), NOT at go-live**. The standard 50%-off-first-3-months onboarding offer runs over the implementation period, full rate from month 4. Reason: if billing only starts at go-live, the customer pays the implementation fee and then drags the implementation indefinitely at Trackon's cost. Implementation invoiced on acceptance (see [[_personal/strategy/strategic-decisions]]).
- **Timeline rule (Murat, 2026-08-26)**: do not promise 6-week go-lives. Standard Legacy plan: ~6 weeks system ready + ~4 weeks customer testing + go-live, ≈ 3 months.

---

## Mana / DFA — Buyer Behaviour & Salesforce Integration (Jun 2026)

**Price sensitivity lesson — Power BI proposal (earlier 2026):** Murat sent DFA a proposal to expose Trackon data for DFA's Power BI dashboards. Two options: (1) Daily CSV transfer — $20–50k setup + $2.5–7.5k/mo; (2) Dedicated DB — $35–70k setup + $5–5.5k/mo. **Justin found the cost huge and backed off the request entirely.** Takeaway: large upfront totals trigger retreat; lead with small, low-risk first steps.

**Salesforce → Trackon integration (active, quote due Jun 24 2026):**
- Quote structure: Phase 1 Design **$7,500 fixed** (PAID 2026-08); Phase 2 Build **$36–48k**, fixed after Phase 1. Total ~$43.5–55.5k one-time. Anchored on $100/hr internal rate. **UPDATE 2026-08-19: Phase 2 fixed quote set at $34,500 — deliberately below range for fast approval; full itemisation + support fee in [[_personal/commercial/mana-commercials]].**
- **Do NOT expose the $100/hr rate in the proposal** — invites hours-haggling ($48k ÷ $100 = "480 hours?"). Quote fixed/value tied to scope.
- **Do NOT bundle a standalone-instance migration.** Mana stays schema-per-tenant in shared Oracle DB; integration runs in front of the schema, low volume, no isolation forced. Bundling unrelated infra is what spooked Justin on Power BI.
- **Mitigating factor:** integration was discussed in person in Vietnam (Jun 2026) with Justin + Josh together. Justin personally invested this time, more inclined to approve — lower back-fire risk than Power BI. Phased structure still recommended, but sticker-shock fear is reduced.

See [[customers/mana/mana-health]] for full integration scope.
