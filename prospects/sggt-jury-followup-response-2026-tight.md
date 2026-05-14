---
title: SGGT Challenge 2026 Jury Due-Diligence Response (TIGHT)
type: response-draft
status: draft
deadline: 2026-05-14 (COB London time)
created: 2026-05-13
updated: 2026-05-13
related: [_personal/prospects/sggt-jury-followup-response-2026, _personal/prospects/sggt-challenge-2026]
---

# SGGT Challenge 2026: Response to Jury Follow-Up Questions

**Submission deadline:** 14 May 2026, COB London time
**Jury decision:** 15 May 2026

---

Thank you for the detailed questions. Each is answered concisely below; we are happy to expand on any item live or in writing.

---

### Q1. End-to-end grain shipment workflow, including legal title and money flow

A grain shipment moves through six stages. **Legal title** travels with the original Bill of Lading regardless of payment term; **money** flows in the opposite direction, on a schedule set by the contract's payment term (LC, CAD/D-P, D/A, open account, or hybrid). LC is one option among several in grain, not a requirement.

- **Pre-contract.** Clause libraries (GAFTA / FOSFA), document-set Word templates, clauses made mandatory by contract value.
- **Contract.** Structured capture; creates a **position** (purchase or sale), not yet a shipment.
- **Position to shipment.** Purchase and sale positions match (back-to-back), or one matches inventory; quantity tolerance enforced (typically ± 5-10%).
- **Execution.** Booking number triggers automatic vessel tracking; document set generated from templates; checklist drives logistics with auto-recalculated due dates and alerts; central document repository per shipment.
- **Validation (TradingDocs.AI).** LC check (UCP 600 + ISBP 821), plus cross-document consistency, plus 193-country import rules, plus sanctions screening.
- **Settlement.** Payment-request workflow with approval and execution states and pending-amount tracking; money flows per contract term; B/L endorsement transfers title; position quantity reduced and closed if within tolerance.

The CTRM replaces a constellation of spreadsheets, emails, and Word files with one system of record.

---

### Q2. Evidence for the time reduction

The relevant metric is **the documentation officer's time**, not AI compute time. Manual review consumes **3-5 hours of officer time** per shipment, observed across multiple trading houses, including by our team during 20+ years of grain-trade engineering experience inside the industry. Officers reconcile fields with coloured highlighters across the document set. With TradingDocs.AI, the officer spends **approximately 3 minutes**, scanning a structured discrepancy list and deciding on the residuals. AI runtime varies in the background; the human time is what changes. **Reduction: two orders of magnitude** on typical shipments, one order on complex ones. Architecture: over-flag every difference, then AI auto-resolves obvious false positives, then the human reviews residuals, and per-tenant pattern learning sharpens future runs. Live demo on a jury-chosen sample available on request.

---

### Q3. Extraction accuracy, false-positive and false-negative rates

