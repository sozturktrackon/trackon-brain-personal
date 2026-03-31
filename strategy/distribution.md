---
type: strategy
status: active
tags: [distribution, strategy, competitive, growth, confidential]
created: 2026-03-30
updated: 2026-03-30
source: project conversations
related: [_personal/strategy/positioning-and-messaging.md, _personal/commercial/deal-notes.md]
---

# Strategic Decisions & Distribution

Related: [[_personal/strategy/positioning-and-messaging|Positioning & Messaging]], [[_personal/commercial/deal-notes|Deal Notes]], [[_personal/commercial/demo-feedback|Demo Feedback]], [[_personal/intel/contacts-intel|Competitive Intel]], [[_personal/prospects/yagnesh-savania|Yagnesh Savania]]

## The Core Problem

**Distribution, not product.** The product works. The moat is getting it in front of the right buyers at the right moment.

TradeDoc.AI (Singapore, GTR Ventures-backed) is the clearest illustration: far less mature product, but GTR Ventures' 60,000-person trade finance network is a bigger competitive advantage than any feature we could build.

---

## Key Strategic Decisions Made in Conversation

### Do Not Approach TradeDoc.AI
- Drafted outreach message in March 2026 — decided against sending
- Partnership: unrealistic given fresh investment, independent roadmap
- Acquisition: not viable at pre-seed; they have no cash. Better timing: after TradingDocs.AI has more revenue traction; better targets: Surecomp, Finastra, sanctions data providers

### GTR MENA 2027 Tradetech Showcase
- **Identified as the single highest-leverage distribution opportunity**
- TradeDoc.AI got their pre-seed by being at GTR MENA 2026. This is where trade finance buyers and investors congregate.
- Target: speaking slot or Tradetech Showcase entry

### Mana DMCC Network
- Active paying customer; flagged as a reference and potential warm intro channel
- Most actionable near-term distribution asset

### Regulatory Compliance Roadmap (SOC 2, GDPR, DORA, EU AI Act)
- Raised by Debbie Demetrios in January 2026
- AWS-native tools exist for all of these
- **Status: Not yet actioned.** Noted as market requirement for US and EU expansion.

---

## Distribution Channel Assessments

| Channel | Decision | Reason |
|---|---|---|
| GTR MENA 2027 | **Pursue actively** | Highest-leverage trade finance audience |
| Agency MENA (outsourced sales) | **Rejected** | Wrong network (hospitality/F&B), contradictory claims |
| Debbie Demetrios (commission-only) | **Conditional** | Only if she can demonstrate real banking introductions |
| TradeDoc.AI (partnership/acquisition) | **Not now** | Fresh investment, wrong timing, no cash |
| Cold email via Success.AI | **Active** | Targeting dairy and logistics companies |
| Trade Finance Global / GTR (editorial) | **Active** | Media outreach ongoing |

---

## Demo Feedback Patterns (Across Prospects)

| Prospect | What Resonated | Objections / Blockers |
|---|---|---|
| DFA (Justin) | Personal relationship; Vault concept | AI committee review; price (originally) |
| Amee Foods (Dina) | Trial completed | "Not sure it's relevant to daily operations" — didn't experience clear ROI in trial |
| Gemini (Rahul) | LC export verification | Limited interest in broader compliance features |
| Midland Bank (Sami) | First banking client framing worked; demo done | Still in vendor evaluation; senior management decision |
| MHP (Syed) | Excellent trial results; shared with senior management | No conversion recorded |
| Saputo (Alejandro) | Engaged multiple times; shared with VP | No conversion recorded |

**Pattern**: The most common failure mode is not price — it's unclear ROI during the trial. Prospects who self-run trials without guidance don't connect document checking to their real operational pain.

---

## Lead Qualification Rules (from practice)

Disqualify immediately:
- Personal Gmail for enterprise meeting bookings
- Missing business footprint / no verifiable company
- Incoherent or mass-message-style initial contact
- Disposable email domains (dolofan.com, hutudns.com)
- Interest in API details before requesting a demo (competitor intelligence signal)

Research before investing time:
- Any new contact with a claimed banking background
- Any prospect routed through a partner channel (e.g., Droplinked → Macwise)
- WhatsApp-only contacts with no company info

---

## Product Strategy Decisions

### Vault (On-Premise Appliance)
- Built on NVIDIA DGX Spark; 128GB unified memory; drag-and-drop interface
- Hybrid mode: documents stay local, trade regulations fetched via API
- Air-gapped mode: validates against customer's own compliance rules
- Positioned for organizations requiring local data processing (banks, regulated entities)
- 3-month delivery backlog used as a demand signal in outreach
- Press release sent to ~12 publications (Trade Finance Global, GTR, others)

### Shipment-Based Pricing Rationale
- Page-credit model caused users to send fewer pages → worse accuracy → lower perceived value → churn
- Shipment-based aligns incentives: send everything, get the best result
- One shipment = complete document set up to 100 pages

### Not Building:
- White glove onboarding: defined as high-touch, reserved for enterprise; not the default model
