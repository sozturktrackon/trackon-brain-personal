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

## Proposal (prepared 2026-08-26, revised same day after Murat's review; not yet sent)
Contact: **Mr. Shilpen** (Spectrum DMCC; surname/email not yet on file). Deck + PDF: `_personal/commercial/spectrum/Trackon-Spectrum-Proposal.{md,pdf}` (built from `_templates/customer-deck-marp.md`). 14 slides: understanding, solution flow, HO coverage, POS app (ready + Record Expenses added + customers later), the work (7 workstreams incl. discovery), 3-month timeline, itemised implementation fee (A vs B), Option A pricing, Option B TrackonAI, Option B pricing, side-by-side, assumptions, next steps.

**Pricing (AED, excl. 5% VAT), assumed split 10 HO + 30 shop users (stated on deck; totals adjust at unit rates):**

| | Option A: Trackon Legacy (recommended) | Option B: TrackonAI |
|---|---|---|
| Platform fee | 4,593 (shared cloud, same rate card as Newco deck) | none |
| HO user | 765 (standard) | 1,098 (= USD 299 list) |
| **Africa shop user** | **190 (new tier, 75% off 765)** | **190 (same rate)** |
| Monthly, 40 users | **17,943** | **16,680** |
| Months 1 to 3 at 50% | 8,972 | 8,340 |
| Implementation, one-time | **45,000** | **65,000** |
| Go-live | ~3 months (6 wk ready + 4 wk testing + go-live) | 4 to 5 months |

Implementation itemisation (A / B): discovery & process design 10,000 / 10,000; setup + data load 10,000 / 10,000; shop app rollout incl. Record Expenses 12,000 / 32,000 (B builds shop screens on TrackonAI); reports 5,000 / 5,000; testing, training, go-live 8,000 / 8,000.

- **Murat's review decisions (2026-08-26)**: (1) implementation fee bumped from 30k to 45k (A) because requirements discovery on an established multi-shop business takes real time; B 45k → 65k; (2) timeline lengthened from 6 weeks to ~3 months: "6 weeks system ready, 4 weeks testing, ~3 months total"; (3) **subscription starts when the environment is provisioned (week 1, i.e. effectively at signing), NOT at go-live**, at 50% for months 1 to 3 then full rate: otherwise the customer pays implementation and drags the project. The 50% period deliberately coincides with the implementation period.
- Payment: implementation invoiced on acceptance (standard: always in advance).
- Validity / acceptance deadline: **25 September 2026**.
- Dedicated server: "available on request" only, no figure on the deck.
- Rationale: two-tier user pricing so the 30 shop users don't carry a full ERP seat; ~AED 450/user blended (~USD 122), in line with the Agrisar benchmark in [[_personal/commercial/pricing]]. TrackonAI shown honestly as the newer platform: lower run-rate, higher one-time, longer timeline; recommendation stays Option A because the POS app is built and demoed.

## Open before sending
- Mr. Shilpen's surname and email (for the send).
- **Decision 2026-08-26: proposal goes to Mr. Shilpen ONLY.** Vaibhav gets a personal heads-up (WhatsApp/call), not the commercial email.

## Referral: Vaibhav (accountant)
- **Who**: Vaibhav is Spectrum's accountant. Spectrum asked him for a good software; he promoted Trackon. He is the origin of this lead. He said he did not want a commission.
- **Murat's intent (2026-08-26)**: pay him ~20% commission anyway, "even from my pocket"; no referral mechanism exists yet.
- **Assessment given**: base it on **collected first-year subscription** (Option A: AED 188,403 → 20% = AED 37,680; year-1 total incl. 45k implementation would be 233,403 → 46,680; implementation-only 9,000), paid **quarterly as collected**, **from Trackon** under a one-page referral agreement (deductible, auditable, reusable), never personally (buyer's-advisor kickback optics). His refusal is probably conflict-of-interest, so the clean route is a one-sentence disclosure by Vaibhav to Shilpen ("Trackon has an advisor referral programme, I am part of it"); if he won't disclose, then gift + free Trackon access for his practice instead of cash.
- **Status**: recommendation given, not decided. Nothing payable until Spectrum accepts and the first invoice is collected. If adopted, this becomes Trackon's first referral-partner mechanism (log it in [[_personal/commercial/pricing]] when decided).
- Confirm the HO/shop user split if known; deck states 10/30 as an assumption.

## Delivery scope committed on the deck (if accepted)
- New POS screen **Record Expenses** (shop expense entry, HO approval, flows into shop profitability). Backlog line in [[products/trackon-legacy/trackon-legacy-backlog]].
- Branding (logo, receipt layout), per-shop config, home-screen install, HO process config, data load from Excel templates, standard report pack + shop reports, training, 2 weeks hypercare.
- Explicitly deferred: shops adding their own customers / selling on account; offline mode.
