---
type: strategy
status: active
tags: [jira, process, team-management, confidential]
created: 2026-03-31
updated: 2026-03-31
related: [company/jira-insights, decisions/2026-jira-priority-rules]
---

# Jira Priority Inflation — Management Observation

## The Problem

- TLB: 61% of tickets marked Urgent
- TNT: 76% of tickets marked Urgent
- When everything is Urgent, actual prioritization is impossible
- The team has no shared definition of what Urgent means

## Root Cause

- Zendesk escalations arrive as Urgent by default (72% of TLB tickets come from Zendesk)
- No triage step between Zendesk escalation and Jira ticket creation
- Team members filing tickets also default to Urgent to get attention
- No consequences for mislabeling priority — so why not mark everything Urgent?

## Impact

- Actual critical issues (production down, data loss) are invisible in the backlog
- Team can't distinguish between "fix today" and "fix this sprint"
- Creates a culture of constant firefighting instead of planned work

## Fix (implemented)

Created [[decisions/2026-jira-priority-rules]] with new shared definitions:
- Critical: production down or data loss
- High: customer-facing bug blocking workflow
- Medium: everything else
- Low: nice to have

## What Still Needs to Happen

- [ ] Communicate new priority rules to team
- [ ] Update Zendesk→Jira integration default priority to Medium (not Urgent)
- [ ] Add a triage step: Kuzuturk reviews incoming Zendesk tickets and sets priority before team sees them
- [ ] Retroactively re-prioritize the 74 open TLB tickets
- [ ] Review after 30 days — is the distribution healthier?
