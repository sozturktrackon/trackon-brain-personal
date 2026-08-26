---
type: prospect
status: active
tags: [prospect, trackon-legacy, trackonai, apex, pos, africa, proposal]
created: 2026-07-23
updated: 2026-08-26
related: [products/trackon-legacy/apex-pos-project.md, products/trackon-legacy/legacy-roadmap.md, _personal/commercial/deal-log.md, _personal/commercial/pricing.md, _personal/prospects/yalcintas-akdogan-newco.md]
---

# Spectrum DMCC — mobile POS prospect (Africa shops)

- Dubai-based (DMCC). Head office in Dubai buys goods, arranges **international shipping** and moves stock to a depot + shops in Africa (Kinshasa, DR Congo). Shop staff have **mobile phones only**.
- **Demo tenant**: APEX PWA at `app.trackon.com/spectrum`, schema `SPECTRUM` in PDB_UTC (see [[products/trackon-legacy/apex-pos-project|project base doc]]). Free to use for demo build/testing (Murat, 2026-07-23).
- Watchpoint: APEX is online-first. If shops have intermittent connectivity, offline entry is custom work. Stated as an assumption on the proposal (online app; offline = separately scoped).

## Meeting (Aug 2026, before 2026-08-26)
- Shown: **shop profitability** and the **new POS screens on APEX**, runs on any Android or iPhone.
- They stated **40 users**. They asked for a **commercial proposal**. Murat: "good feeling about them."
- Scope they described (Murat, 2026-08-26): shops **record their own expenses**, **accept goods**, **execute sales**; shops **add their own customers** = future. Head office handles international shipping and goods movement to the shops.

## Proposal (prepared 2026-08-26, not yet sent)
Deck + PDF: `_personal/commercial/spectrum/Trackon-Spectrum-Proposal.{md,pdf}` (built from `_templates/customer-deck-marp.md`). 13 slides: understanding, solution flow, HO coverage, POS app (ready + Record Expenses added + customers later), the work (6 workstreams), 6-week timeline, Option A pricing, Option B TrackonAI, Option B pricing, side-by-side, assumptions, next steps.

**Pricing (AED, excl. 5% VAT), assumed split 10 HO + 30 shop users (stated on deck; totals adjust at unit rates):**

| | Option A: Trackon Legacy (recommended) | Option B: TrackonAI |
|---|---|---|
| Platform fee | 4,593 (shared cloud, same rate card as Newco deck) | none |
| HO user | 765 (standard) | 1,098 (= USD 299 list) |
| **Africa shop user** | **190 (new tier, 75% off 765)** | **190 (same rate)** |
| Monthly, 40 users | **17,943** | **16,680** |
| Onboarding offer | first 3 months at 50% (8,972) | first 3 months at 50% (8,340) |
| Implementation, one-time | **30,000** (incl. Record Expenses screen) | **45,000** (incl. building shop screens on TrackonAI) |
| Go-live | 6 weeks | 10 to 12 weeks |

- Payment: implementation invoiced on acceptance (standard: always in advance); subscription monthly in advance **from go-live, not signature**.
- Validity / acceptance deadline: **25 September 2026**.
- Dedicated server: "available on request" only, no figure on the deck.
- Rationale: two-tier user pricing so the 30 shop users don't carry a full ERP seat; ~AED 450/user blended (~USD 122), in line with the Agrisar benchmark in [[_personal/commercial/pricing]]. TrackonAI shown honestly as the newer platform: lower run-rate, higher one-time, longer timeline; recommendation stays Option A because the POS app is built and demoed.

## Open before sending
- Contact name for the "Prepared for" line (deck currently says "Prepared for Spectrum DMCC" only; no email trail found in Gmail).
- Confirm the HO/shop user split if known; deck states 10/30 as an assumption.
- Decide whether the 50%-first-3-months onboarding offer stays (standard for smaller prospects per [[_personal/strategy/strategic-decisions]]).

## Delivery scope committed on the deck (if accepted)
- New POS screen **Record Expenses** (shop expense entry, HO approval, flows into shop profitability). Backlog line in [[products/trackon-legacy/trackon-legacy-backlog]].
- Branding (logo, receipt layout), per-shop config, home-screen install, HO process config, data load from Excel templates, standard report pack + shop reports, training, 2 weeks hypercare.
- Explicitly deferred: shops adding their own customers / selling on account; offline mode.
