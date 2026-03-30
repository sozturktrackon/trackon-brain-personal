---
type: strategy
status: active
tags: [strategy, architecture-decisions, product, commercial, confidential]
created: 2026-03-30
updated: 2026-03-30
source: conversation-history
related: [_personal/strategy/positioning-and-messaging.md, _personal/commercial/deal-log.md]
---

# Strategic Decisions (Not in Codebase)

These are decisions made in conversation that shaped direction but were never written into code or formal documentation.

---

## Product Decisions

### LC Comparison moved from TradingDocs.AI into TrackonAI
- **Decision:** For SME deals, position LC Comparison as a built-in TrackonAI feature, not a separate TradingDocs.AI subscription line
- **Driver:** Salvia 7 deal — reducing line items and complexity perception
- **Commercial implication:** Removes a separate $399/month revenue line for smaller customers. Needs to be reflected in all future proposal templates.

### TradingDocs.AI AI quality is rated 7/10 internally
- Strong: technical compliance, format validation, standard requirements
- Moderate: complex interpretation, edge cases
- Weak: practical document examination, real-world context, country-specific regs
- **Implication for sales:** Position as "initial review + flagging" tool, not replacement for expert review. Avoid overpromising in demos.

### REST/FastAPI is wrong for this stack — GraphQL only
- Every suggestion involving REST endpoints is incorrect
- All applications (tradingdocs, trackon-aws-backend, pikiflow) use GraphQL exclusively via AppSync

### Metadata-driven architecture is non-negotiable
- Entity definitions drive everything: CRUD, key formulas, GSIs, workflows, UI, AVP authorization, AI workflows
- "Surgical changes only" — no rewrites or refactors without explicit request

---

## Commercial Decisions

### User definition must be in every contract
- Identified gap in initial AFG Trading agreement — "user" was undefined
- Agreed definition: named individual, unique credentials, non-transferable, no sharing, license can be reassigned when employee leaves
- **Action:** Ensure all future agreements include this definition explicitly

### Liability framework for data breaches
- Trackon's negotiated position (from AFG deal): up to $50K for breaches caused by Trackon negligence/coding error/misconfiguration
- AWS-side breaches explicitly excluded
- Subscriber must prove: actual breach + causation + quantifiable damages
- Bug discovery ≠ automatic liability
- **This is now the standard template position**

### Implementation fee is always in advance
- Confirmed explicitly in Salvia 7 proposal: $10,000 in advance
- Not payable on milestones or post-delivery

### 50% discount for first 3 months is standard onboarding offer
- Used in both Salvia 7 proposals
- Serves as commitment-friction reducer for smaller prospects

### Additional dev rate: $100/hour; ≤2 hour fixes are free
- Consistent across AFG and Salvia 7 proposals
- This is the standard rate card

### Don't sign vendor renewals without written price lock
- Syncfusion lesson: verbal/email price stability promises are superseded by signed EULA §1
- Get price commitment written into Master License Agreement, not just email
- Email-based promises = unenforceable

---

## Sales Process Decisions

### Demo policy: 3 demos is the limit
- After 3 demos with no conversion, require a direct conversation with the actual decision-maker before any further investment
- 4th demo only if: (a) new decision-maker with real signing authority, AND (b) framed as closing/onboarding walkthrough, not evaluation

### Confirm decision-maker authority before demo
- Inanç/Salvia 7 lesson: Arzu is a champion, not a decision-maker. Demos to non-signatories loop indefinitely.
- Always confirm: "Can [name] sign without going back to [owner]?" before scheduling

### Closing demo format
- Use prospect's actual scenario (real shipment, real LC, real counterparty)
- Walk Ismihan-type stakeholders through the system "holding their hand" — not a feature tour
- Cover: contract entry → shipment → LC check → sanctions check in sequence

### ION Group / Aspect — don't compete on features
- They called (phone). Too large/complex for SME segment.
- Best counter: cost, speed of implementation, domain expertise, no 6-month implementation project

---

## Marketing Decisions

### Creatify.ai video strategy
- Target segments: Excel users, Indian market, SAP users (in addition to general CTRM)
- Tone: problem-solution, professional/corporate
- Approved script structure: operational pain → TrackonAI solution → feature proof points → social proof (SAP switchers) → CTA (trackon.ai)

### trackon.com vs trackon.ai
- trackon.com = corporate/company site (Dubai AI Seal, about us, press)
- trackon.ai = product site (TrackonAI features, demo booking)
- trackonsoftware.com = email domain (sozturk@trackonsoftware.com)

### Account sharing clause
- TrackonAI subscription agreement does not explicitly prohibit account sharing but per-user pricing structure implies it
- Recommended: add explicit prohibition in future agreements (per-user pricing intent is clear, but explicit is better)
