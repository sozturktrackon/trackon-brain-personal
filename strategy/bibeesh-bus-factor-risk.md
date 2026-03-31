---
type: strategy
status: active
tags: [team, risk, legacy, bus-factor, confidential]
created: 2026-03-31
updated: 2026-03-31
related: [company/team/bibeesh, products/trackon-legacy/overview, products/trackon-legacy/technical-debt]
---

# Bus Factor Risk: Bibeesh = 1 for Trackon Legacy

Person: [[company/team/bibeesh|Bibeesh]] | Product: [[products/trackon-legacy/legacy-overview|Trackon Legacy]] | Related: [[products/trackon-legacy/legacy-technical-debt|Legacy Tech Debt]]

## The Risk

Bibeesh is the sole developer who understands the full Trackon Legacy stack:
- Oracle DB architecture and schema
- Stored procedures and functions
- More Motion Library UI
- Deployment and operational procedures
- On-site IT support for Dubai customers (Agrisar, Mana)

No other team member can maintain, debug, or deploy Legacy independently.

## Evidence (from Jira analysis)

- 100% of TLB code changes go through Bibeesh
- 9% of TLB tickets reported by Bibeesh (catches issues via on-site visits)
- Nearly all TLB tickets are unassigned — because there's nobody else to assign to
- Ozan can support More Motion UI but has no Oracle DB knowledge
- Hamza handles reporting SQL but not application code or deployment

## What Happens If Bibeesh Is Unavailable

- No Legacy bug fixes
- No Legacy deployments
- No on-site IT support for Mana and Agrisar
- No feature development for 5 Legacy customers
- Customer escalations with no resolution path

## Knowledge Transfer Plan Needed

### Phase 1 — Document (immediate, low cost)
- [ ] Bibeesh documents Legacy deployment process step by step
- [ ] Bibeesh documents Oracle DB schema overview (key tables, relationships)
- [ ] Bibeesh documents More Motion build/deploy process
- [ ] Record a screen share of a typical bug fix workflow

### Phase 2 — Cross-train (Q2 2026)
- [ ] Ozan shadows Bibeesh on 3 Legacy bug fixes (More Motion + basic DB)
- [ ] Hamza learns Legacy deployment (he already knows the Oracle reporting layer)
- [ ] Kuzuturk learns basic Legacy triage (can already review Jira tickets)

### Phase 3 — Test (Q3 2026)
- [ ] Ozan resolves 1 Legacy bug independently with Bibeesh as reviewer only
- [ ] Hamza deploys 1 Legacy release independently

## Timeline

This is not urgent today but becomes critical the moment Bibeesh is sick, on vacation, or leaves. The documentation phase should start now — it costs nothing but Bibeesh's time.
