---
type: prospect
status: active
stage: demo
product: trackon-legacy
created: 2026-08-28
updated: 2026-08-28
related: [_personal/prospects/yalcintas-akdogan-newco, _personal/commercial/newco-yalcintas-proposal-2026-07, _personal/prospects/sggt-demo-cues, products/trackon-legacy/legacy-overview]
tags: [prospect, trackon-legacy, demo, cue-sheet]
---

# NewCo (Yalcintas / Akdogan) · Legacy Demo Cue Sheet · Sat 2026-08-29 11:00 Dubai

Google Meet, 60 min, English. Deck (bookends only, live system in between):
[[_personal/prospects/newco-demo-2026-08-29/newco-demo-deck-2026-08-29|newco-demo-deck-2026-08-29]] (PDF: `Trackon-Legacy-Demo-2026-08-29.pdf`, 8 slides).

## Audience (as of 2026-08-28 evening)

- Ayhan Yalcintas (founder, commercial decision-maker), Fatih Ziya Akdogan (senior trader)
- Emrah (emrahcy@gmail.com), Nikhil (nikhilrdesh@zohomail.com, the Indian colleague, reason the demo is in English; likely finance/ops/IT, confirm at the start)
- Up to ~10 more from "our group" (bizim grup), active or observing. The group behind thadubai.ae is bigger than the 10-user newco: whoever is watching may be evaluating for more than one entity. Treat the observers as a second audience.
- Trackon side: Murat plus team members for English Q&A.

## Why the old deck (trackon_presentation.pdf) never sold

1. Organised by OUR modules (Contracts, Shipments, Accounting...), not by THEIR outcome. A trader does not buy "a shipments module"; he buys "I know my profit on this cargo today".
2. Fifteen text slides on a video call. Attention is gone by slide 4. The product is the demo; slides should only open and close.
3. "About You / pain points with your current system" makes no sense for a greenfield company with no system.
4. Internal-notes wording ("Their task is mostly control and approval", "unfortunate events in your company"). Reads unpolished.
5. No proof beyond Hakan: no live customers, no uptime, no screens.
6. No ask at the end. The deck ends with a logo, so the meeting ends with "we will revert".

## Run of show (60 min)

**0:00 to 0:05 · Open (slides 1 to 3).** Introductions, ask Nikhil and Emrah their roles. Two questions to the room, and USE the answers to pick the demo example: (a) which commodities and which routes (origin, destination, incoterm), (b) how they get paid and pay (LC, CAD, open account, advances). Say the 60-minute structure: one cargo start to finish, then the owner's view, then their questions.

**0:05 to 0:35 · One cargo, live (slide 4 flow diagram stays visible in a second window or as the mental map).** Pre-staged single trade thread in the demo tenant. Follow ONE cargo through every desk, in this order, narrated as a story ("Fatih buys 5,000 t ... "):

1. Purchase contract as the trader: counterparty, product, quality clauses, price, payment term, estimated costs per ton (freight, insurance, inspection, finance). Point: the estimate goes to logistics as guidance and comes back later as estimate vs actual. Show approval flow (risk approver, boss). Show the multi-language printout once, one click, do not dwell. Mention e-signature.
2. Sale contract, same flow, faster. Show the open positions report right after: bought 5,000, sold 5,000, position flat, or leave 1,000 open on purpose so the position report shows exposure. Then Mark to Market with a changed market price. THIS is the moment for the traders in the room.
3. Shipment (journey) linking purchase to sale: steps (serial/parallel, mandatory/optional), assign logisticians, documents and checklists per step, container list, in-transit warehouse. Show one expense being entered at a step and appearing on the trade's P&L immediately. Point: accrual exists before any freight invoice arrives.
4. Documents: generate one journey document (invoice, packing list or bank submission set). Point: bank document checklist on the record.
5. Sales invoice, per container if their flow is containers. Open the invoice's full history: contract estimate vs actual, profit of this trade now. Point: "you never wait for month end to know this cargo's result".
6. Payment: system-generated payment request, approval, treasury pays, advance tracking.
7. Finance: FX averaging for origination currency (only if they source from RUB/TRY/INR style currencies; ask in the opening), accruals posted to GL monthly, trial balance. Do not go deeper than 3 minutes here unless Nikhil is finance.

