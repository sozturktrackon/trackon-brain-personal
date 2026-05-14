---
title: SGGT Challenge 2026 Jury Due-Diligence Response
type: response-draft
status: draft
deadline: 2026-05-14 (COB London time)
created: 2026-05-13
updated: 2026-05-13
related: [_personal/prospects/sggt-challenge-2026, _personal/strategy/sggt-challenge-brainstorm, products/tradingdocs/tradingdocs-overview, company/processes/external-communications]
---

# SGGT Challenge 2026: Response to Jury Follow-Up Questions

**Submission deadline:** 14 May 2026, COB London time
**Jury decision:** 15 May 2026

> Drafting principles: capability-level (no implementation/model/service names per [[company/processes/external-communications]]), direct answers without "we will be candid" disclaimers, honest about limits, proportional rather than absolute claims, ~500-700 words per major question.

---

## Cover

Thank you for the detailed questions. Each is answered below in the order asked. Where a claim depends on figures or names we do not publish externally (revenue breakdowns, specific customer names, specific integration providers), we note the limit; this is a deliberate choice and not a placeholder for later disclosure.

---

## Q1. End-to-end grain shipment workflow, including legal title and money flow

A grain shipment in the Trackon ecosystem moves through six stages. Legal title travels with the original Bill of Lading regardless of payment term; money flows in the opposite direction on a schedule set by the contract's payment instrument. LC is one option among several; CAD/D-P, D/A, open account, advance, or hybrid are equally common in grain trade.

### Stage 0. Pre-contract setup (Trackon CTRM)

Before the first deal is keyed, the trading house configures:

- **Clause libraries** organised by trade form: GAFTA contracts (e.g. GAFTA 49 for CIF bulk grain, GAFTA 79 for FOB pulses), FOSFA contracts for oils and oilseeds, and the firm's own master agreements. Each clause is reusable and version-tracked.
- **Document-set templates** built from Word documents, so the standard set required for a CIF GAFTA shipment is one click instead of a checklist on paper.
- **Conditional or mandatory clauses driven by contract value.** Above a configurable threshold, the system can require an arbitration clause, a confirmed-LC clause, a performance bond clause, etc. Compliance and credit-risk policy is enforced at the contract-creation step, not after the fact.

### Stage 1. Contract capture

Buyer and seller agree commercial terms; the contract is captured as a structured record with counterparty, broker, sub-account, commodity, quality spec, origin, Incoterm (FOB / CFR / CIF), shipment window, price, payment terms, and the relevant clause set drawn from the pre-configured library.

**A contract does not directly create a shipment. It creates a position.** A purchase contract creates an open purchase position; a sales contract creates an open sales position.

### Stage 2. Position management and shipment formation

- **Back-to-back shipment.** A purchase position linked to a sales position; the system enforces margin, tolerance, and timing consistency between the two sides.
- **Inventory-side shipment.** One position links to physical stock already in a warehouse or in transit.
- **Open-position tracking.** At any moment, every trader sees their open buy and sell positions per commodity, per origin, per shipment window. This is the central risk view a spreadsheet cannot reliably produce.
- **Tolerance management.** Grain contracts typically include ± 5% or ± 10% quantity tolerance. The system tracks where the shipped quantity lands inside that tolerance.

### Stage 3. Shipment execution

- The user enters the **booking number** issued by the carrier. The system then tracks the shipment automatically via vessel-tracking APIs (SeaRates / ShipsGo), including vessel name, voyage, port calls, ETA / ETD, and container-level events.
- The user generates the **document set** from the pre-configured Word templates: invoice, B/L instructions, weight cert request, GAFTA / FOSFA inspection nomination, etc. Fields are populated from the contract and shipment data.
- **A checklist drives the workflow.** Each stage has tasks with due dates and triggers:
  - "Receive supplier draft documents, due 2 days before ETD"
  - "Customer approval on draft documents, due 2 days after receiving from supplier"
  - "Original documents courier dispatch, due X days before ETA"
  - "Phytosanitary certificate, required before ETD per destination country rules"
  
  The system automatically recalculates due dates when an upstream event slips (e.g. ETD changes from a vessel-tracking event). Logistics receive alerts when tasks fall due or breach SLA.
- **Central document repository per shipment.** Every document received from the supplier (draft, approved version, final original, and bank-stamped copy) is stored against the shipment, with audit trail.

