---
type: commercial
status: active
tags: [pricing, deals, commercial-strategy, confidential]
created: 2026-03-30
updated: 2026-03-30
source: project conversations
related: [_personal/crm/contacts.md, _personal/strategy/strategic-decisions.md]
---

# Commercial Discussions & Deal Notes

## Pricing Model History

### Old Model (Abandoned)
- **Structure**: Page-credit based
- **Why abandoned**: Users sent fewer pages to conserve credits, which reduced extraction accuracy. Misaligned incentives — users optimized for credit consumption, not accuracy.

### Current Model (Shipment-Based, Live)
- One shipment = one complete document set, up to 100 pages
- Stripe checkout confirmed working in live mode
- Four tiers:
  | Tier | Shipments/month | Price/month |
  |---|---|---|
  | Starter | 20 | $299 |
  | Professional | 75 | $799 |
  | Business | 200 | $1,799 |
  | Enterprise | Custom | Custom |
- Annual billing: 2 months free
- Overage: $12 per additional shipment
- **No 30-day money-back guarantee** — replaced with "Cancel anytime, no commitment"
- Free LC check tool serves as no-signup free entry point

### Vessel Sanctions Add-On
- Separately priced: **$599/month** (as pitched to DFA)

---

## Deal-Specific Commercial Notes

### DFA (Justin)
- Original price point: ~$599/month (old page model, 2500 pages)
- Initial rejection: price-based
- Reset: Murat re-engaged with "loyalty pricing" framing at same $599 rate
- Justin's stated need: 5 users, under 2000 pages/month (peer review stage)
- Lesson: Don't over-pitch enterprise; match their stated need first
- Expand opportunity: Milk acceptance documents from farmer members (could be high-volume)

### Amee Foods (Dina)
- Requirements stated: 15 shipments/month, 3 users
- Proposal sent: $399/month for 20 shipments, 3 users
- **Strategy applied**: Advised not to lead with annual commitment for smaller prospects — let them experience value first, upsell annual later
- Outcome: Soft rejection ("still evaluating relevance")

### Midland Bank (Sami Rahman)
- Two deployment options presented in PowerPoint:
  1. **SaaS**: $59,000/year, 300,000 pages fair usage
  2. **Customer AWS deployment**: $135,000 initial + $1,000/month maintenance
- Optional add-ons (per-document or per-shipment):
  - 193-country regulations checking
  - Sanctions screening
  - Vessel intelligence
- IP protection was a key concern when discussing customer AWS deployment option
- Murat was transparent that Midland would be their first banking client

### Vault (On-Premise Appliance)
- Hardware: NVIDIA DGX Spark
- Pricing discussed: **$25,000 hardware + $24,000 annual license**
- Pricing was excluded from press release to maintain negotiation flexibility
- 3-month delivery backlog used as a demand/urgency signal
- First targets for Vault pitch: Justin (DFA) and Sami (Midland Bank), timed for January 2026

### Droplinked
- Master sales agreement in place
- AppSync/GraphQL API integration in progress (partner integration)
- L/C validation component expected to be delivered
- Macwise Capital came through this channel as a prospect

---

## Pricing Strategy Principles (from conversations)

1. **Don't lead with annual for smaller prospects.** Let them experience value first.
2. **Vault pricing excludes numbers publicly** — maintain negotiation flexibility.
3. **Backlog as social proof**: 3-month delivery backlog signals demand.
4. **Enterprise pricing should reflect problem scale**, not just volume metrics.
5. **Add-ons (vessel, sanctions) are separately priced** — don't bundle by default.
6. **Legacy plan name mapping needed** in UI (`getPlanDisplayName()` function) for backwards compatibility.