**0:35 to 0:50 · Owner's view (slide 5 as the map).** QuickSight dashboards from the demo system, then: open positions, monthly P&L, shipment P&L, limits per customer/vendor (open/CAD/LC), blacklist, the security model (log in as a second trader and show that the first trader's counterparties are invisible), hidden prices, email alerts. Optional wow if pre-tested: Claude with the Legacy MCP, "what are my open positions?", then show it was attributed to the logged-in user. Only if tested on the demo tenant in the morning.

**0:50 to 1:00 · Questions and close (slides 6 to 8).** Slide 6 recap, slide 7 the greenfield argument, slide 8 the ask: they send products, trade flows and user list; we configure this environment with their data and their team works one of their own trades through it. Get a date for that hands-on session before leaving the call.

## Rules for this call

- NO pricing, NO deployment options A/B/C in the mixed audience (14 people, observers from the group). Commercial talk goes to Ayhan privately, by phone or WhatsApp after the call. If asked on the call: "the proposal is with Ayhan bey, we will go through it together".
- Do not apologise for the UI. If it comes up: "the screens are functional and every number on them has been audited by trading houses for 20 years; the UI modernisation is under way and existing customers get it as part of the subscription". Do not promise dates.
- Do not open Risk/Hedge screens that are not customer-validated (same no-go as SGGT).
- Do not demo report generation live unless tested that morning: the new-tenant Jasper crash (`IOException: no entry name specified`, header bitmap chain, see [[products/trackon-legacy/legacy-reports-catalog]]) has bitten twice this summer. Pre-generate PDFs of the contract printout, invoice and packing list as fallback.
- Check the QuickSight URL function on the demo schema works (`FNC_GET_QUICKSIGHT_URL` broke on Mana after the OCI move, see [[products/trackon-legacy/oci-migration-plan]]).
- Naming customers: say "trading and processing companies in the United States, the Gulf and Turkey"; name a customer only if Murat is comfortable and it is already public.

## Pre-demo checklist (Saturday morning)

- [ ] Demo tenant: USE EXISTING RECORDS, do not build new ones (Murat, 2026-08-28). Pick and note the numbers of: (1) one complete thread, a purchase contract WITH estimated costs -> its shipment with steps, documents and 2+ real expenses -> sales invoice -> payment request; (2) one partially open contract for the positions / MTM moment; (3) a second trader login. Only live action: enter one expense on the shipment and reopen the trade P&L to show it landed. If the data is agri, rename the product on that one contract to "Granular Urea" if trivial, otherwise narrate ("imagine 10,000 t urea, Gulf to Mersin, the flow is identical"). Fatih's background: urea, NPK, sulphur, phos acid, base oils (see [[_personal/prospects/yalcintas-akdogan-newco]]).
- [ ] Fertilizer-specific points to say out loud: (a) B/L vs draft-survey vs outturn weight and shortage claims on the same shipment record; (b) freight and demurrage accrued before the owner's invoice arrives; (c) LC document set and bank submission checklist for Indian buyers; (d) counterparty limits per payment term (open/CAD/LC) matter because urea buyers push for open account; (e) price formulas indexed to a publication: ask how they price, do not promise formula pricing on screen unless staged.
- [ ] Second trader login ready for the "cannot see each other's counterparties" moment.
- [ ] QuickSight dashboards open in a tab, data refreshed, URL function working.
- [ ] Fallback PDFs of documents generated and open in a tab.
- [ ] MCP/Claude query tested on the demo tenant, or drop it.
- [ ] Browser zoom 125%, one window per audience view, notifications off, Meet screen-share tested.
- [ ] Deck PDF open (slides 1 to 3 at start, 6 to 8 at the end).
- [ ] Ask permission to record at the start; send the recording and the PDF to Ayhan afterwards.