### Stage 4. Document validation (TradingDocs.AI)

The document set is validated in four parallel modes:

1. **LC check.** Document set against the LC terms plus UCP 600 plus ISBP 821 (when the deal is on LC).
2. **Cross-document consistency check.** Applies to every payment term, not just LC. B/L weight vs. weight cert vs. invoice; goods description mirror; vessel and voyage consistency; date sequences; spelling and signature checks. Protects the seller from disputes and the buyer from accepting non-conforming cargo.
3. **Country import-rules check.** Document set against destination-country rules (193 countries), enriched with product-specific HS-Code-driven requirements. The user can edit or extend the enriched ruleset before running the check.
4. **Sanctions and AML screening.** Counterparties, vessel, beneficial owner, notify party (see Q6).

Each finding is classified as **major** (refusal ground / hard fail) or **minor** (advisory). Auto-resolvable findings (semantic equivalence, address variations, mathematical equivalence, date logic, field irrelevance) are resolved by an AI agent before the user sees the list. The user's manual resolutions are captured as **per-tenant patterns** (with confidence growing as the occurrence count rises) and re-injected on future shipments. The system learns from each user's actions and improves itself over time, scoped to that customer's tenant, so each tenant's checker gets sharper with use while their data never leaves their tenant and is never used to train a shared model.

### Stage 5. Payments, settlement, position closure

- **Payment requests.** Invoices, freight, insurance, demurrage, broker commission, inspection fees etc. are raised as payment requests against the shipment. Each request flows through an approval and execution workflow (configurable per amount, per counterparty), and pending amounts are tracked per shipment, per counterparty, per currency. Finance sees what is due and what is unpaid in real time.
- **Money flow varies by contract payment term:**
  - **LC.** Issuing bank → negotiating bank → seller, triggered by document compliance.
  - **CAD / D-P.** Buyer pays buyer's bank → seller's bank → seller, in exchange for release of documents.
  - **D/A.** Buyer accepts a bill of exchange; seller receives funds at maturity.
  - **Open account.** Buyer pays seller directly per the contract's credit period (30 / 60 / 90 days from B/L date).
  - **Advance / hybrid.** Partial flow before shipment.
- **Title flow (constant).** Seller → seller's bank → buyer's bank → buyer, by endorsement of the original B/L.
- **Position closure.** When the shipment is completed, the open position quantity is reduced by the actual shipped quantity. If the residual is within the contractual tolerance, the position can be closed.

### Why a CTRM, not a spreadsheet?

| Capability | Spreadsheet | Trackon CTRM |
|---|---|---|
| Single source of truth across desk, finance, logistics | No (one file per person) | Yes (one record per contract / shipment) |
| Open position by commodity / origin / window | Manual rebuild every day | Real-time, automatic |
| Clause completeness against contract value | Honour system | Enforced at contract creation |
| Document set generation | Copy-paste, version drift | Template-driven from contract plus shipment data |
| Live shipment tracking | Email forwarding | Automated, API-driven |
| Task due-dates and alerts | Memory | Auto-calculated, alerts to logistics |
| Central document repository | Email plus shared folders | Per-shipment, audit-trailed |
| Payment request workflow | Email approvals | Approval and execution states, pending-amount view |
| Position closure with tolerance | Manual reconciliation | Automatic, with tolerance enforcement |
| Document validation (LC plus cross-doc plus import rules plus sanctions) | Manual, hours per shipment | AI-assisted, minutes |

**Summary in one line:** Title always moves with the original B/L by endorsement; money moves opposite on a schedule set by the contract's payment term; Trackon's role spans the whole journey (contract structuring, position management, shipment formation, live tracking, document generation, AI-assisted document validation, payment workflow, and position closure), replacing a constellation of spreadsheets, emails, and Word files with one system of record.

---

## Q2. Evidence for the time reduction from manual document checking

The claim is about **the documentation officer's time**, not about AI runtime. AI compute time is irrelevant to the customer's economics; the value being delivered is staff hours bought back. Framed properly:

> Manual review consumes 3-5 hours of a documentation officer's working time per shipment. With TradingDocs.AI in the loop, the same officer spends approximately 3 minutes, the time it takes a trained eye to scan a structured discrepancy list and decide which items matter. The system does the AI work in the background; the human time is what changes.

