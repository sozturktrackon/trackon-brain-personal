---
type: decision
status: open
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

**VAT (Murat asked 2026-07-28): neutral in both options, NOT an Econz advantage.** Econz: pay 5% (AED 214.20) in cash, reclaim as input VAT in next return → net zero with a cash-flow lag. Google direct: charges no UAE VAT (confirmed by our own invoices — €113.40 has no VAT line, and Google's EMEA billing policy puts non-Irish customers on self-assessment) → **reverse charge mechanism**: self-account 5% output VAT + deduct same 5% input VAT in the same return → net zero, no cash movement. Compliance note: accountant must actually be declaring RCM on imported services (Google, AWS, etc.) in the VAT return — verify this is happening. If Trackon FZCO were ever NOT VAT-registered, Econz's 5% becomes a hard cost while Google stays VAT-free.

**Revised lean: Google direct annual at this seat count.** Rationale: the remaining Econz execution cost (checklist emails, invoice verification, renewal negotiation in 2027) exceeds ~€100/yr of CEO attention; Google direct captures €227 of the €339 saving in 10 minutes with zero new risk. Econz becomes clearly worthwhile at ~15–20+ seats (gap scales to €250–350+/yr) or if the GCP/Gemini partner relationship gains strategic value. Both options defensible — Murat to decide.

## Status

**OPEN (2026-07-28).** Econz path fully de-risked (card payment confirmed, checklist defined) and viable. However, head-to-head vs Google direct annual shows the true gap is only ~€100/yr at 7 seats → revised lean: **Google direct annual** for simplicity/zero counterparty, unless Murat values the local partner relationship. If Econz: pre-token steps (1) written no-auto-renewal, (2) corrected domain, (3) trade license + entity-of-record for C012slhu9 → token → verify invoice in 7-day window → pay by card. Awaiting Murat's decision.
