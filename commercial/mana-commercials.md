---
type: commercial
status: active
tags: [mana, dfa, pricing, commercial, sensitive]
created: 2026-08-19
updated: 2026-08-19
related: [customers/mana/mana-health, _personal/commercial/pricing, _personal/commercial/mana-sf-phase2-quote, _personal/commercial/mana-claims-console-proposal, _personal/commercial/mana-sf-phase1-closure-emails]
---

# Mana / DFA — All Monetary Facts (SENSITIVE)

Single home for every monetary figure related to Mana/DFA. [[customers/mana/mana-health|mana-health]] carries pointers here, never amounts (rule: Murat, 2026-08-19).

## Recurring revenue base

- **Trackon Legacy subscription: $120,000/yr** (recorded 2026-08-19 — the revenue base the replacement-risk posture protects; largest customer).

## Salesforce → Trackon integration

- **Phase 1 (Design & Discovery): $7,500 fixed** — accepted 2026-06-21, **PAID Aug 2026** after the Mashreq account title was renamed DMCC→FZCO. Payment saga: original wire bounced; the Jul-29 "proof" screenshot DFA sent was actually the **return credit of $7,390 to DFA's own account** (= $7,500 minus ~$110 return fees), not a new wire.
- **Phase 2 range in the accepted June proposal: $36–48k indicative** (total one-time build shown as ≈ $43,500–55,500 incl. Phase 1).
- **Phase 2 fixed quote (DECIDED, Murat 2026-08-19): $34,500** — deliberately **below the range** so DFA can approve fast without a negotiation cycle; total build incl. Phase 1 = $42,000, under even the June proposal's lowest indicative total. Earlier internal draft was $46,500 (upper-quarter) — rejected as too high. Itemisation: contract-creation API $21,500 / exceptions console $5,500 / integration backbone $3,000 / sandbox-UAT-go-live $4,500; reference-data API + master-data feed shown as *Included*. Email framing: "Phase 1 ran smoothly and part of the platform is already live — passing that efficiency on." Guardrail: the discount is a stated efficiency pass-through, never negotiable softness — any future haggle gets "the price already reflects the efficiency."
- **Integration Support: $1,000/mo from go-live (≈ $12k/yr)** — pre-anchored in the accepted June proposal as "from ~$1,000/mo". **DECIDED (Murat, 2026-08-19): stays at $1,000** — a raise to $1,500 was evaluated (justified by the support reframing: the fee is really recurring ticket/exception support, not maintenance) but rejected for lack of confidence; deck wording reframed to ticket-centric support with a fair-use guardrail ("new development and scope changes quoted separately"), and the ambiguous "support to DFA IT" phrase dropped. Billed monthly; quarterly-in-advance option ($3,000/qtr, cuts DFA AP wire friction) remains open.
- **Payment schedule (drafted, Murat may adjust): 40% acceptance / 40% UAT start / 20% go-live** (40% = $13,800). Quote validity drafted to **Sep 4, 2026** (= acceptance deadline protecting December go-live).
- **Strategic pricing logic (2026-08-19 evaluation):** the $7.5k cut ($42k→$34.5k) buys evidence against a future vendor-kill business case ("expensive/slow" script) while the numbers that matter — $120k/yr base + $12k/yr support — stay intact. $42k is proof-money at DFA scale (≈ 4 months of Mana's subscription); cancellation of the project would put Phase 2 revenue ($36–48k class) plus the relationship at stake.
- **DFA's own cost reference (SF licensing):** ~35 users, Enterprise edition ≈ $69–74k/yr list (2026).

## Claims Console

- **Capped T&M, single phase (Murat, 2026-07-06): $100/hr on actual hours, hard cap 160 hours / $16,000** (meetings + dev + testing + go-live). Under-spend → invoice actual; overrun (even to 300h) → capped at $16k. No recurring fee. Full deck: [[_personal/commercial/mana-claims-console-proposal|claims proposal]].

## Mail archival options (researched 2026-07-20)

- GoDaddy Email Archiving add-on (Proofpoint) — $4.99/mailbox/mo US market; NOT available in Mana's UAE storefront.
- Mana's GoDaddy catalog: Advanced Email Security AED 18.33/user/mo; Email Backup AED 9.00/user/mo intro, renews AED 16.00.
- Third-party SaaS: Dropsuite $4/user/mo; Proofpoint Essentials ~$5.86/user/mo.
- Defederate + Exchange Online Archiving: $3/user/mo.
- Custom build (journaling → SES → S3 → Athena): infra ~$10–20/mo; build ~80–160h → **$8–16k capped T&M candidate**.

## Shipment tracking service (TradingDocs/SeaRates)

- **Mana pays EUR 500/month (~$6,000/yr)** for shipment tracking; earlier structure was $580/month API pass-through (Feb-2026 decision moved it to a bundled fee — see [[_personal/commercial/pricing]]).
- SeaRates costs us **$6,600/yr** (cross-month double counting) → margin **−$600/yr, cash-negative**. **$2.50/shipment restructure proposal** sent to Josh 2026-03-30 — no response.
- Carrier-direct strategy ([[decisions/2026-carrier-direct-api-strategy]]): top-5 direct + SeaRates base plan $1,650/yr → margin **+$4,350**; top-9 direct (~$800/yr) → **+$5,200**. Even the current fee becomes profitable — Josh negotiation moot.

## Customer facts

- **Mana revenue ≈ $700M/yr** (2026) — well above the AED 50M Tier-1 e-invoicing threshold.

## Other

- Mac Ross (Mana's e-invoicing ASP + tax consultant): **~$3k/yr for 3 services**, negotiated by Prashant/CFO.