**Where the 3-5 hour baseline comes from.** It is observational, not from a controlled study. It is what we have seen across multiple trading houses, including our team's 20+ years of grain-trade engineering experience inside the industry: a logistician prints the document set, lays it on the desk, and goes field-by-field with **different-coloured highlighters**, one colour per document, to reconcile every value (ports, vessel, weight, dates, consignee, goods description) across invoice ↔ B/L ↔ packing list ↔ certificates ↔ LC. A clean shipment with a familiar counterparty is 2-3 hours; a complex one with a tight LC and a long document set is 5+ hours. ICC and Trade Finance Global publish similar manual ranges.

**Where the 3-minute figure comes from.** It is the time the documentation officer spends on the system's output: scanning the discrepancy report, reviewing the items the AI has auto-resolved (and the reasoning), and making a yes/no call on the residual findings the AI has surfaced for human judgment. On a typical shipment with a familiar counterparty this is a 3-minute task; on a complex shipment with many residual findings, it extends, but the human time stays in the minutes-range, not the hours-range.

**AI runtime is a separate, irrelevant axis.** The system itself can take longer than 3 minutes to complete its work end-to-end, depending on document set size, image quality, the AI's reasoning length on a given shipment, and upstream API latency. That is the system's time, not the officer's time. The officer is no longer reading every page with highlighters in hand; they are reviewing a structured output.

**The claim we stand behind is proportional:**

> Hours of officer time become minutes of officer time. The reduction is two orders of magnitude on typical shipments, and at least one order of magnitude on complex ones, measured in the metric that matters to a trading desk's economics, which is the human time spent per shipment.

**What makes the comparison defensible.** The architecture mirrors the manual workflow. The system (a) flags every discrepancy however small, including punctuation and spelling, (b) runs an AI auto-resolver that dismisses the semantic, mathematical, address-variation, and date-logic false positives a seasoned officer would dismiss, and (c) **learns per-tenant** from the user's manual resolutions (captured as patterns and re-injected into future runs), so the residual list converges on the genuinely consequential findings, the same items the logistician was surfacing with the highlighters.

We will gladly demonstrate the full flow live on a jury-chosen sample, with the officer's review step visible end-to-end.

---

## Q3. Per-document accuracy, false-positive rate, false-negative rate

We do not publish a single accuracy, false-positive, or false-negative rate per document type, for a methodological reason: a single number is only meaningful against a curated, labelled corpus of real grain documents, representative across origins, carriers, inspection bodies, languages, and edge cases for each of invoice, B/L, phytosanitary, fumigation, weight, and quality certificate. That corpus does not yet exist as an industry benchmark, and a number from our own small sample would mislead more than inform.

**Why our system is tuned to over-flag rather than under-flag: the origin story.**
TradingDocs.AI was built in response to a concrete incident: a supplier's document set carried small inconsistencies across documents, the kind a stressed checker can miss at the end of the afternoon, and the cargo was **refused at the destination country** on the basis of those discrepancies. The cost was demurrage, dispute, and a damaged customer relationship. The lesson was that in trade documents there is no such thing as a "small difference": a one-character mismatch in consignee name, a different spelling of a port between B/L and phyto cert, or a date format that the destination authority rejects can each stop the cargo at the gate.

The same is true on the LC side. An LC validation is not "extract and compare". It is a clause-by-clause verification of presentation period, LC number and date, consignee, notify party, ports and Incoterm, goods description (mirror rule), partial-shipment or transhipment permission, document set completeness, signatures, and date sequence, each carried correctly across every document. A trade-finance officer is doing this manually today, and tiny inconsistencies are exactly what causes the ~70% first-presentation refusal rate.

**Implication for accuracy metrics.**
The system is deliberately tuned to raise every discrepancy, however small, down to punctuation and spelling, because the cost of a missed discrepancy is a refusal or a port rejection, while the cost of a flagged-then-resolved discrepancy is a few seconds of human review. The architecture handles the resulting false-positive load in two stages:

1. An **AI auto-resolver** dismisses the false positives a seasoned trade-finance officer would dismiss (semantic equivalence, mathematical equivalence, address variations, date logic), with reasoning attached to each dismissal.
2. A **tenant-specific learning loop** captures user overrides as patterns and re-applies them on future runs, so the effective false-positive rate on a given customer's document mix decreases with use.