We do not publish a single per-document accuracy figure: a number is only meaningful against a labelled grain-document benchmark, which does not yet exist as an industry corpus. The system is deliberately tuned to **over-flag** rather than under-flag, because missed discrepancies cause port refusals and bank rejections (the product was built after a customer's cargo was refused at destination for a small inconsistency), while flagged-then-resolved discrepancies cost seconds. An AI auto-resolver dismisses obvious false positives (semantic and mathematical equivalence, address variations, date logic). A per-tenant learning loop reduces the residual false-positive load per customer over time. In production today, the system is strong on standard cross-document and against-LC checks, and weaker on niche country-specific phyto wording and poor scans (the same edge cases that slow a human checker).

---

### Q4. Soft-commodities-trade-specific, not OCR

The system is **soft-commodities-trade-specific**, built by a team of trading-systems engineers with 20+ years of grain-trade experience. It is not OCR. It recognises trade document types and applies a different extraction template, validation logic, and severity model to each. Built-in understanding of:

- **GAFTA / FOSFA quality clauses** (FAQ, protein and moisture basis, tolerances, allowance and rejection thresholds, weight franchise).
- **LC clauses (UCP 600 + ISBP 821).** Clause-by-clause across all documents (presentation period, mirror rule, partial shipment, signatures, dates).
- **Numerical normalisation and notation handling.** Unit conversions (MT ↔ KG ↔ LB), tolerance arithmetic, dry-basis adjustments, and **notation interpretation** (e.g. "1.4 × 10⁴" is recognised as 14,000 and evaluated against the rule, not treated as a string).
- **Country-specific phytosanitary wording.** Destination additional declarations and treatment statements.
- **Cross-document consistency.** The trade-specific checks that drive the ~70% first-presentation refusal rate.

A generic OCR captures characters; TradingDocs.AI captures their trade meaning.

---

### Q5. 193-country import-rules engine

**Sources.** We integrate with specialised regulatory-data providers: institutionally-backed trade-transparency organisations (one is affiliated with an international trade body), with daily updates from government sources, used by banks, customs authorities, and trade operators. Specific provider names are not disclosed in this response to protect the integration architecture.

**Ruleset workflow (manual, deliberate, not automated per shipment):**

1. The user creates a ruleset, specifying **origin country**, **destination country**, and **HS code**.
2. The system fetches base import rules from the upstream providers and enhances them using the HS code, pulling in product-level requirements (foreign-matter rate, minimum protein, moisture, prohibited origins, phyto wording, fumigation method).
3. The user reviews, adjusts, and saves the named ruleset as a persistent tenant asset.
4. When validating a document set, the user **selects** which ruleset to apply. The same ruleset can be reused across many shipments on the same corridor and HS code.

**Update model.** Rulesets are persistent. To pick up regulatory changes, the user re-fetches or re-creates the ruleset; until refreshed, the existing ruleset continues to apply. This is a deliberate design choice for regulated workflows: every shipment's audit trail cites the exact ruleset version used, and the user has explicit control over when a ruleset is refreshed.

---

### Q6. Sanctions and AML screening

Provider: **Dilisense**, used by financial institutions, payment service providers, and asset managers. Aggregates **OFAC, UN, EU, UK HMT, World Bank, and 130+ additional sanctions and watchlists**; global **PEP** coverage (EMEA, the Americas, and APAC); and **adverse media**. Per shipment we screen counterparties, beneficial owner, vessel, and notify party, and produce a structured screening report stored with the shipment's audit trail.

**Banking reliance.** The output is auditable and citable, suitable as a shipment-level exposure screen and documented audit trail. It is not a replacement for a bank's own KYC / KYB framework; the bank's customer due-diligence stack remains authoritative for onboarding. Our value is integrating sanctions screening into the shipment workflow alongside document validation, so one audit trail covers documents and exposure together.

---

### Q7. MCP: live with paying customers, or demo?

**Live in production.** Trackon is the first commodity CTRM with native MCP integration (April 2026). Any paying customer can enable MCP by configuring the endpoint and credentials in their preferred AI assistant; queries are read-only and tenant-scoped.

We do not have visibility into per-customer MCP traffic in production, because instrumenting that would compromise the tenant-isolation guarantee.

---

### Q8. Plain-English queries: data leakage and hallucination

**Data leakage: guaranteed by design.** Every database call and MCP tool call is scoped to the calling user's tenant at the auth layer. Per-tenant learned patterns are scoped to the originating tenant; we do not pool tenants' data to train shared models; every call is logged per tenant. One customer cannot retrieve another customer's data through any path implemented.

**Hallucination: bounded, not zero.** Any generative AI can produce a confidently worded output not matching the underlying data, and any vendor claiming zero hallucination should be treated with scepticism. We bound the risk:

1. **Grounded execution.** MCP is a tool-call architecture; results come from the database, not the model.
2. **Read-only** scope.
3. **Audit trail** of every tool call.
4. **Customer-auditable learning.** Patterns the system has learned from a tenant's resolutions are stored as readable rules, not opaque model weights. The customer can inspect, edit, or remove any pattern.

---

### Q9. Defensibility versus competition

The intersection of three components, none rare alone, hard to assemble together:

1. **Team-market fit.** Built by a team of trading-systems engineers with 20+ years of grain-trade experience. Categories, edge cases, and workflow come from inside the trade, not from outside observation.
2. **Integrated stack no single competitor category offers in full.** Established CTRMs (ION, Brady) lack AI document compliance. AI doc-tools lack CTRM and country rules. eBL platforms lack validation. Compliance systems lack CTRM. We span all four.
3. **Per-tenant learning loop.** Each customer's resolutions sharpen their own checker, compounding switching cost without pooling data.

Secondary: SME accessibility (established CTRMs cannot move down-market without cannibalising enterprise pricing); first commodity CTRM with native MCP integration.

---

### Q10. Scalability

- **Customers are global trading companies** whose shipments span the Black Sea, the Americas, South and Southeast Asia, Africa, and Europe, into MENA, Africa, South Asia, and Europe.
- **Multi-commodity.** Grain, oilseeds, sugar, pulses, fertiliser, cocoa, coffee, all on one engine, single tenant.
- **Multi-language.** TradingDocs.AI ships full UI, AI extraction, and email translations at 100% coverage in EN / FR / TR / ES / PT / DE; the same coverage is rolling out across TrackonAI. Architecture extends to additional languages without redesign. Arabic on roadmap.
- **Multi-Incoterm, multi-payment-term, multi-port, multi-carrier, multi-inspection-agency, multi-currency.** Standard.
- **Multi-branch.** Each customer can configure multiple legal-entity branches (e.g. an origination office in one country and a trading desk in another); the system handles transfer-pricing automatically when one branch sells to another.
- **Cloud-native, multi-region capable.**

Banking is a forward channel: demos have been delivered to interested institutions, and a live deployment requires institution-specific compliance work that has not yet been undertaken.

---

### Q11. ARR / customers / volume / references

- **ARR.** Within the **Category 1 band (under USD 2M annualised)** declared on our application, combined across the three products.
- **Paying customers:** 7 active global trading companies. **Two are grain-trading customers on TrackonAI** (DMCC-registered, globally active). Active trials with a UAE trading house and a Dutch commodity trader; advanced commercial discussion with **one of the world's largest dairy companies**.
- **Document checks processed:** order of magnitude several thousand shipment-level validations to date, plus active-trial volume on top. Precise figure on request.
- **Grain references:** **two paying grain-trading customers will be named upon their explicit consent** for jury contact. A third reference is available from an adjacent soft-commodities paying customer (on consent). A live demo on jury-chosen grain documents is available on request.

---

We appreciate the depth of the questions and look forward to the decision on 15 May 2026 and, if shortlisted, to presenting on 10 June 2026 in London.
