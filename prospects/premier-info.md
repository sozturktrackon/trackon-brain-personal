---
type: prospect
status: active
tags: [prospect, confidential, tradingdocs]
created: 2026-03-31
updated: 2026-03-31
related: [products/tradingdocs/backend/architecture]
---
# Premier Info

**Company**: Gemini Corporation NV (Netherlands) — IT handled by Premier Info (premierinfo.biz, India)
**Contact**: Rahul Sharma (+91 90243 37090), Rahul.Sharma@premierinfo.biz
**Second user**: Hariom Joshi, hariom.joshi@premierinfo.biz
**Product interest**: TradingDocs.AI
**Source**: Calendly booking — TradingDocs.AI Demo
**Location**: Dubai
**Note**: Rahul is Documentation Manager at Gemini Corporation NV, uses Premier Info email. India-based.

## Status

Trial active — rahul.tradingdocs.ai
- Initial 100 free pages used, then 200 added (2026-02-12), then 200 more added (2026-03-29)
- Total pages allocated: 500
- Uses Microsoft 365 for email
- Rahul's email domain bounces replies — WhatsApp is reliable channel

## Trial Feedback (2026-03-29)

Rahul's doc team tested several shipments and reported:
- **False positives**: System flagging invalid discrepancies (overly cautious — e.g. LC number on Load Report, address on supporting docs). Creates extra review work but by design — system flags everything for human review and learns from resolutions.
- **False negative (critical)**: Shipment 26BE02215_12 — system missed that "India" was missing from drawee bank address on draft. Root cause: UCP 600 Art. 14(d) applied too leniently, treating omission as non-conflicting variation instead of missing required element.
- **Fix deployed**: Strict completeness rule now enforced — partial matches with omitted elements are flagged as discrepancies across all doc types.
- 14 discrepancies flagged as invalid by their team; remainder confirmed valid or not disputed.

## Key Pain

LC document compliance checking accuracy. Their documentation team needs the system to catch real discrepancies without too many false positives.

## Current Process

- Gemini Corporation NV, Netherlands-based trading company
- Rahul is Documentation Manager, based in India (+91 9024337090)
- Has dedicated documentation officers who review LC compliance
- Trades to destinations including Spain (ES) and Belgium (BE) based on shipment codes

## Sales Progress

- 2026-02-12: Initial outreach, intro email sent, 100 free pages + 200 added
- 2026-02-24: Onboarded Rahul and Hariom on the platform, walked through UI via WhatsApp
- 2026-02-25: Rahul tested, got results via email, navigated to discrepancies
- 2026-03-09: Follow-up — Rahul said "will advise this week" (no follow-up)
- 2026-03-16: Follow-up — Rahul said "will advise this week" (again delayed)
- 2026-03-28: Follow-up attempt
- 2026-03-29: Rahul shared 5 test cases with feedback. Murat replied with detailed analysis. Email bounced from premierinfo.biz domain, sent via WhatsApp instead. Bug fix deployed. 200 more pages added. Asked Rahul to re-run shipment 26BE02215_12 to verify fix.
- 2026-03-29: Rahul replied "Let us check again"
- Next action: Wait for Rahul to re-run tests and come back with results. Follow up if no response by 2026-04-04.