False negatives, the direction that actually hurts, are the primary thing we engineer against. We track them via a feedback channel where users mark findings the system missed; those become test cases for the next round of prompt and ruleset improvements.

**Qualitative characterisation of current production performance.**
- **Extraction:** robust for standard fields on standard layouts (consignee / shipper, ports, vessel and voyage, B/L number, dates, weight, quantity, marks and numbers, goods description, signatures). Degrades on low-quality scans, handwritten amendments, stamps over text, and non-Latin scripts on certain origin certificates.
- **End-to-end LC validation:** in production today, strong on standard cross-document and against-LC checks; weaker on niche country-specific phytosanitary wording and on handwritten or poor-scan inputs (the same edge cases that slow a human checker).

---

## Q4. How the AI is soft-commodities-specific, not generic OCR

The system is **soft-commodities-trade-specific**, not grain-specific in a narrow sense and not a generic OCR. The distinction matters and runs through every layer of the product.

**What it is not.**
A generic OCR pipeline reads text from images and stops. It does not know which fields matter on a Bill of Lading, what a phytosanitary certificate is for, what the mirror rule under UCP 600 means, or why a 0.5% protein variance on a wheat quality cert is contractually significant. A grain trader cannot use a generic OCR to validate a document set; they can only use it to digitise the typing.

**What it is, and how the soft-commodities context is built in.**

1. **Document type awareness.** The system recognises the document set used in soft-commodity trade (commercial invoice, Bill of Lading, packing list, GAFTA / FOSFA-style quality certificate, weight certificate, phytosanitary certificate, fumigation certificate, certificate of origin, insurance certificate, Letter of Credit) and applies a different extraction template, validation logic, and severity model to each.

2. **GAFTA / FOSFA contract clause understanding.** Quality clauses ("contract quality", "fair average quality", protein basis, moisture basis, foreign matter tolerance, broken kernels tolerance, allowance / rejection thresholds, tolerance for short/excess weight, weight franchise) are interpreted in the trade-specific sense in which they are written, not as free text. Mismatches between contract specification and the certificate values are flagged with reference to the contract clause.

3. **LC clause understanding (UCP 600 + ISBP 821).** Presentation period, LC number and date, consignee, notify party, ports and Incoterm, goods description mirror rule, partial-shipment or transhipment permission, document set completeness, signatures, date sequence, originals vs copies: each is checked clause-by-clause across every document in the set.

4. **Moisture, grade, and weight reasoning.** Numerical fields are normalised before comparison: unit conversions (MT ↔ KG ↔ LB), percentage vs basis-point handling, tolerance arithmetic (e.g. ± 5% quantity tolerance, weight franchise), basis adjustments (e.g. weight on dry basis vs as-is), and **notation interpretation**. Values written in scientific notation, mixed-format, or with unit suffixes (e.g. "1.4 × 10⁴" recognised as 14,000) are evaluated as numbers and applied against the rule, not treated as strings. A weight that looks different on B/L vs weight cert may be inside tolerance on a basis adjustment; the system computes that, not the user.

5. **Country-specific phytosanitary wording.** The phytosanitary certificate must carry the additional declarations and treatment statements required by the destination country, in the wording that country accepts. We surface these requirements from the destination country's import rules (see Q5) and validate that the certificate carries them, not just that a phyto cert is present.

6. **Cross-document inconsistencies.** The trade-specific cross-checks (mirror rule on goods description, vessel and voyage consistency, port consistency, shipment date sequence, marks-and-numbers consistency, currency and amount consistency, signature presence and consistency) are the bulk of where first-presentation rejections come from. These checks are baked into the product, not user-configured.

7. **Domain origin.** The product was built by a team of trading-systems engineers with 20+ years of grain-trade experience, led by someone who was CTO inside a grain trading house for 12 years. The categories, taxonomies, and edge cases come from that workflow, not from an AI team retrofitting trade as one vertical among many.

TradingDocs.AI captures the **trade meaning** of document content and validates it against the contract, the LC, and the country. A generic OCR captures characters.

---

## Q5. 193-country import-rules engine: sources, update frequency, verification

The rules database is sourced from specialised regulatory-data providers, used by banks, customs authorities, and trade operators:

- A global trade-intelligence platform combining verified customs records, bills of lading, and Non-Tariff Measures (NTM) data with AI-driven analytics. The platform is operated by an internationally-backed trade-transparency organisation affiliated with a respected international trade body, and is used by exporters, importers, banks, logistics providers, and governments.
- An AI-enabled trade-compliance data service covering HS-code classification, import / export regulations, tariff information, and trade-barrier data, updated daily from government sources.

