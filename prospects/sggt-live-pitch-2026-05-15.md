---
title: SGGT Live Pitch — 15 May 2026
type: opportunity
status: pitch-prep
event_datetime: 2026-05-15 13:30-17:30 CET (slot pending)
format: 15-min pitch + 10-min jury Q&A on Zoom
related: [_personal/prospects/sggt-challenge-2026, _personal/prospects/sggt-jury-followup-response-2026-tight]
updated: 2026-05-15
---

# SGGT Live Pitch — Cheat Sheet

The jury already read the tight 11-answer follow-up. They will **drill**, not learn.
Goal: confirm everything in the written answers is real, you're credible, and the team owns this category.

---

## 15-min Pitch Script (12 slides, ~75s avg)

Deck: `tradingdocs-saas-webpage/html/sggt-pitch-deck-v2.html`

| # | Slide | Time | What to say (key beats only) |
|---|---|---|---|
| 1 | Title — Trackon Software | 0:15 | "Murat Ozturk, CEO Trackon Software FZCO. 20 years building trading systems inside grain trading houses. Today: how we replace the spreadsheet-and-Word-template stack with one Trade OS." |
| 2 | The Problem | 1:30 | Grain trade today is trapped between two bad options: (a) spreadsheets + emails + Word templates, brittle and unauditable; (b) $500K enterprise CTRMs built for energy and metals, never grain-aware. The documentation officer with coloured highlighters reconciling six documents per shipment is a real, observable workflow. **TradingDocs.AI was a pull from inside the trade. The logistics manager of one of our soft-commodities customers — a dairy trader — had cargo rejected multiple times at Algeria over document inconsistencies. He asked us to build a tool that catches these before the documents leave his desk. We built it. His last 10 consecutive shipments cleared without a single discrepancy issue. The same engine, with grain-specific rulesets and GAFTA/FOSFA clause libraries swapped in, today runs the document compliance for our grain customers Hakan and AFG. That's the point: soft-commodities-shaped platform, not commodity-specific. Rulesets change; the engine doesn't.** |
| 3 | One Platform. Three Products. | 1:00 | Trackon Legacy (Oracle CTRM, 7 customers, deep grain workflows). TrackonAI (cloud-native CTRM, MCP-enabled, what new customers buy). TradingDocs.AI (the document-validation engine, sold standalone or inside TrackonAI). One tenant, one data model, three product surfaces. |
| 4 | TradingDocs.AI — 3 Steps, 3 Minutes | 2:00 | Upload the document set against an LC and a country ruleset. The system over-flags every difference, including punctuation in addresses — because a missed discrepancy lands cargo in a port that refuses to clear it. An auto-resolver dismisses the obvious false positives: notation conversion (1.4×10⁴ = 14000), tolerance arithmetic, address variations, date logic. The documentation officer reads a short residual list and decides. Three minutes of human time replaces hours of highlighter work. The system learns from each resolution — per-tenant, never pooled. |
| 5 | First CTRM with MCP | 1:00 | April 2026, we shipped native MCP integration. A trader points Claude or ChatGPT at their tenant and asks "what's my open butter position?" in plain English. Read-only. Tenant-scoped at the auth layer. No vendor in our category has this yet. |
| 6 | Architecture | 0:45 | Cloud-native, multi-region, multi-tenant with hard isolation. Every MCP tool call and every AI resolution logged per tenant for audit. Skip the byte-level detail; ask if they want it. |
| 7 | Purpose-Built for Grains | 1:30 | Generic OCR captures characters; we capture trade meaning. GAFTA and FOSFA quality clauses — FAQ basis, protein and moisture tolerances, weight franchise — are first-class objects. LC clauses validated against UCP 600 plus ISBP 821. Numerical normalisation and unit conversion built in. Country-specific phytosanitary wording library. This is the moat. |
| 8 | Market | 1:00 | 500M tonnes, 140+ countries, $156B trade. Established CTRMs ignore SMEs because pricing collapses if they move down-market. Document-AI tools have no CTRM and no country rules. eBL platforms have no validation. We span all four corners — that's the wedge. |
| 9 | Pricing | 0:45 | Per-tenant subscription plus per-shipment validation. SME-accessible without cannibalising enterprise pricing because we don't sell to enterprises yet. |
| 10 | Customers & Revenue | 1:30 | 7 paying global trading companies. Two grain-trading: Hakan Foods DMCC and AFG Trading DMCC, both DMCC-registered, globally active, both TrackonAI customers — both have consented to be named to this jury and contacted for reference today. Active trials: a UAE trading house and a Dutch commodity trader. Advanced commercial discussions: one of the world's largest dairy companies. ARR sits inside Category 1, under $2M annualised, combined across the three products. |
| 11 | Team | 0:45 | I spent 12 years as CTO at Hakan, a grain trading house — same Hakan that's now a customer. My team is trading-systems engineers, not generalist SaaS builders. The categories, edge cases, and workflow come from inside the trade. |
| 12 | Close & Ask | 1:00 | Three asks in priority order: (a) entry to the IMEAA network for distribution, (b) jury introductions to anchor grain houses on corridors we don't yet serve, (c) prize capital would accelerate Arabic-language rollout and the country-rules buildout. The network beats the cheque. We are ready to demo live on any document set the jury chooses. |

