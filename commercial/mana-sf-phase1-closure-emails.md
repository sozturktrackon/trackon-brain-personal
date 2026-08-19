---
type: draft
status: draft # NOT SENT. Murat to review, then Bibeesh/Murat send
tags: [mana, dfa, salesforce, integration, email, phase1-closure]
created: 2026-08-19
updated: 2026-08-19
related: [customers/mana/mana-health, _personal/commercial/mana-sf-phase2-quote, _personal/commercial/mana-sf-phase1-closure-sdd, products/trackon-legacy/trackon-legacy-api-build]
---

# Phase 1 Closure: Email Drafts (2026-08-19)

Package: these two emails + [[_personal/commercial/mana-sf-phase1-closure-sdd|SDD deck]] + [[_personal/commercial/mana-sf-phase2-quote|Phase 2 quote deck]] + the option-list Excel.

**Status 2026-08-19: Email 1 SENT by Bibeesh, but WITHOUT the Excel attachment — the workbook was never generated (checked: file does not exist). Hamza must produce it, then Bibeesh sends the follow-up below.**

**Before sending, prep checklist:**
- [ ] **STILL OPEN**: Hamza runs the reference SQLs from his TLB-2859 comment against Mana prod → one Excel workbook `Trackon-DropDown-Options.xlsx`, one sheet per field (Currency, Product, Packing, Loading Port/Place, Destination Port/Place, Payment Terms), columns: `Trackon ID`, `Value`, plus attributes where relevant (payment terms: days / percent split). Active values only, Dubai-branch scope (consistent with the live API).
- [x] Price DECIDED (Murat, 2026-08-19): **$34,500 fixed, deliberately BELOW the accepted $36–48k range** so approval is easy/fast (total build incl. Phase 1 = $42k, under even the June proposal's lowest indicative total). Payment schedule still drafted 40/40/20.
- [x] PDFs rendered: `Trackon-SF-Integration-Solution-Design.pdf` + `Trackon-SF-Integration-Phase2-Proposal.pdf` (customer-facing names, in this folder).
- [x] Bibeesh sent Email 1 (reply-all on the technical thread) with the SDD; Excel follow-up pending (Email 1b).
- [ ] Murat sends Email 2 as a **SEPARATE, PRIVATE email to Justin only** (NOT on the technical thread — Bibeesh, Chad, Prisha, Sean must not see pricing; cc Josh only if Murat wants him in). Same day as Bibeesh's email.

---

## Email 1: Bibeesh → Justin (reply-all: Murat, Josh, Prisha, Chad, Sean). TECHNICAL ONLY

**Subject:** Re: Drop Down Fields

Hi Justin,

Apologies for the wait. Please find attached the option lists for the remaining drop-down fields, exported directly from Trackon:

- Currency
- Product
- Packing
- Loading Port / Place
- Destination Port / Place
- Payment Terms

Each sheet contains the **Trackon ID** and the display value. Salesforce should store the Trackon ID on the contract record. (Container Type needs no action since your values already match Trackon, and the Trader mapping is with your Salesforce team, as discussed.)

One note on Payment Terms: Trackon users add new payment terms from time to time, so the attached lists are a snapshot and should not be maintained by hand going forward. These lists will be served by the Trackon API, and the attached **Solution Design Document** describes two ways Salesforce can keep the picklists current, including an on-demand refresh for urgent additions. The document also covers the rest of the Phase 1 design: architecture, security, the live master-data feed, the contract-creation API, and the two approval-flow options.

One request for Chad's team: could you share the **field-mapping workbook and functional spec** mentioned at kickoff, so we can cross-check it against the contract interface field set before testing?

Best regards,
Bibeesh

**Attachments:** `Trackon-DropDown-Options.xlsx` · `Trackon-SF-Integration-Solution-Design.pdf`

---

## Email 1b: Bibeesh → Justin (follow-up, missing attachment)

**Subject:** Re: Drop Down Fields

Hi Justin,

Apologies, the option lists were missing from my earlier email. Please find them attached now.

Best regards,
Bibeesh

**Attachment:** `Trackon-DropDown-Options.xlsx`

---

## Email 2: Murat → Justin ONLY (new private email, NOT on the thread)

**To:** Justin Evans. No cc, or cc Josh Hosking at Murat's discretion. Never the technical thread.

**Subject:** Salesforce - Trackon Project: Phase 2 Proposal

Hi Justin,

With the solution design document and option lists Bibeesh just sent, Phase 1 (Design & Discovery) is complete. Attached is the final closing deliverable committed in the June proposal: the **Phase 2 proposal** with the fixed, itemised quote.

- **Fixed price: $34,500** for the complete build and go-live, **below the $36–48k range** we indicated in June. Phase 1 ran smoothly and part of the platform is already live ahead of schedule, so we are passing that efficiency on.
- The **master-data feed is already live**, verified end-to-end with your team's credentials. The **reference-data API** (payment terms, currencies, products, ports, packing: everything in today's lists) is included in the price, not an extra line.
- **Timeline:** with acceptance by **September 4**, development completes in ~10 weeks, leaving room for UAT, training and contingency to protect the **December go-live**.

The quote is fixed on the assumptions listed in the proposal, principally the field-mapping scope, which is why the workbook Bibeesh requested matters.

Thank you for the Phase 1 settlement, and we're looking forward to building this.

Best regards,
Murat Selim Ozturk
CEO, Trackon Software FZCO

**Attachment:** `Trackon-SF-Integration-Phase2-Proposal.pdf`

---

## Notes (internal)

- Email 1 deliberately makes the reference API visible as *Phase 2 value* (the staleness argument sells the live endpoints) while answering Justin's operational question in full, including Murat's admin-refresh-button design (2026-08-19).
- Email 2 lands the quote the same day the last free deliverable goes out; nothing further ships until acceptance ([[customers/mana/mana-health|standing order 2026-08-19]]).
- **Commercial correspondence NEVER goes to the technical thread** (Murat, 2026-08-19): pricing reaches Justin (the commercial decision-maker) privately; Bibeesh, Chad and DFA operational staff never see amounts. The technical audience still sees the schedule pressure through the SDD's closing slide ("Phase 2 acceptance by 4 September"), which carries the deadline without any pricing.
- The Sep-4 acceptance date is derived: Dec go-live − ~10 wks dev − UAT/training/contingency. It makes DFA's own deadline carry the urgency.
- Do NOT attach or reference any Legacy table names / data dictionary: endpoints only (dependency directive).