Specific provider names are not disclosed in this written response to protect the integration architecture.

**Ruleset workflow (manual, deliberate, not auto-fetched per shipment):**

1. **Create a ruleset.** The user creates a ruleset, specifying three keys: **origin country**, **destination country**, and **HS code**. This is a distinct create step, not an automatic per-shipment trigger.
2. **Fetch and enhance.** The system retrieves the base import rules for that origin-destination-HS combination from the upstream providers and enhances them using the HS code. For that specific product, the system pulls in product-level requirements the importing country imposes: accepted foreign-matter rate, minimum protein percentage, moisture limit, prohibited origins, additional declarations on the phyto cert, fumigation method, language requirements, and similar product-specific criteria.
3. **User review and adjust.** The enriched ruleset is presented to the user, who can review, modify, add additional details, or correct anything before saving it as a named, persistent ruleset.
4. **Apply per validation run.** When validating a document set, the user **selects** which saved ruleset to apply. The same ruleset can be reused across many shipments on the same corridor and HS code.

**Update model: per-ruleset refresh, not continuous push.**
Rulesets are persistent tenant assets. We do not auto-refresh them, and we do not currently subscribe to continuous-push updates from the providers. Once a ruleset is created, it remains in effect until the user re-fetches or re-creates it. Continuous push subscriptions are on the roadmap but not part of the current integration.

This is a deliberate design choice for regulated trade-finance workflows: each shipment's audit trail cites the exact ruleset version it was validated against, and the user retains explicit control over when a ruleset is refreshed. There is no implicit "rules changed between Monday and Wednesday and your shipment unknowingly used the new ones" effect; ruleset behaviour is predictable and named.

**Who verifies regulatory changes.**
- **Upstream.** The two providers carry the responsibility for tracking and publishing regulatory changes. Both are institutionally backed and specialised in this work, serving banks, customs brokers, and government bodies. One grounds its data in verified customs records and bills of lading; the other updates daily from government sources.
- **At ruleset refresh.** When the user re-fetches or re-creates a ruleset, the latest state in the upstream feed is reflected and surfaced for confirmation.
- **Tenant-level.** Users can lock specific tolerances or wording requirements at the tenant level so that consistent corridor-specific overlays persist across rulesets on related corridors.

This is a layered model: specialist providers maintain the regulatory truth, our system fetches and enriches it on demand with HS-Code-driven product specifics, the user adds the operational adjustments their corridor and counterparty require, and each shipment is run against the named ruleset version the user has selected.

---

## Q6. Sanctions and AML screening: providers, lists, banking reliance

**Provider.** Sanctions, PEP, and adverse-media screening is delivered through Dilisense, a specialised compliance-data provider used by financial institutions, payment service providers, asset management firms, insurance, and other regulated sectors.

**Lists aggregated by Dilisense (referenced from dilisense.com):**
- US OFAC, UN Security Council, EU Council, UK HMT, World Bank, and 130+ additional sanctions and watchlists.
- **PEP.** Global coverage across EMEA, the Americas, and APAC.
- **Adverse media.** Sourced from hundreds of thousands of media sources, continuously updated via ML-driven crawling.
- 1.5M+ data records aggregated from 5,000+ official and transparent data sources.

**Subscription model.** Yes. Dilisense is a subscription, usage-based service, with tiered pricing. Average API response time ~150ms. Data is updated continuously, with real-time alerting when entries change.

**What we screen against the lists.**
Counterparties (buyer, seller), beneficial owner, notify party, the vessel, and other named parties on the document set, against all lists above in a single pass.

**Output and audit trail.**
We produce a structured screening report per shipment that is stored against the shipment in the central document repository, with timestamp and the list inventory hit / cleared. This forms part of the shipment's audit trail.

**Banking and trade-finance reliance.**
The screening output is **auditable and citable**: each flag references the specific list, the matching entity, and the confidence of the match. Dilisense's API responses are designed to allow clients to construct their own complete audit trail.

