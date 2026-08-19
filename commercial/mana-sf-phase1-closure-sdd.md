---
marp: true
theme: default
paginate: true
size: 16:9
style: |
  @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Raleway:wght@300;400;500;600&display=swap');

  :root {
    --a: #506CEA;
    --a2: #3C96EE;
    --bg: #F6F8FE;
    --card: #ffffff;
    --border: #E6EBF5;
    --heading: #16203A;
    --body: #45566E;
    --label: #7286A6;
    --muted: #9AA8C2;
    --green: #16a34a;
    --shadow: 0 8px 30px rgba(20,32,64,.08);
    --shadow-sm: 0 4px 16px rgba(20,32,64,.06);
  }

  section {
    background: radial-gradient(1100px 520px at 88% -8%, #E7EEFF 0%, rgba(231,238,255,0) 60%), var(--bg);
    color: var(--heading);
    font-family: 'Raleway', sans-serif;
    font-weight: 400;
    padding: 62px 96px;
    font-size: 22px;
    line-height: 1.5;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  h1 { font-family: 'Outfit'; font-weight: 800; font-size: 2.3em; letter-spacing: -0.03em; line-height: 1.04; margin: 0 0 10px; color: var(--heading); }
  strong { color: var(--a); font-weight: 600; }

  section::after { font-family: 'Outfit'; font-size: 0.5em; color: var(--muted); }

  img.logo { height: 110px; width: auto; margin: 6px 0 2px; }

  .eyebrow { font-family: 'Outfit'; font-weight: 700; font-size: 0.6em; color: var(--a); letter-spacing: 0.2em; text-transform: uppercase; margin-bottom: 14px; }

  .intro { max-width: 990px; font-size: 0.8em; color: var(--body); line-height: 1.6; }
  .intro + .intro { margin-top: 14px; }
  .caption { margin-top: 26px; text-align: center; font-size: 0.64em; color: var(--label); }

  .pill { display: inline-block; background: #506CEA12; border: 1px solid #506CEA33; border-radius: 30px; padding: 7px 18px; font-family: 'Outfit'; font-size: 13px; color: var(--a); font-weight: 600; letter-spacing: 0.03em; margin: 5px 5px 0 0; }
  .pill-green { background: #16a34a14; border-color: #16a34a3a; color: var(--green); }

  .row { display: flex; gap: 24px; align-items: stretch; margin-top: 26px; }
  .col { flex: 1; }

  .card { background: var(--card); border: 1px solid var(--border); border-radius: 16px; padding: 26px 28px; box-shadow: var(--shadow); }
  .card-accent { border-top: 3px solid var(--a); }
  .card-green { border-top: 3px solid var(--green); }
  .card-center { display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; }
  .card-title { font-family: 'Outfit'; font-weight: 700; font-size: 21px; color: var(--heading); margin-bottom: 10px; }
  .card-body { font-size: 0.62em; color: var(--body); line-height: 1.65; }

  .tag { display: inline-block; font-family: 'Outfit'; font-weight: 700; font-size: 11px; letter-spacing: 0.1em; text-transform: uppercase; padding: 4px 11px; border-radius: 6px; background: #506CEA15; color: var(--a); margin-left: 6px; vertical-align: middle; }
  .tag-live { background: #16a34a15; color: var(--green); }

  .li { position: relative; padding-left: 22px; font-size: 0.62em; color: var(--body); margin: 11px 0; line-height: 1.45; }
  .li::before { content: ''; position: absolute; left: 0; top: 0.5em; width: 7px; height: 7px; border-radius: 50%; background: var(--a); }
  .li-no::before { background: var(--muted); }
  .li-done::before { background: var(--green); }

  .flow { display: flex; align-items: stretch; gap: 18px; margin-top: 14px; background: transparent; }
  .flow .node { flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; box-shadow: 0 2px 10px rgba(20,32,64,.05); padding: 18px 14px; text-align: center; display: flex; flex-direction: column; justify-content: center; }
  .flow .nt { font-family: 'Outfit'; font-weight: 700; font-size: 15px; color: var(--heading); }
  .flow .ns { font-family: 'Raleway'; font-weight: 400; font-size: 12px; color: var(--label); margin-top: 4px; }
  .flow .arrow { display: flex; align-items: center; font-family: 'Outfit'; font-weight: 800; color: var(--a); font-size: 22px; }
  .flow-label { font-family: 'Outfit'; font-weight: 700; font-size: 0.55em; color: var(--label); letter-spacing: 0.14em; text-transform: uppercase; margin-top: 22px; }
  .flow-label.first { margin-top: 8px; }

  table { display: table; border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 0.58em; margin-top: 10px; background: var(--card); border-radius: 14px; overflow: hidden; box-shadow: var(--shadow-sm); }
  th:first-child, td:first-child { width: 28%; }
  th:nth-child(2), td:nth-child(2) { width: 18%; }
  th:last-child, td:last-child { width: 54%; }
  th { font-family: 'Outfit'; font-weight: 700; text-align: left; color: #fff; background: linear-gradient(135deg, #16203A, #2a3858); text-transform: uppercase; letter-spacing: 0.07em; font-size: 0.82em; padding: 12px 16px; }
  td { padding: 11px 16px; border-bottom: 1px solid var(--border); color: var(--body); }
  tr:last-child td { border-bottom: none; }
  tr:nth-child(even) td { background: #FAFBFF; }
  td strong { color: var(--heading); font-weight: 700; }

  .ws { margin-top: 14px; border: 1px solid var(--border); border-radius: 14px; overflow: hidden; box-shadow: var(--shadow-sm); font-size: 0.6em; }
  .ws-head, .ws-row { display: flex; }
  .ws-row { border-top: 1px solid var(--border); }
  .ws-row:nth-child(even) { background: #FAFBFF; }
  .ws .c1 { width: 31%; flex: none; padding: 13px 18px; font-family: 'Outfit'; font-weight: 700; color: var(--heading); }
  .ws .c2 { flex: 1; padding: 13px 18px; color: var(--body); line-height: 1.45; }
  .ws-head { background: linear-gradient(135deg, #16203A, #2a3858); }
  .ws-head .c1, .ws-head .c2 { color: #fff; text-transform: uppercase; letter-spacing: 0.07em; font-family: 'Outfit'; font-weight: 700; font-size: 0.85em; }

  section.dark { background: linear-gradient(140deg, #0E1526 0%, #1b2748 58%, #243561 100%); color: #fff; }
  section.dark h1 { color: #fff; }
  section.dark .eyebrow { color: var(--a2); }
  section.dark .intro { color: #c7d3ec; }
  section.dark strong { color: var(--a2); }
  section.dark .pill { background: #ffffff14; border-color: #ffffff33; color: #dbe6ff; }
  section.dark::after { color: #ffffff66; }

  section.lead { align-items: center; text-align: center; }
  .kicker { font-family: 'Raleway'; font-weight: 500; font-size: 15px; color: var(--label); text-transform: uppercase; letter-spacing: 0.28em; }
  .cover-title { font-family: 'Outfit'; font-weight: 800; font-size: 44px; color: var(--heading); letter-spacing: -0.02em; line-height: 1.05; }
  .rule { width: 60px; height: 4px; background: linear-gradient(90deg, #506CEA, #3C96EE); border-radius: 3px; margin: 14px auto 14px; }
  .cover-sub { font-family: 'Raleway'; font-weight: 400; font-size: 17px; color: var(--body); max-width: 760px; line-height: 1.5; }
  .cover-meta { font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: var(--heading); }
  .cover-meta-sub { font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: var(--body); }

  .code { font-family: 'SF Mono', Menlo, monospace; font-size: 0.56em; background: #16203A; color: #dbe6ff; border-radius: 10px; padding: 14px 20px; margin-top: 12px; line-height: 1.7; }
  .code .m { color: #6ee7a0; font-weight: 600; }
  .code .c { color: #8ea3c8; }

header: ''
footer: 'Trackon Software FZCO  ·  Salesforce → Trackon Integration  ·  Solution Design · Confidential · Prepared for DFA / Mana'
---

<!-- INTERNAL DRAFT 2026-08-19, not sent. Review before rendering: approval-flow wording (slide 11), field-mapping assumption list (slide 13). No Legacy table names anywhere: endpoints and payload groups only. No em-dashes, no meeting proposals (Murat, 2026-08-19). -->

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _footer: '' -->

<div class="kicker">Solution Design Document · August 2026</div>

<img class="logo" src="./trackon-logo.png" />

<div class="cover-title">Salesforce → Trackon<br/>Contract Integration</div>

<div class="rule"></div>

<div class="cover-sub">Phase 1 (Design &amp; Discovery) closure: the confirmed architecture, security model, live master-data feed, reference-data design, and the contract-creation API design for the Phase 2 build.</div>

<div class="cover-meta" style="margin-top: 20px;">Prepared for Justin Evans &amp; Chad Shumate · DFA / Mana</div>
<div class="cover-meta-sub" style="margin-top: 6px;">Trackon Software FZCO · Bibeesh Rathnapal · Murat Selim Ozturk</div>

---

<div class="eyebrow">Phase 1 · Design &amp; Discovery</div>

# What Phase 1 delivered

<div class="row" style="margin-top: 18px;">
<div class="col">
<div class="li li-done">Integration pattern &amp; security model confirmed with DFA IT, <strong>and already live</strong></div>
<div class="li li-done">Master-data feed (customers &amp; vendors): <strong>live, verified end-to-end with DFA credentials</strong></div>
<div class="li li-done">API credentials issued and handed to DFA (14 Aug working session)</div>
<div class="li li-done">Field-mapping ownership settled per field (14 Aug working session)</div>
</div>
<div class="col">
<div class="li li-done">Drop-down option lists delivered with Trackon IDs</div>
<div class="li li-done">Reference-data design: how picklists stay current (this document)</div>
<div class="li li-done">Contract-creation API design (this document)</div>
<div class="li">Contract approval flow: <strong>two options, confirmed with your Phase 2 acceptance</strong></div>
</div>
</div>

<div class="caption">Everything marked green is done. This document records the design; the accompanying proposal prices the Phase 2 build.</div>

---

<div class="eyebrow">Confirmed scope</div>

# The agreed model, unchanged

<div class="row">
<div class="col card card-accent">
<div class="card-title">Contracts <span class="tag">Salesforce → Trackon</span></div>
<div class="card-body">Approved contracts flow <strong>one way</strong> from Salesforce into Trackon. After creation, all edits, <strong>amendments</strong> and <strong>cancellation / termination</strong> happen in Trackon only. Trackon is the system of record.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Master data <span class="tag">Trackon → Salesforce</span> <span class="tag tag-live">Live</span></div>
<div class="card-body">Trackon is the <strong>master</strong> for customers and vendors. Salesforce pulls status, payment terms, credit limits and addresses from the live Trackon API so the front end stays current.</div>
</div>
</div>

<div class="caption">One way in each direction. No two-way sync, no conflicting edits to reconcile, exactly as agreed in June and confirmed at kickoff.</div>

---

<div class="eyebrow">Architecture</div>

# How the pieces connect

<div class="flow-label first">Contract creation &nbsp;·&nbsp; Phase 2</div>
<div class="flow">
<div class="node"><div class="nt">Salesforce</div><div class="ns">contract approved → callout</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Trackon API</div><div class="ns">api.trackonsoftware.com · OAuth 2.0 + TLS</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Validate &amp; map</div><div class="ns">Trackon business rules · retried</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Trackon</div><div class="ns">contract created</div></div>
</div>

<div class="flow-label">Master &amp; reference data &nbsp;·&nbsp; master data live today</div>
<div class="flow">
<div class="node"><div class="nt">Trackon</div><div class="ns">master &amp; reference values</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Trackon API</div><div class="ns">same host, same credentials</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Salesforce</div><div class="ns">scheduled pull + on-demand refresh</div></div>
</div>

<div style="margin-top: 24px;">
<span class="pill">One API host</span><span class="pill">One credential set, already with DFA</span><span class="pill">Direct Salesforce callouts, no middleware required</span>
</div>

---

<div class="eyebrow">Security · live and verified</div>

# Security design

<div class="row" style="margin-top: 16px;">
<div class="col">
<div class="li"><strong>OAuth 2.0 client-credentials</strong>: Salesforce obtains a short-lived token from the token endpoint, then calls the data endpoints. Standard Named Credential setup on the Salesforce side.</div>
<div class="li"><strong>TLS everywhere</strong>: all traffic over HTTPS on <strong>api.trackonsoftware.com</strong>; plain HTTP redirects to HTTPS.</div>
<div class="li"><strong>Dedicated integration credentials</strong>: the DFA/Salesforce client is scoped to this integration's endpoints only, revocable independently of any other consumer.</div>
</div>
<div class="col">
<div class="li"><strong>Minimal surface</strong>: the API host serves only the integration endpoints; everything else returns 404. Only the agreed business fields are exposed.</div>
<div class="li"><strong>Rate limiting</strong>: request-rate protection at the edge; well within normal integration traffic.</div>
<div class="li"><strong>Scoped data serving</strong>: active, Dubai-branch counterparties only, matching the reference files DFA already holds.</div>
</div>
</div>

<div class="caption">This posture is live and was verified end-to-end with DFA's own credentials: token issuance, authenticated reads, and correct 401/404 behavior from the public internet.</div>

---

<div class="eyebrow">Master data · live</div>

# Customers &amp; vendors feed

<div class="code">
<span class="m">POST</span> /mana/oauth/token &nbsp;&nbsp;<span class="c">· OAuth 2.0 token (client credentials)</span><br/>
<span class="m">GET</span>&nbsp; /mana/v1/customers &nbsp;·&nbsp; /mana/v1/customers/{id}<br/>
<span class="m">GET</span>&nbsp; /mana/v1/vendors &nbsp;&nbsp;&nbsp;·&nbsp; /mana/v1/vendors/{id}
</div>

<div class="row" style="margin-top: 20px;">
<div class="col">
<div class="li"><strong>Pull model</strong>: Salesforce pulls on its own schedule; pagination and delta filtering supported for efficient syncs.</div>
<div class="li"><strong>Same keys as your reference files</strong>: records carry the same Main Account / Sub Account / Contact IDs as the Excel files DFA already mapped against.</div>
</div>
<div class="col">
<div class="li"><strong>Active records only</strong>: a counterparty absent from a full pull has been deactivated in Trackon; Salesforce should deactivate its copy.</div>
<div class="li"><strong>Fields per agreed scope</strong>: names, status, payment terms, credit limits, addresses. Changes always originate in Trackon.</div>
</div>
</div>

<div class="caption">Full request/response detail, pagination and error codes are in the API Integration Guide already shared with Chad's team.</div>

---

<div class="eyebrow">Field mapping · settled 14 Aug</div>

# Who maps what

| Field | Mapping | Agreed approach |
|---|---|---|
| **Product Line** | In Trackon | Derived from the product Salesforce sends |
| **Department / Sub Department** | In Trackon | Derived from the trader Salesforce sends |
| **Branch** | In Trackon | Mapped inside Trackon |
| **Trader** | Done | Mapping already with DFA's Salesforce team |
| **Container Type** | None needed | Salesforce values match Trackon, sent as-is |
| **Currency · Product · Packing** | Trackon lists | Picklists in SF from Trackon option lists, ID recorded |
| **Loading / Destination Port** | Trackon lists | Picklists in SF from Trackon option lists, ID recorded |
| **Payment Terms** | Trackon lists | Recorded in SF, sent to Trackon as Trackon ID |

<div class="caption">Salesforce always stores the <strong>Trackon ID</strong>; display labels are cosmetic. This keeps every contract payload unambiguous.</div>

---

<div class="eyebrow">Reference data · design</div>

# Picklists that never go stale

<div class="intro">The option lists delivered today are a <strong>snapshot</strong>. Payment terms are added by Trackon users from time to time; ports and products evolve with trade patterns. Maintaining these by hand in Salesforce would drift within weeks, so Phase 2 exposes them as <strong>reference-data endpoints</strong> on the same API:</div>

<div class="code">
<span class="m">GET</span> /mana/v1/reference/payment-terms &nbsp;·&nbsp; currencies &nbsp;·&nbsp; products &nbsp;·&nbsp; packing &nbsp;·&nbsp; ports<br/>
<span class="c">· each returns the current option set: Trackon ID, display value, attributes</span>
</div>

<div style="margin-top: 20px;">
<span class="pill">Same host &amp; credentials as today</span><span class="pill">Full set per call, simple to consume</span><span class="pill">IDs stable over time</span>
</div>

---

<div class="eyebrow">Reference data · staying current</div>

# Two refresh patterns

<div class="row">
<div class="col card">
<div class="card-title">Option A · Live lookup</div>
<div class="card-body">Salesforce queries the reference API <strong>at contract-entry time</strong>. Values are always current, but every picklist interaction depends on an external callout inside the data-entry flow: added latency, and entry blocks if the connection is briefly unavailable.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Option B · Scheduled + on-demand <span class="tag">Recommended</span></div>
<div class="card-body">A <strong>nightly Salesforce job</strong> refreshes the picklists from the API. Alongside it, a <strong>"Refresh from Trackon" button</strong> for the Salesforce admin: when a trader needs a payment term just created in Trackon, the admin clicks refresh and it is available <strong>within a minute</strong>: no waiting for the nightly run, no manual maintenance ever.</div>
</div>
</div>

<div class="caption">We recommend Option B: reference values change occasionally, not constantly. A cached picklist with a one-click urgent refresh gives traders a fast entry form <em>and</em> same-day access to new values.</div>

---

<div class="eyebrow">Contract creation · Phase 2 core</div>

# The contract-creation API

<div class="intro">A single endpoint accepts the complete contract in <strong>one JSON payload</strong> and creates it in <strong>one transaction</strong>: through Trackon's own business rules, exactly as a contract entered on a Trackon screen. Either the whole contract is created, or nothing is.</div>

<div class="ws">
<div class="ws-head"><div class="c1">Payload group</div><div class="c2">Contents</div></div>
<div class="ws-row"><div class="c1">Header</div><div class="c2">Contract type, counterparty (Trackon ID), trader, dates, currency, branch context</div></div>
<div class="ws-row"><div class="c1">Products &amp; quantities</div><div class="c2">Product (Trackon ID), quantity, packing, tolerances</div></div>
<div class="ws-row"><div class="c1">Pricing &amp; payment</div><div class="c2">Price terms, payment terms (Trackon ID), premiums where applicable</div></div>
<div class="ws-row"><div class="c1">Quality</div><div class="c2">Quality parameters per product, defaults from the product master where not sent</div></div>
<div class="ws-row"><div class="c1">Logistics</div><div class="c2">Loading / destination ports (Trackon IDs), container type, shipment periods</div></div>
<div class="ws-row"><div class="c1">Clauses</div><div class="c2">Selected <strong>by reference</strong>: Salesforce sends clause IDs; wording, documents and printing stay in Trackon</div></div>
</div>

<div style="margin-top: 16px;">
<span class="pill">Idempotent: safe retries via a Salesforce-supplied reference ID</span><span class="pill">Clear per-field validation errors back to Salesforce</span>
</div>

---

<div class="eyebrow">Design decision · your choice</div>

# Approval flow: two options

<div class="row">
<div class="col card">
<div class="card-title">Option 1 · Approved on arrival</div>
<div class="card-body">Salesforce sends the contract <strong>after SF approval</strong>; Trackon creates it directly in approved status. Simplest flow, but the contract document (clauses, print) is only produced <em>after</em> approval, so any clause adjustment means handling it in Trackon post-approval.</div>
</div>
<div class="col card">
<div class="card-title">Option 2 · Draft, then approve in Trackon</div>
<div class="card-body">Salesforce sends the contract at SF approval; Trackon creates it as a <strong>draft</strong>, the team finalises clauses and prints, then approves in Trackon. One extra step, but the printed contract is reviewed before it becomes binding in the system of record.</div>
</div>
</div>

<div class="caption">Both are fully supported by the same API. This is a <strong>workflow choice, not a cost difference</strong>. Confirm your preference with the Phase 2 acceptance and we build accordingly.</div>

---

<div class="eyebrow">When something fails</div>

# No silent failures

<div class="row" style="margin-top: 14px;">
<div class="col">
<div class="li"><strong>Immediate response to Salesforce</strong>: validation failures return specific, per-field errors so DFA's side can log and surface them.</div>
<div class="li"><strong>Exceptions console in Trackon</strong>: any contract that arrives but cannot be created cleanly (e.g. a blocked counterparty, missing reference value) is queued on a Trackon screen for a user to resolve and re-process in place.</div>
</div>
<div class="col">
<div class="li"><strong>Safe retries</strong>: the Salesforce reference ID makes re-sends idempotent: a retried contract is never created twice.</div>
<div class="li"><strong>Monitoring</strong>: integration traffic and failures are monitored on the Trackon side as part of the support arrangement.</div>
</div>
</div>

<div class="caption">The principle from the June proposal, unchanged: flagged for a person to resolve, never silently rejected.</div>

---

<div class="eyebrow">For clarity</div>

# Assumptions &amp; open items

<div style="margin-top: 12px;">
<div class="li"><strong>Field-mapping workbook</strong>: the Phase 2 fixed price assumes the field set per this document (14 Aug session). DFA's field-mapping workbook and functional spec, mentioned at kickoff, will be used to confirm it; material additions would be scoped separately.</div>
<div class="li"><strong>Approval flow</strong>: Option 1 or 2, confirmed with the Phase 2 acceptance; no cost impact either way.</div>
<div class="li"><strong>Salesforce side</strong>: DFA IT builds the approval trigger, the callout, picklist setup and the refresh job/button; Trackon provides the endpoints and documentation.</div>
<div class="li"><strong>Sandbox</strong>: the dedicated Salesforce sandbox for integration testing (Chad, kickoff) available at the start of the build.</div>
<div class="li"><strong>Clauses &amp; documents</strong>: clause wording, document generation and printing remain in Trackon; Salesforce selects by reference.</div>
</div>

---

<!-- _class: dark -->
<!-- _footer: '' -->

<div class="eyebrow">Next steps</div>

# From design to build

<div class="intro" style="margin-bottom: 8px;">Phase 1 is complete. Three steps take us to the December go-live:</div>

<div class="li" style="color: #dbe6ff; font-size: 0.72em;"><strong>Field-mapping workbook from DFA IT</strong>: confirms the mapping assumptions in this document before the build.</div>
<div class="li" style="color: #dbe6ff; font-size: 0.72em;"><strong>Phase 2 acceptance by 4 September</strong>: protects ~10 weeks of development plus UAT, training and contingency before December. The approval-flow choice (Option 1 or 2) comes with it.</div>
<div class="li" style="color: #dbe6ff; font-size: 0.72em;"><strong>Build starts immediately on acceptance</strong>: the API platform, credentials and sandbox path are already in place.</div>

<div style="margin-top: 34px; font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: #fff;">Trackon Software FZCO</div>
<div style="margin-top: 4px; font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: #ffffff99;">Bibeesh Rathnapal · bibeeshar@trackon.com &nbsp;·&nbsp; Murat Selim Ozturk · sozturk@trackon.com</div>