## Likely questions and answers

- "Can we start with fewer than 10 users?" Yes, users are added as the team grows. Commercials with Ayhan bey.
- "Our accountant uses another ERP / wants Tally or Zoho." Trackon has integrated GL; if they insist on an external ERP we take bank payments and expense invoices from it and push inventory movements to it (1C, Logo done; others via the same mechanism). Recommend single system.
- "Can we see it on mobile?" Web based, works in browser; the iPad app covers warehouse acceptance. Do not promise a mobile app.
- "Where is the data hosted, is it safe?" Cloud, UAE (Dubai region) available for new customers per [[decisions/2026-legacy-new-customers-shared-dubai-instance]]. Never name data-centre cities.
- "How long to go live?" Startup package (setup, processes, report pack, training) is short because there is no migration. Give a range only after they send the product list and flows.
- "What about AI?" MCP gives their own reports to an AI assistant with per-user permissions; TrackonAI modules (document extraction, vessel tracking, sanctions screening) are the growth path.

## After the call

- Same day: WhatsApp Ayhan, thank, send PDF and recording, propose the hands-on session date, and separately restate the commercial proposal (validity expired 2026-08-05, offer a fresh validity date rather than a chase).
- Update [[_personal/prospects/yalcintas-akdogan-newco]] with outcome, attendee roles, commodities and flows learned, objections.

## Talk track (added 2026-08-28 evening)

**Thesis, first 60 seconds, before slides:** "You are building a trading house from zero with ten people. Your question is not which software. It is: how do ten people run cargoes worth millions without a thirty-person back office, and how does Ayhan bey know the numbers are true in front of a bank or investor. One cargo, one hour."

**UI, one sentence while the screen loads:** "The screens are functional, not pretty. Every number has been audited by trading houses for twenty years. Judge the numbers."

**The cargo, same name all hour:** "Fatih bey buys 10,000 t granular urea FOB Gulf, sells 7,000 t CFR Mersin."

1. Purchase contract (4 min): estimated costs per tonne, "remember this number"; approval flow in one click.
2. Sale + positions (5 min) **PEAK 1**: long 3,000 t; MTM with a changed market price. Ask Fatih: "how do you see this today?" Wait.
3. Shipment (7 min) **PEAK 2**: enter one expense (demurrage) live, reopen trade P&L. "Nobody waited for month end or the shipowner's invoice in 45 days. Trading houses lose money on the freight invoice that arrives after the bonus was paid."
4. Documents + invoice (5 min): LC/bank checklist ("presentation vs discrepancy fee plus three weeks"); invoice history = estimate vs actual, "the number from day one next to reality".
5. Payment + finance (4 min): request -> approve -> treasury; advances. GL/accruals 2 min only if Nikhil is finance.
6. Security (3 min) **PEAK 3**: second trader login, counterparties invisible, hidden prices. "When someone leaves, he leaves with nothing, and the cargo continues." Ayhan's moment.

Owner's view (10 min): dashboards, monthly/shipment P&L, limits per payment term, blacklist. "Ten-minute morning look; no second version for the bank."

Close (8 min, slides 6-8): "Nothing to migrate, nothing to unlearn." The ask with a date: "Send product list, flows, ten users with roles. We load this environment with your data; in one week your team runs one of your own urea trades hands on. Week of 7 September?" Get the date. No commercials in the room; call Ayhan after.

Craft rules: one cargo one name; every feature ends in a money sentence or is skipped; ask the room exactly three times (Fatih after MTM, Nikhil/Emrah after the expense, Ayhan after security); use names; a Trackon colleague owns the chat; at minute 35 skip finance, never skip peaks or close; fallbacks open in tabs.