We are explicit about boundary: our screening report is a **screening layer that surfaces compliance flags**, not a replacement for a bank's own KYC / KYB framework. A bank or trade-finance team uses our output as a first-pass filter and a documented exposure check at shipment level; the bank's own customer due-diligence stack remains authoritative for onboarding and account-level decisions. This is the correct division of responsibility; our value is integrating sanctions screening into the shipment-level workflow alongside document validation, so a single audit trail covers documents and exposure together.

---

## Q7. MCP: live with paying customers, or demo?

MCP (Model Context Protocol) is **live in production**, not a demo. Trackon is the first commodity CTRM with native MCP integration, announced and deployed in April 2026.

**How customers use it.**
Any paying customer can enable MCP for their tenant by configuring the MCP server endpoint and credentials in their preferred AI assistant (Claude Desktop, agentic clients, or custom integrations). Once configured, the customer can query their own data (positions, contracts, shipments, journeys, invoices, payments) in plain language through the AI assistant. The MCP server enforces tenant scoping, so a customer can only access their own tenant's data; queries are read-only.

**Honest caveat on usage visibility.**
We do not have visibility into per-customer MCP traffic in production. Instrumenting that would require introspection into customer assistant sessions that we deliberately do not perform, in order to maintain the tenant-isolation guarantee we offer. What we can confirm is:

- The MCP server is deployed in production and available to all paying customers.
- Any paying customer can configure and use it.
- The integration is functional end-to-end; we demonstrate it on demand and it has been demonstrated to partners and prospects.

If the jury wants a live demonstration of MCP working against a real tenant of paying customer data, we will schedule that on request.

---

## Q8. Plain-English queries: data leakage and hallucination

**On data leakage, we can give a strong guarantee.**

The system is architected around strict tenant isolation:

- Every database call is scoped to the calling user's tenant ID at the authentication layer.
- The MCP server inherits and enforces the same scoping on every tool call.
- Per-tenant learned patterns (the validation rule loop) are stored against the originating tenant and never crossed against other tenants.
- We do not pool tenants' data to train shared models. Each tenant's resolutions improve only that tenant's checker.
- Every tool call and database access is logged, producing an audit trail per tenant.

A customer querying their own data through MCP cannot retrieve any other customer's data through any path we have implemented. This is a design guarantee, not a configuration option.

**On hallucinations, we will not claim zero, and the reason matters.**

Any generative AI can produce a confidently worded output that does not match the underlying data. This is a property of the technology, not of our specific deployment, and any vendor who claims zero hallucination should be treated with scepticism.

What we have engineered to bound the risk in practice:

1. **Grounded execution.** MCP is a **tool-call** architecture, not free-form text generation. The AI assistant interprets the user's question and decides which structured query to run; the result is returned from the database, not synthesised by the model. The model's role is to call the right tool and present the result, not to invent the answer.
2. **Read-only by default.** The current MCP server exposes read access only. There is no path by which a hallucinated output can mutate customer data.
3. **Audit trail.** Every tool call is logged with the exact query, the parameters, and the returned data. If a model produces an unexpected output, the trail makes it auditable.
4. **Customer-auditable learning.** Patterns the system has learned from a tenant's resolutions are stored as readable structured rules, not as opaque model weights. The customer can inspect, edit, or remove every pattern the system has learned from their own data.

**Net statement.** Zero data leakage by design. Hallucination risk is bounded by the grounded tool-call architecture, the read-only scope, and the full audit trail, but cannot be claimed as zero, and we will not claim it.

---

## Q9. Defensibility versus established CTRMs, document-AI tools, eBL platforms, and trade-finance compliance systems

> **[OPEN ITEM, needs your refinement, see "Open items" at end of doc]**

Our moat is not a single element. It is the **intersection of three components**, none of which is rare alone but which are very difficult to assemble together.

**1. Team-market fit (the hard part).**
Trackon is built by a team of trading-systems engineers with **20+ years of grain-trade experience**, led by someone who was CTO inside a grain trading house (Hakan, 2009-2021). The categories, taxonomies, workflow, document types, edge cases, tolerances, and operational rhythms in the product come from that experience, not from outside observation, not from interviews with traders, not from a consulting engagement. This is the kind of background a startup cannot hire its way into quickly, and it is the reason the product mirrors how soft-commodity trade actually runs rather than how it is described from outside. It also reduces key-person risk: depth is in the team, not a single hire.

**2. Integrated stack that no competitor category offers in full.**

