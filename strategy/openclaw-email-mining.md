---
type: decision
status: planned
tags: [openclaw, email, automation]
created: 2026-03-31
updated: 2026-03-31
related: [company/tools/openclaw]
---

# Planned: Email Archive Mining via OpenClaw

Tool: [[company/tools/openclaw|OpenClaw]] | Output: [[_personal/crm/contacts|Contacts]], [[_personal/crm/crm-contacts|CRM Contacts]]

## Goal
Process full Gmail archive through OpenClaw to extract:
- Customer communication history
- Prospect threads and status
- Commercial commitments made over email
- Leads gone cold
- Any context not captured in vault

## Approach
1. Export Gmail archive via Google Takeout (mbox format)
2. Load into OpenClaw workspace on GX10
3. Process each email thread with local LLM
4. Output structured markdown files per contact/company
5. Merge into trackon-brain _personal/ folders

## Output targets
- _personal/crm/ — customer communication history
- _personal/prospects/ — prospect threads
- _personal/commercial/ — pricing and deal emails
- _personal/legal/ — any legal correspondence

## Status
Not yet started. Prerequisite: decide whether to use
Gmail MCP directly or offline Takeout export.
