---
type: draft
status: draft # NOT SENT — Murat to review, then Bibeesh/Murat send
tags: [mana, dfa, salesforce, integration, email, phase1-closure]
created: 2026-08-19
updated: 2026-08-19
related: [customers/mana/mana-health, _personal/commercial/mana-sf-phase2-quote, _personal/commercial/mana-sf-phase1-closure-sdd, products/trackon-legacy/trackon-legacy-api-build]
---

# Phase 1 Closure — Email Drafts (2026-08-19)

Package: these two emails + [[_personal/commercial/mana-sf-phase1-closure-sdd|SDD deck]] + [[_personal/commercial/mana-sf-phase2-quote|Phase 2 quote deck]] + the option-list Excel.

**Before sending — prep checklist:**
- [ ] Hamza runs the reference SQLs from his TLB-2859 comment against Mana prod → one Excel workbook, one sheet per field (Currency, Product, Packing, Loading Port/Place, Destination Port/Place, Payment Terms), columns: `Trackon ID`, `Value`, plus attributes where relevant (payment terms: days / percent split).
- [ ] Murat decides the final fixed price (deck drafted at **$46,500** — see quote deck for reasoning) and the payment schedule (drafted 40/40/20).
- [ ] Render both Marp decks to PDF (`marp --pdf`), sanity-check pagination.
- [ ] Bibeesh sends Email 1 (reply-all on Justin's thread); Murat sends Email 2 in the same thread ~1–2 hours later, same day.

---

## Email 1 — Bibeesh → Justin (reply-all: Murat, Josh, Prisha, Chad, Sean)

**Subject:** Re: Drop Down Fields — option lists + Phase 1 design package

Hi Justin,

Apologies for the wait. Please find attached the option lists for the remaining drop-down fields, exported directly from Trackon:

- Currency
- Product
- Packing
- Loading Port / Place
- Destination Port / Place
- Payment Terms

Each sheet contains the **Trackon ID** and the display value. Salesforce should store the Trackon ID on the contract record — the label is for display only. (Container Type needs no action since your values already match Trackon, and the Trader mapping is with your Salesforce team, as discussed.)

**One important note on Payment Terms** — and to a lesser degree Products and the Port lists: these values are not fixed. Trackon users occasionally add new payment terms, and new loading/discharge ports appear as trade patterns change. The attached lists are a snapshot to unblock your Salesforce setup, but they should not be maintained by hand going forward.

As part of Phase 2, these same lists will be available through the Trackon API — the same authenticated API your team already holds credentials for. Your Salesforce team can then keep the picklists current in one of two ways:

1. **Live lookup** — Salesforce queries the API at contract-entry time. Always current, but adds an external callout inside the data-entry flow.
2. **Scheduled refresh + on-demand refresh (our recommendation)** — a nightly Salesforce job pulls the current values from the API, plus a *"Refresh from Trackon"* button available to your Salesforce admin. If a trader needs a payment term that was just created in Trackon, the admin clicks refresh and it is available within a minute — no waiting for the nightly run, and no manual re-typing of values on the Salesforce side.

Both patterns are described in the attached **Solution Design Document**, which closes out Phase 1. It covers the confirmed architecture, the security model (live), the master-data feed (live and already in your team's hands), the reference-data design above, the contract-creation API design, and the two contract approval-flow options we still need to settle together.

Murat will follow up in this thread today with the Phase 2 proposal, as committed in the June proposal.

Two asks from our side to keep the December go-live on track:

1. **Your field-mapping workbook and functional spec** (mentioned at kickoff) — the fixed quote is based on the mapping assumptions listed in the design document, and the workbook lets us confirm them quickly.
2. **A review call** this week or early next to walk through the design document and the proposal together — please propose a couple of slots that work for you and Chad.

Best regards,
Bibeesh

**Attachments:** `Trackon-DropDown-Options.xlsx` · `Trackon-SF-Integration-Solution-Design.pdf`

---

## Email 2 — Murat → Justin (same thread, same day)

**Subject:** Re: Drop Down Fields — Phase 2 proposal

Hi Justin,

Following Bibeesh's design package, please find attached our **Phase 2 proposal** — the fixed, itemised quote we committed to deliver at the end of Phase 1 (Design & Discovery).

The highlights:

- **Fixed price: $46,500** for the complete build and go-live — within the $36–48k range from the June proposal, now firm.
- The **master-data feed is already live** and verified end-to-end with your team's credentials, ahead of schedule. The **reference-data API** (payment terms, currencies, products, ports, packing — everything in today's lists) is included in the price, not an extra line.
- **Timeline:** with acceptance by **September 4**, development completes in ~10 weeks, leaving room for UAT, training and contingency to protect the **December go-live**.

The quote is fixed on the assumptions listed in the proposal — principally the field-mapping scope — and the review call Bibeesh proposed is the right place to confirm those together.

Thank you for the Phase 1 settlement, and we're looking forward to building this.

Best regards,
Murat Selim Ozturk
CEO, Trackon Software FZCO

**Attachment:** `Trackon-SF-Integration-Phase2-Proposal.pdf`

---

## Notes (internal)

- Email 1 deliberately makes the reference API visible as *Phase 2 value* (the staleness argument sells the live endpoints) while answering Justin's operational question in full — including Murat's admin-refresh-button design (2026-08-19).
- Email 2 lands the quote the same day the last free deliverable goes out — nothing further ships until acceptance ([[customers/mana/mana-health|standing order 2026-08-19]]).
- The Sep-4 acceptance date is derived: Dec go-live − ~10 wks dev − UAT/training/contingency. It makes DFA's own deadline carry the urgency.
- Do NOT attach or reference any Legacy table names / data dictionary — endpoints only (dependency directive).