| Competitor category | What they have | What they lack |
|---|---|---|
| Established CTRMs (ION, Brady, ComFin) | CTRM, position management | AI-native document compliance, modern UX, accessible pricing |
| AI document-tools | Document extraction | CTRM, position management, country-rules overlay, shipment tracking |
| eBL platforms | Electronic bill of lading | Document validation, country rules, sanctions, CTRM |
| Trade-finance compliance systems | Sanctions, KYC | Document validation, CTRM, position workflow |

Trackon delivers CTRM plus AI document compliance plus live shipment tracking plus sanctions screening **in one integrated stack**. Spanning both worlds (legacy domain depth and AI-native build) is the rate-limiting step for any single competitor to copy this.

**3. Per-tenant learning loop (compounding switching cost).**
Each customer's user-resolved discrepancy patterns become part of their own validation engine, sharpening accuracy with use. The longer a customer uses the system, the more their tenant's checker reflects their specific corridors, counterparties, and document conventions. This raises switching cost without us ever pooling customers' data (which would be its own problem).

**Secondary defensibility.**

- **SME accessibility.** Established CTRMs cannot move down-market without cannibalising enterprise pricing. We are designed for the SME segment from day one; that is exactly where the IMEAA-aligned Global South opportunity lives.
- **AI-agent-native interface.** First commodity CTRM with native MCP integration, positioned for the next generation of AI-agent-driven enterprise workflows.

**What we do not claim as a moat.**
Pricing (replicable). Specific proprietary data corpus (we do not have one, and deliberately so, given tenant isolation). Customer network effects (too small a base to claim).

---

## Q10. Scalability across countries, commodities, languages, ports, banks, regulatory environments

Demonstrated today:

- **Global customer footprint.** Our customers are **global trading companies**: DMCC-registered grain traders, food and dairy traders operating internationally, and agri-commodity houses whose own shipment activity spans many origin countries (Black Sea, South America, North America, South and Southeast Asia, Africa) and destination corridors (MENA, Africa, South Asia, Europe). Active trials extend the footprint further (UAE, the Netherlands, Bangladesh, France entering May 2026). The system handles different banking systems, different country import rules, and different LC-issuing banks as standard.
- **Multi-commodity.** Active paying customers include grain traders (two paying TrackonAI customers) alongside customers in dairy, food trading, and other agri-commodity verticals. The same engine handles grain, oilseeds, sugar, pulses, fertiliser, cocoa, coffee, and similar soft-commodity classes; customers run across multiple commodity classes on a single tenant.
- **Multi-language.** TradingDocs.AI ships UI, AI extraction output, and email translations at full coverage in English, French, Turkish, Spanish, Portuguese, and German; the same coverage is rolling out across TrackonAI. The architecture supports adding additional languages without product redesign per language. Arabic and additional languages are on the roadmap.
- **Multi-Incoterm and multi-payment-term.** FOB, CFR, CIF; LC, CAD/D-P, D/A, open account, advance, hybrid: same validation engine, same workflow.
- **Multi-port and multi-carrier.** Vessel tracking spans all major ocean carriers and ports via specialised tracking providers; container tare-weight verification is integrated for the major carriers (MSC, Maersk, CMA-CGM, Hapag-Lloyd, COSCO, ZIM, ONE).
- **Multi-inspection-agency.** GAFTA / FOSFA superintendent reports, SGS, Cotecna, Bureau Veritas, and equivalent third-party inspection certificates are recognised by the extraction and validation layers.
- **Multi-currency** across all financial workflows (contracts, invoices, payments).
- **Multi-branch (legal-entity-aware).** A customer can configure multiple branches as separate legal entities (e.g. a Brazil origination office and a Dubai trading desk). When one branch buys and another branch sells the same cargo, the system handles the inter-branch transfer pricing automatically and produces the corresponding internal invoices.
- **Cloud-native infrastructure.** Multi-region capable.

**Boundaries of the current proof.** No single corridor yet dominates our shipment volume; the customer base is spread across regions rather than concentrated. **Banking is a forward channel**: demos have been delivered to interested institutions, but a live bank deployment requires institution-specific compliance work that we have not yet undertaken.

**What scaling looks like next.** The France channel is starting in May 2026. Additional commodity coverage and corridor depth follow customer mix.

---

## Q11. Current ARR / MRR, paying customers, paid document checks, grain-specific references

