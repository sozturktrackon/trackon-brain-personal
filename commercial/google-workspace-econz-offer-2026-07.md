---
type: decision
status: resolved
tags: [google-workspace, econz, vendor, licensing, cost-saving, confidential]
created: 2026-07-27
updated: 2026-07-28
email-ref: "Econz commitment offer — Sandhya Narain <sandhya.n@econz.net>, 2026-07-27"
source: conversation
related: [_personal/commercial/syncfusion-renewal.md, _personal/commercial/pricing.md]
---

# ID Google Workspace — Econz reseller commitment offer (7 seats, 12 months)

Related: [[_personal/commercial/syncfusion-renewal|Syncfusion Renewal]], [[_personal/commercial/pricing|Pricing]]

| | |
|---|---|
| **THE PROBLEM** | Reduce Google Workspace cost for 7 Business Standard seats without losing needed flexibility. Currently on Google direct **flexible** plan: €113.40/mo = **€1,360.80/yr** (€16.20/user/mo). |
| **OPTIONS CONSIDERED** | 1. Stay on Google direct flexible — most flexible, most expensive. 2. **Econz reseller 12-mo commit** — AED 51/user/mo = AED 4,284/yr + 5% VAT (AED 4,498.20). At ~4.19 EUR/AED ≈ **€1,022/yr ex-VAT** → saves ~€340/yr (~25%). Yearly advance payment, seats can increase but NOT decrease during term. 3. **Google direct annual plan** (third option) — 20% below flexible ≈ €13.50/user/mo ≈ **€1,134/yr**, billed monthly by Google, no reseller layer. Saves ~€227/yr. |
| **EVIDENCE** | July 2026 Google invoice: €113.40/mo for 7 seats (flexible). Econz quote 2026-07-27: AED 612/user/yr commit price. EUR/AED ≈ 4.18–4.20 (Jul 2026). Google list: $14/user/mo annual vs $16.80 flexible (flexible = +20%). Econz AED 51 ≈ $13.89 — marginally under Google's USD annual list; EUR list pricing is worse than USD, so AED billing effectively captures USD-level pricing. Transfer is billing-only (no data migration, no downtime), standard Google reseller flow via admin.google.com/ac/resellermanagement. |
| **REASONING** | Optimizing for: cost, provided 7-seat headcount is stable for 12 months. Most of the saving (~2/3) comes simply from moving flexible → annual commitment, which Google offers directly; Econz adds the last ~€112/yr plus credit terms, at the cost of yearly advance payment and a reseller in the billing path. Transfer back to Google direct is possible later. |
| **ADDITIONAL FEEDBACK** | Verify before signing: (1) proposal states domain **trackon.com** — actual domain is **trackonsoftware.com**, must be corrected; (2) confirm reseller identity — when entering public identifier `C012slhu9` in Admin Console the reseller name shown must be Econz (econz.ae, Google Premier Partner); (3) request VAT invoice with Trackon FZCO TRN so 5% VAT is recoverable; (4) confirm renewal terms — no auto-renewal at a worse rate. |
| **REBUILD ASSESSMENT** | Pending Murat's decision. Key question: will 7 seats stand for 12 months, and is AED 4,498 advance cash-out acceptable? |

## Numbers at a glance (7 seats, per year)

| Option | Cost/yr (ex-VAT) | vs current |
|---|---|---|
| Google direct flexible (current) | €1,360.80 | — |
| Google direct annual | ~€1,134 | −€227 (17%) |
| Econz 12-mo commit | ~€1,022 (AED 4,284) | −€339 (25%) |

## Counterparty risk (Murat's question, 2026-07-27)

**Q: If Econz closes 2-3 months after we prepay a year, do we pay Google again?**