**Total: 13:00 spoken + 2:00 buffer for pacing.**

Rules of delivery:
- **Stand up.** Camera on. Single screen for deck, second monitor for live demo if asked.
- **Slow down on slides 4, 7, 10.** That's where the moat lives.
- **Skip nothing.** If you're behind, compress slides 6 and 9, not the customer slide.
- **End on the ask** — never let the close trail off into "and yeah, that's us".

---

## Top 10 Q&A Drills (10 min total, ~60 sec each)

The jury sent 11 written questions. The verbal versions will be sharper. Pre-loaded answers below — speak them, do not read them.

**1. "Of your two grain customers — can we reach them today, on the record?"**
→ Yes. Hakan Foods DMCC and AFG Trading DMCC. I have consent from both. I'll send contact details in the chat now.
*(If you don't have explicit consent yet — say "I'll share contacts after this call, both have agreed to be named." Do NOT promise on-record today unless they actually said yes. Text both of them in the next 15 minutes.)*

**2. "Several thousand validations — give us the actual number."**
→ Honest answer is on the order of [X] shipment-level validations across customers, plus active-trial volume on top. I can pull the exact AWS metric live if it would help.
*(Pre-flight: open the AWS console tab now and have the number ready. If you don't know it, say "I'll send the exact number in the chat by end of call." Don't bluff.)*

**3. "Show me one false positive your auto-resolver killed, and one false negative you caught that a human had passed."**
→ False-positive example: weight cert showed "1.4 × 10⁴" against an LC reading "14000 KG". Manual checker would either flag or miss it; our notation normaliser dismisses it correctly. False-negative caught: phyto additional declaration missing "free from Tilletia indica" on an India-bound wheat shipment — a human had passed the document set; we flagged it. (Use real examples from your customer base if you have sharper ones — these are placeholders the jury can't verify.)

**4. "MCP is live in production — name one customer who uses it daily."**
→ Hakan Foods DMCC has MCP enabled and the team has used it for position and shipment queries. We don't instrument per-tenant MCP traffic because that would compromise tenant isolation — so I have the activation, not a daily-active count. Happy to demo the flow live.

**5. "ARR — give us a number inside Category 1. The band is $0–$2M."**
→ Combined across three products, we are under $2M annualised. The mix today is heavier on Legacy than on TrackonAI/TradingDocs because Legacy customers are older. The growth line is TrackonAI and TradingDocs. (Have an actual number in your head — bracket it as "between $X and $Y" if you don't want to disclose exact. Don't be vague.)

**6. "You won't invent an accuracy figure — fine. But why should we believe hours-to-minutes without a controlled study?"**
→ Because the input is the same in both arms — the same six documents — and the output is the same — a discrepancy list. The variable is whether a human reads the documents with a highlighter or scans an AI-generated list. We will gladly run a live measurement on a jury-chosen sample, stopwatch visible. This is an offer, not a deflection.

**7. "Country rulesets — how often does a real customer refresh one?"**
→ Rarely. Once a corridor is established, the ruleset is treated as stable until a known regulatory change. That's a feature, not a bug: every shipment cites a versioned ruleset, so the audit trail has a clear answer to which rule version applied. Continuous-push subscriptions are on the roadmap. (Don't apologise. Frame it as the audit-trail-compliant design.)

**8. "What stops ION, Brady, or any eBL platform from adding AI doc-check next quarter?"**
→ Three things, none of them are "they can't try". (a) Domain DNA — to capture GAFTA, FOSFA, and country phyto wording correctly you need someone who has read the documents in anger. We've spent 20 years in this trade. (b) Integrated stack — to match us, ION needs to acquire and integrate three vendor categories, then merge data models. That's an 18-month migration disclosure to enterprise customers. (c) The per-tenant learning loop. Their auto-resolver starts from zero on every customer. Ours has six months of resolutions per tenant before they'd even sign their first one.

**9. "Why grain? You called yourself a soft-commodities platform — wouldn't dairy or sugar win you bigger logos faster?"**
→ Grain is the wedge, not the limit. It's where my team has the deepest reps and where the standards body vocabulary (GAFTA, FOSFA) lives. The same engine already runs sugar, pulses, fertiliser, coffee inside existing customers. Dairy is in advanced commercial discussion with one of the world's largest. Pursuing grain doesn't slow that down — proving range is exactly why we are in front of you today.

**10. "What's the ask?"**
→ Three things, in priority order: (a) entry to the IMEAA 30,000-firm network for distribution, (b) jury-mediated introductions to one or two anchor grain houses on corridors we don't yet serve, (c) prize capital would accelerate Arabic-language rollout and the country-rules buildout. The network is worth more than the cheque to us.

**11. "Do you support hedging / derivatives / risk management for grain trading?"**
→ "The Risk Management module is built — hedge book, instruments, exposure, P&L, scenario analysis, with hedge effectiveness testing as a recent addition. Adoption among our current customers is still light, because they are physical grain traders who don't run a heavy futures book today. The platform is ready for derivatives-active customers as we move upmarket — part of what the dairy-company conversation is about. We also don't do live exchange floor connectivity (CBOT/CME tick feeds); broker statements feed in. That's a deliberate scope choice for our SME-physical customer base today."

**Rules for the live session (verified 2026-05-15):**
- Do NOT volunteer Risk Management in the 15-min pitch. Not customer-validated yet.
- Do NOT show any Risk Management screen on a live demo. If asked, redirect: "Happy to schedule a deeper walk-through with a customer's configuration after the call; for this session I'll show what's used daily in production."
- If pushed on customers using hedging: "None of our current grain customers use the hedge book in production today. They hedge with brokers separately. The module is in place for when a customer requires integrated hedge accounting."
- If asked specifically about Hedge Effectiveness method (dollar-offset / regression / critical-terms-match): "Recent addition, not yet customer-validated. I'd rather show you a feature that has real production usage than walk you through a screen that hasn't been adopted yet." — This signals maturity.

---

## Things they might trap you on

- **"Why is Trackon Legacy on Oracle in 2026?"** — Because 7 customers run their daily P&L on it. We will not break their stack. TrackonAI is the cloud-native, MCP-native next generation. Both ship.
- **"You're a DMCC company and DMCC is a sponsor — is this a conflict?"** — No, the application went through the same submission portal as everyone else. We're a Trackon-paying-rent-to-DMCC tenant, not a partnership.
- **"What's your relationship to Sudhakar?"** — Disclose it cleanly: worked together at Hakan 2009-2021, he was MD, I was CTO. He encouraged the application. Has no role in the jury process. Volunteer this if not asked.
- **"Microsoft is also a sponsor — are you on Azure?"** — We're on AWS. Bedrock for the AI layer. Honest. Don't apologise.

---

## Logistics — Last 90 Minutes Checklist

- [ ] **Now**: Text Hakan Foods + AFG Trading. Ask explicit consent to be named and contacted by jury today. Wait for written yes.
- [ ] **+15 min**: Open AWS console. Pull the actual shipment-validation count. Write the number on a post-it.
- [ ] **+30 min**: Open `sggt-pitch-deck-v2.html`. Rehearse the script aloud once at presentation pace. Time it.
- [ ] **+50 min**: Second monitor — log into TradingDocs.AI on a customer-safe demo tenant. Have one known-good document set queued. If they ask for live demo, you share-screen in 5 seconds.
- [ ] **+70 min**: Re-read this file. Speak each Q&A answer aloud once. Do NOT read them off the screen during Q&A — speak naturally.
- [ ] **+80 min**: Close Slack, email, Teams. Disable notifications. Phone face-down. Water on desk. Camera angle, lighting, audio test.
- [ ] **+90 min (11:30 Dubai)**: Ready. Zoom open. Deck on screen 1. Demo tab on screen 2. This file printed or on phone for Q&A glance.

---

## If something goes wrong mid-pitch

- **Network drops**: Phone hotspot ready. Rejoin and apologise once, then keep going.
- **They cut you off at 10 minutes**: That's a signal they have follow-ups. Compress slides 10-12 into 30 seconds.
- **A question lands you don't know the answer to**: "I don't have that number in front of me. I'll send it in the chat within the hour." Never invent. Never bluff. The jury already saw your written follow-up — the consistency check is on.

You have done the hard work already. The written follow-up was the audition. This is the confirmation.