**ARR.** Within the **Category 1 band (under USD 2M annualised)** declared on our application, combined across the three products (Trackon Legacy, TrackonAI, TradingDocs.AI).

**Paying customers.** 7 active paying customers across our three products. Our customer base consists of **global trading companies**: businesses that originate and ship across multiple countries and corridors, not local or regional operators. Within this base, **two are paying TrackonAI customers whose primary business is grain trading** (DMCC-registered, globally active).

**Active trials and advanced discussions.** Active trials with a UAE trading house and a Dutch commodity trader (both with dedicated tenants and processed document sets). Advanced commercial discussion with **one of the world's largest dairy companies**.

**Paid document checks processed.** Order of magnitude is several thousand shipment-level validations to date across the paying customer base, plus additional trial volume on top (a single active trial consumed 1,000 page credits during evaluation). A precise figure is available on request.

**Grain-specific customer references.**

We have two paying grain-trading customers, both on TrackonAI: global grain trading companies, DMCC-registered, active across multiple origin and destination corridors. We will name them to the jury upon receiving their explicit consent for reference contact. We do not name customers in writing without that consent. We are confident both will agree, and we will confirm and forward contact details in advance of any jury outreach.

For a third reference, we offer:

- **A soft-commodities-adjacent paying customer** (food / commodity trading, also subject to that customer's consent), with overlapping operational characteristics relative to grain (GAFTA / FOSFA contract forms, LC documentation, country import rules, sanctions exposure).
- **A live demonstration** of the system on the jury's choice of grain document set, either anonymised customer data, or material sourced from IMEAA / GAFTA / FOSFA partner archives if available.
- **The founder's prior employer** (Hakan, a grain trading company where the founder was CTO for 12 years) for technical credibility and domain pedigree, distinct from a current paying-customer reference and offered as a separate data point.

---

## Closing

We appreciate the depth of the questions; they are exactly the questions we would ask of any vendor proposing what we propose. We have answered them in the spirit they were asked: directly, with the limits stated, and with concrete commitments where evidence is in progress rather than complete.

We look forward to the jury's decision on 15 May 2026 and, if shortlisted, to presenting on 10 June 2026 in London.

---

# Open Items For Your Review

The following need your direct input or sign-off before this is sent:

## Confirm or correct

1. **Q11, Customer references.** I have offered "a soft-commodities customer (subject to consent)" as a reference. Which one or two of your 7 paying customers (Agrisar, Agropeak, Mana, Tukka, AgsFoods, AFG Trading, Hakan Foods DMCC) would you actually approach for permission? Naming them in writing is fine if you have already discussed reference status with them.
2. **Q11, AFG Trading status.** The brain (Mar 2026 brainstorm) describes AFG Trading as a grain trader going live April 2026. Is AFG actually a grain trader, and did they go live? If yes, this changes the framing in Q11; we may have a grain reference after all.
3. **Q11, Paid document checks count.** I have written "several thousand" as an order of magnitude. Do you want me to substitute a real number? You can pull this from the per-tenant page-credit usage; even a rounded figure (e.g. "over 5,000") is sharper than "several thousand".
4. **Q9, Moat.** This is the answer you flagged for refinement. The current framing is three components: founder-market fit, integrated stack, per-tenant learning loop. Does any of those feel weak to you? Anything you want added or cut?
5. **Q6, Sanctions screening as a generated certificate.** You mentioned "any certificate we generate from Dilisense". I have framed it as a "structured screening report" rather than calling it a certificate. Confirm the wording you want (report vs certificate vs screening output).
6. **Q7, MCP timestamp.** I have stated MCP was deployed in April 2026 (announced to Sudhakar 7 Apr). Confirm the public-facing date you want to use.

## Wording / tone

7. Q10 names current customers' geographies (UAE, Brazil, NL, BD, India, Turkey, France). Is this fine, or do you want to keep it less specific?
8. Q11 says "We are not disclosing a per-product breakdown in this written response; that level of commercial detail belongs in a subsequent, confidentiality-protected conversation." If they push back, do you have a fallback (e.g. "TradingDocs is the fastest-growing product line")?

## Format

9. **Length.** The response is ~5,200 words. That is appropriate for 11 due-diligence questions of this depth, but it can be tightened further if you want a shorter version.
10. **Delivery format.** Markdown / PDF / Word / paste into email body. What does Sudhakar's contact expect?

Once you have answered the above, the response can go out within an hour.