- The Workspace subscription belongs to the domain, not the reseller. If a reseller stops providing/paying, Google emails a warning and the customer sets up direct billing or moves to another reseller — data and service continue (per Google's transfer docs). A billing transfer grants the reseller NO admin access to the domain.
- BUT the payment contract is with Econz, not Google. Google does not credit money paid to a failed reseller — the unused prepaid portion becomes an unsecured claim in liquidation. Worst case at month 3: lose ~9 months prepaid (~€800) and pay again for the remainder.
- Exposure capped at AED 4,498 (~€1,073). Break-even failure probability ≈ saving/exposure ≈ ~35%. Econz: founded 2006 Bangalore, Google Premier Partner since 2012, operations in India/UAE/UK — collapse within 12 months is very unlikely, so risk-adjusted the deal stays favorable.
- Mitigations: (1) negotiate quarterly/semi-annual payment (they advertise "credit days" — use it); (2) contract + invoice from the UAE entity (econz.ae) with valid trade license; (3) pay by credit card for chargeback rights; (4) act immediately on any Google billing warning email — transfer back to direct billing.

## Documents received (2026-07-28)

Econz sent a UAE Establishment Card + VAT Registration Certificate:

- Contracting entity: **ECONZ IT CLOUD SERVICE & DATACENTERS PROVIDERS L.L.C S.O.C** (single-owner LLC, owner: Moby Karedath Babu Karedath Mathew Babu), Burjuman Business Tower, Bur Dubai. Trade license 998367 (Dubai Economy and Tourism).
- **TRN: 105295422700003** — VAT registration **effective only 01/03/2026**; certificate issued 14/07/2026. First VAT return period Mar–May 2026.
- ⚠️ Finding: the UAE billing entity is effectively brand new (or only recently crossed the VAT threshold). The 20-year track record belongs to the Indian parent (Econz IT Services Pvt Ltd, Bangalore, Premier Partner since 2012) — NOT to the entity we would prepay. Establishment card ≠ trade license; license 998367 is verifiable on the Dubai DET portal.

## Entity-of-record question (Murat, 2026-07-28)

Admin Console verified reseller ID `C012slhu9` — but the console shows the reseller *account* (display name/domain, econz.ae) as registered with Google, NOT the legal entity's registration papers. Google Partner Directory lists the Premier Partner as **Econz IT Services Pvt Ltd (India)**; the UAE LLC (VAT-reg Mar 2026) almost certainly is NOT the reseller of record — likely structure: India/econz.ae entity holds the Google reseller agreement, new UAE LLC does the invoicing. Console verification proves an authorized reseller exists behind the ID; it does NOT prove the invoicing LLC is that same legal person.

Impact: Workspace continuity is unaffected either way (Google's transfer-back works regardless). The gap is contractual — if you pay entity A and entity B holds the Google relationship, recovering money or enforcing delivery gets murkier.

Mitigation (proportionate to a ~€1k deal):
1. One written question to Econz: "Which legal entity holds the Google reseller agreement for public identifier C012slhu9? Confirm the relationship between it and ECONZ IT CLOUD SERVICE & DATACENTERS PROVIDERS L.L.C S.O.C (TRN 105295422700003)."
2. The signed proposal/tax invoice must reference: reseller ID C012slhu9, Workspace Business Standard, 7 seats, AED 612/user/yr, 12-month term — ties the payment contractually to the subscription regardless of group structure.
3. After transfer, verify in Admin Console → Billing that the subscription's listed reseller is Econz.
4. Payment terms (semi-annual/quarterly) remain the main financial protection.

## Recommendation (2026-07-28)

**TAKE the deal, on three conditions:**
1. Proposal corrected to domain **trackonsoftware.com** and issued by the LLC with TRN 105295422700003 on the tax invoice.
2. Reseller identity confirmed in Admin Console: entering `C012slhu9` must display Econz as the transfer target BEFORE generating the authorization token.
3. Push for **semi-annual or quarterly payment** citing the newly-registered UAE entity — legitimate ask, cuts max exposure from ~AED 4.5k to ~AED 1.1–2.2k. If refused: still acceptable (saving €340/yr vs bounded worst-case ~€800, brand is a genuine Google Premier Partner and Google's transfer-back mechanism limits damage), but decide with eyes open.

Fallback if terms feel wrong: switch to Google direct annual plan (~€1,134/yr, −€227 vs today, monthly billing, no reseller).

## Negotiation log (WhatsApp with Sandhya, 2026-07-27/28)

- **Yearly advance payment is non-negotiable** — semi-annual refused.
- Offered instead: **transfer first, then 7-day payment window** ("special approval") — useful: invoice can be verified (entity, TRN, domain, subscription reference) BEFORE paying, and there's no pay-but-no-transfer scenario.
- **Renewal answer is vague**: "we'll reach out before term expires... process the renewal if you'd like." No auto-renewal stated, but no price commitment either. → Get in writing: no renewal without explicit written approval; ask what pricing basis applies at renewal.
- Sales pressure: "up to 35% OFF ends 30 July" — marketing urgency; actual quoted discount is ~18% off their stated list (51 vs 62). Do not let the deadline skip the checks; commit pricing like this is standard reseller fare, re-obtainable.
- Murat asked (2026-07-28): trade license (establishment card ≠ trade license) + **card payment** — pending. Card acceptance materially matters: chargeback rights would largely replace the protection lost with semi-annual refusal.

Decision tree: card accepted → proceed. Bank transfer only → still proceed IF paper conditions met (correct domain, LLC tax invoice with TRN + reseller ID + subscription spec, written no-auto-renewal, entity-of-record answer); else fall back to Google direct annual (~€1,134/yr).

- **2026-07-28: card payment CONFIRMED by Sandhya** → decision tree resolves to PROCEED. Chargeback rights cover the counterparty risk that yearly-advance created. Check for card surcharge (some UAE vendors add 2–3%; ~AED 90–135 on this invoice — acceptable, chargeback protection is worth it).

## Head-to-head: Econz commit vs Google direct annual (2026-07-28, Murat asked)

| Dimension | Econz 12-mo commit | Google direct annual |
|---|---|---|
| Cost/yr (7 seats, ex-VAT) | ~€1,022 (AED 4,284) | ~€1,134 (verify exact price in Admin Console) |
| Payment | Full year advance, by card | Monthly, existing card on file — no prepay |
| Counterparty risk | New UAE LLC (mitigated by chargeback) | None |
| Switch effort | Checklist: written no-auto-renewal, domain fix, license/entity docs, token, invoice verify | ~10 min self-serve plan switch in Admin Console |
| Renewal | Vague ("we'll reach out"); active management needed ~Jun 2027 | Transparent list-price auto-renewal, self-serve |
| Seat reduction | Not allowed during term | Not allowed during term (same) |
| Currency | AED (home currency, no FX fees) | EUR card charges → ~1–2% FX on AED card (~€15–25/yr) |
| Extras | Local partner, 24/7 support claim, future GCP/Gemini discounts | Standard Google support |

**Net cost gap: ~€110/yr (≈ €9/mo), narrowing to ~€85–95 after FX fees.** Both share the same 12-month/7-seat commitment; the only structural differences are the prepayment+counterparty on one side vs ~€100/yr on the other.

**2026-07-28 update: Murat confirmed Trackon has NEVER declared RCM on imported services — everything was just expensed.** See [[_personal/financial/vat-reverse-charge-gap-2026-07|VAT reverse-charge gap]] for the full finding and accountant question. This tilts the VAT dimension in Google direct's favor: Econz's 5% only comes back through a VAT-return process not currently in use.

**VAT (Murat asked 2026-07-28): neutral in both options IF VAT returns are filed properly, NOT an Econz advantage.** Econz: pay 5% (AED 214.20) in cash, reclaim as input VAT in next return → net zero with a cash-flow lag. Google direct: charges no UAE VAT (confirmed by our own invoices — €113.40 has no VAT line, and Google's EMEA billing policy puts non-Irish customers on self-assessment) → **reverse charge mechanism**: self-account 5% output VAT + deduct same 5% input VAT in the same return → net zero, no cash movement. Compliance note: accountant must actually be declaring RCM on imported services (Google, AWS, etc.) in the VAT return — verify this is happening. If Trackon FZCO were ever NOT VAT-registered, Econz's 5% becomes a hard cost while Google stays VAT-free.

**Revised lean: Google direct annual at this seat count.** Rationale: the remaining Econz execution cost (checklist emails, invoice verification, renewal negotiation in 2027) exceeds ~€100/yr of CEO attention; Google direct captures €227 of the €339 saving in 10 minutes with zero new risk. Econz becomes clearly worthwhile at ~15–20+ seats (gap scales to €250–350+/yr) or if the GCP/Gemini partner relationship gains strategic value. Both options defensible — Murat to decide.

## Status

**RESOLVED (2026-07-29): ACCEPTING ECONZ.** Sandhya confirmed in writing (WhatsApp 2026-07-29, email to follow — verify it): (1) renewal pricing NOT guaranteed — based on Google pricing at renewal, quoted in advance, freedom to switch provider preserved (the honest answer; ceiling = Google list, exit = 30-min transfer back); (2) **no renewal/re-commitment without written approval — CONFIRMED explicitly.** Murat's condition (#2) met. Multi-year lock offered by Econz — declined (would trade the yearly exit option for prepay exposure). Execution: email with approval clause → corrected domain on proposal → token (console must show Econz for C012slhu9) → verify invoice in 7-day window (LLC + TRN 105295422700003, 7 × AED 612/yr, 12 mo) → pay by card → confirm Econz shows as reseller in Billing + Google's final prorated invoice → tax invoice to accountant (AED 214.20 input VAT reclaim). **Renewal review: May–Jun 2027** — compare Econz quote vs Google list vs seat count.

**2026-07-29 payment quote received via Nuclei/Mashreq platform (Team Nuclei, help.mashreqbank@gonuclei.com — legitimate channel, gonuclei.com was CC'd on Sandhya's original email): AED 4,498.20, 7 licenses, expires 01 Aug 2026, Quote ID c36f0701-baac-4141-b920-991b987257b9. ⚠️ WRONG EDITION — says "Business Starter", must be Business Standard. Held payment; asked Sandhya to reissue. Also: proforma ≠ tax invoice — final tax invoice needed after payment for input VAT reclaim; confirm Nuclei payment link authenticity with Sandhya before paying.**

**2026-07-29 pm: edition error acknowledged by Sandhya ("maybe some error... getting rectified") — handling consistent with clerical error, not fraud. Fix NOT yet confirmed (marketplace still showed Starter). Domain correction sent (trackonsoftware.com). Econz sent MSSA for signature — review before signing: (1) product = Business Standard 7 × AED 612/yr 12-mo, (2) signing entity = Dubai LLC w/ TRN (answers entity-of-record question), (3) domain, (4) renewal clause must contain the no-renewal-without-written-approval commitment and NO evergreen auto-renew boilerplate, (5) termination/liability terms as represented. Payment held until marketplace + proforma show Business Standard AND MSSA checks out.**

**2026-07-29: corrected ESTIMATE #EST-000039 received on Mashreq portal — VERIFIED OK: Business Standard ✓, trackonsoftware.com ✓, 7 × AED 612 + VAT = 4,498.20 ✓, issuer = Dubai LLC ✓, Trackon TRN on Bill To ✓, "1 year from activation", no auto-renew language. Cleared for card payment via portal. Outstanding after payment: (1) final TAX invoice with Econz TRN 105295422700003 (estimate lacks it — required for AED 214.20 input VAT reclaim); (2) MSSA renewal clause check before/at signing; (3) pay ONLY via portal — never to bank details sent by email (BEC guard).**

**2026-07-29: MSSA received (BoldSign ORD-66514235) — REVIEWED, NOT SIGNABLE AS-IS. 5 required fixes sent to Sandhya: (1) Schedule A1 price — USD 1,225 = AED 4,498.87, i.e. the VAT-INCLUSIVE total entered as a VAT-exclusive fee ("VAT 0.00"); cl. 4.1 makes Fees ex-VAT, so as signed it permits invoicing 1,225 + 5% (≈AED 4,723) and switches billing currency to USD; schedule prevails on pricing (cl. 1.2/2.5/4.7) and drives cl. 10.2 true-up → must read AED 612/user/yr ex-VAT + 5% VAT = 4,498.20 total; (2) cl. 3.3 evergreen AUTO-RENEWAL + garbled "Yearly" notice period — contradicts Sandhya's written no-renewal-without-approval commitment, which cl. 13.8 (entire agreement) would legally supersede → amend to renewal-by-mutual-written-agreement; (3) signature blocks = Econz IT Services Pvt Ltd (INDIA) while contracting party = Dubai LLC → sign as Dubai LLC; (4) client details wrong: "Track on" → TRACKON SOFTWARE FZCO, TRN mislabeled as trade license, unfilled <<Jurisdiction>> placeholder, "business of Trading" → software; (5) cl. 2.4 domain-credentials obligation → N/A for billing-only transfer, never share credentials. Non-blocking: cl. 4.3 card gateway fees borne by client (ask % before paying); Schedule A1 7-day credit prevails over cl. 4.2's 30 days. Signer for Econz: Shaista Alia (Head - Cloud Solutions). Third careless document from Econz (Starter edition, wrong domain, now this) — pattern: verify every paper.**

**2026-07-29: MSSA correction email sent to Sandhya + all CC (incl. Shaista, the Econz signatory) with the 5 fixes and corrected Trackon entity details (FZCO, DMCC-794870, TRN). Awaiting revised BoldSign envelope. Order of operations: sign corrected MSSA FIRST, then pay via portal (contract must align with estimate before money moves). BoldSign of old version declined/not signed.**

**2026-07-30: Sandhya pressing to pay before corrected MSSA is signed ("offer not valid after 30th"). Advice: hold — payment is the only leverage for the 5 corrections; her deadline contradicts their own quote (expiry 01 Aug 2026) and 7-day credit terms. Counter sent: pay same-day upon corrected BoldSign envelope, or email-confirm price validity until issued. Fallback if MSSA stalls: pay against Estimate EST-000039 + renewal email WITHOUT signing anything (unsigned bad draft binds nothing). Never sign the current draft.**

**2026-07-30 09:00: Sandhya relayed all 5 corrections accurately to Econz team by email (Murat in CC) — good faith confirmed. ⚠️ Her point 3 names the signer as "Econz IT Services LLC (Dubai)" — not the exact legal name; revised signature block must read ECONZ IT CLOUD SERVICE AND DATACENTERS PROVIDERS L.L.C S.O.C verbatim (match party clause + VAT cert). Check this specifically on the revised envelope.**

**2026-07-30: Murat asked whether paying first could force acceptance of the original MSSA. No — unsigned draft binds nothing; deal would rest on Estimate EST-000039 + renewal email (no auto-renew, no true-up — arguably better than the MSSA). ONE real vector: click-wrap at the Nuclei/Mashreq checkout — before paying, check what the T&C checkbox links to; platform payment terms = fine, Econz MSSA = stop. If paying pre-signature, first send the pin-down email (payment against EST-000039 + 29-Jul renewal email; BoldSign draft declined pending corrections).**

**2026-07-30: payment channel switched — Econz sent a Stripe payment page (replacing the Nuclei/Mashreq portal quote). Verification checklist given to Murat: link source in-thread, stripe.com checkout domain, merchant name = Econz, amount AED 4,498.20 in AED (not USD), Sandhya to confirm the switch in writing, check any terms checkbox. Chargeback protection identical via Stripe. Sequencing unchanged: corrected MSSA (or pin-down email) before paying.**

**2026-07-30: Stripe page VERIFIED — merchant = Econz Dubai LLC ✓, ref EST-000039 ✓, AED 4,498.20 in AED ✓. Caveat: customer email prefilled as soz…@trackon.com (their recurring domain typo) — pay via "Pay without Link" (OTP would go to an uncontrolled address) and have Econz correct the Stripe customer email to sozturk@trackonsoftware.com for receipts. Save Stripe receipt + final tax invoice after payment.**

**Execution status: transfer authorization generated and sent 2026-07-29** (Murat, via admin.google.com/ac/resellermanagement). Awaiting: Econz activation → tax invoice (verify in 7-day window before paying by card) → Sandhya's email with the no-auto-renewal clause (chase if it doesn't arrive) → Google's final prorated flexible invoice (~€105, 1–29 Jul, expected) → Billing page shows Econz as reseller. Then hand tax invoice to accountant (AED 214.20 input VAT reclaim).

~~**REOPENED (2026-07-29).**~~ Google's self-serve annual plan turned out to be yearly-prepay only (no monthly payment) → prepayment advantage over Econz gone; real gap ~€120–145/yr in Econz's favor (incl. FX). Murat's (correct) observation: renewal price is structurally capped — transfer-back to Google at list price costs ~30 min, so a reseller quoting above list loses the customer; renewal quotes drift toward list, not above. → Ask trimmed to the single clause that matters: **no renewal/re-commitment without written approval** (prevents silent rollover into a new 12-mo commitment before comparing). Leaning ECONZ. Path: written no-auto-renew → corrected domain on proposal → token → verify invoice in 7-day window → pay by card. Escape hatch either way: transfer back to Google direct at term end is a 15-min billing-only process.

~~**RESOLVED (2026-07-28): Econz offer DECLINED — going Google direct annual plan.**~~ (superseded 2026-07-29) Murat decided after full evaluation: at 7 seats the true gap vs Google direct annual is only ~€100/yr, not worth the billing migration, counterparty exposure, prepayment, and renewal management. Polite decline sent to Sandhya (door left open for seat growth / GCP-Gemini needs).

Follow-through:
1. Switch plan in Admin Console → Billing → Subscriptions → Business Standard → change Flexible to Annual plan. **2026-07-29: actual checkout price confirmed — €163.20/user/yr (€13.60/user/mo) = €1,142.40/yr for 7 users, saving €218.40/yr (16%). Contract start 29 Jul 2026, renewal Jul 2027. Monthly-payment annual variant NOT offered in self-serve flow for this account (only yearly prepay) — confirmed 2026-07-29; proceeded with yearly prepay. Note: this removed the "no prepayment" advantage over Econz; decision held anyway on simplicity/zero-counterparty grounds (~€120/yr premium accepted).** After checkout: verify renewal settings in Billing.
2. Diarize ~June 2027: annual plan renewal review (seat count still right?).
3. Accountant questions from [[_personal/financial/vat-reverse-charge-gap-2026-07|VAT reverse-charge gap]] — RCM going forward + AWS input VAT reclaim (independent of this decision, potentially real money).
4. Revisit reseller option if team grows past ~15 seats.
