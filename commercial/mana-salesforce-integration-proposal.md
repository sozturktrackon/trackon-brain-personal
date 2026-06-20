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
    padding: 50px 66px;
    font-size: 22px;
    line-height: 1.5;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  h1 { font-family: 'Outfit'; font-weight: 800; font-size: 2.3em; letter-spacing: -0.03em; line-height: 1.04; margin: 0 0 10px; color: var(--heading); }
  strong { color: var(--a); font-weight: 600; }

  section::after { font-family: 'Outfit'; font-size: 0.5em; color: var(--muted); }

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
  .card-center { display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; }
  .card-title { font-family: 'Outfit'; font-weight: 700; font-size: 21px; color: var(--heading); margin-bottom: 10px; }
  .card-body { font-size: 0.62em; color: var(--body); line-height: 1.65; }

  .tag { display: inline-block; font-family: 'Outfit'; font-weight: 700; font-size: 11px; letter-spacing: 0.1em; text-transform: uppercase; padding: 4px 11px; border-radius: 6px; background: #506CEA15; color: var(--a); margin-left: 6px; vertical-align: middle; }

  .li { position: relative; padding-left: 22px; font-size: 0.62em; color: var(--body); margin: 11px 0; line-height: 1.45; }
  .li::before { content: ''; position: absolute; left: 0; top: 0.5em; width: 7px; height: 7px; border-radius: 50%; background: var(--a); }
  .li-no::before { background: var(--muted); }

  .badge { width: 44px; height: 44px; border-radius: 12px; background: linear-gradient(135deg, #506CEA, #3C96EE); color: #fff; font-family: 'Outfit'; font-weight: 800; font-size: 18px; display: flex; align-items: center; justify-content: center; box-shadow: 0 6px 16px rgba(80,108,234,.32); flex: none; }

  .flow { display: flex; align-items: stretch; gap: 18px; margin-top: 14px; background: transparent; }
  .flow .node { flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; box-shadow: 0 2px 10px rgba(20,32,64,.05); padding: 18px 14px; text-align: center; display: flex; flex-direction: column; justify-content: center; }
  .flow .nt { font-family: 'Outfit'; font-weight: 700; font-size: 15px; color: var(--heading); }
  .flow .ns { font-family: 'Raleway'; font-weight: 400; font-size: 12px; color: var(--label); margin-top: 4px; }
  .flow .arrow { display: flex; align-items: center; font-family: 'Outfit'; font-weight: 800; color: var(--a); font-size: 22px; }
  .flow-label { font-family: 'Outfit'; font-weight: 700; font-size: 0.55em; color: var(--label); letter-spacing: 0.14em; text-transform: uppercase; margin-top: 22px; }
  .flow-label.first { margin-top: 8px; }

  .card.step-hi { border: 2px solid var(--a); background: linear-gradient(180deg, #506CEA0c, #ffffff 62%); }
  .step-tag { font-family: 'Outfit'; font-weight: 800; font-size: 12px; letter-spacing: 0.16em; color: var(--label); text-transform: uppercase; }
  .step-tag.hi { color: var(--a); }
  .step-price { font-family: 'Outfit'; font-weight: 800; font-size: 52px; letter-spacing: -0.02em; line-height: 1; margin-top: 8px; color: var(--heading); }
  .step-price.hi { color: var(--a); }
  .step-intro { max-width: 990px; font-size: 0.78em; color: var(--body); line-height: 1.6; margin-top: 6px; }

  .recurring { margin-top: 20px; display: flex; align-items: center; justify-content: space-between; gap: 18px; background: #FAFBFF; border: 1px dashed var(--a); border-radius: 14px; padding: 16px 26px; }
  .recurring .r-label { font-family: 'Outfit'; font-weight: 800; font-size: 11px; color: var(--a); letter-spacing: 0.16em; text-transform: uppercase; }
  .recurring .r-title { font-family: 'Outfit'; font-weight: 700; font-size: 18px; color: var(--heading); margin-top: 3px; }
  .recurring .r-sub { font-family: 'Raleway'; font-weight: 400; font-size: 13px; color: var(--label); margin-top: 4px; max-width: 760px; }
  .recurring .r-price { font-family: 'Outfit'; font-weight: 800; font-size: 25px; color: var(--heading); white-space: nowrap; }
  .steps-note { margin-top: 18px; text-align: center; font-size: 0.55em; color: var(--muted); }

  .big-num { font-family: 'Outfit'; font-weight: 800; font-size: 64px; color: var(--a); letter-spacing: -0.02em; line-height: 1; }

  table { border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 0.6em; margin-top: 10px; background: var(--card); border-radius: 14px; overflow: hidden; box-shadow: var(--shadow-sm); }
  th:first-child, td:first-child { width: 31%; }
  th { font-family: 'Outfit'; font-weight: 700; text-align: left; color: #fff; background: linear-gradient(135deg, #16203A, #2a3858); text-transform: uppercase; letter-spacing: 0.07em; font-size: 0.82em; padding: 13px 16px; }
  td { padding: 12px 16px; border-bottom: 1px solid var(--border); color: var(--body); }
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

  .snum { display: flex; align-items: flex-start; gap: 18px; margin: 18px 0; }
  .snum .scontent { font-family: 'Raleway'; font-weight: 400; font-size: 18px; color: #dbe6ff; line-height: 1.5; padding-top: 9px; }

header: ''
footer: 'Trackon Software FZCO  ·  Salesforce → Trackon Integration  ·  Confidential · Prepared for DFA / Mana'
---

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _footer: '' -->

<div class="kicker">Implementation Proposal · June 2026</div>

<img src="./trackon-logo.png" style="height: 40px; margin: 6px 0 2px;" />

<div class="cover-title">Salesforce → Trackon<br/>Contract Integration</div>

<div class="rule"></div>

<div class="cover-sub">Approved upstream Purchase / Sales contracts flow automatically from Salesforce into Trackon, with master data kept current from Trackon back to Salesforce.</div>

<div class="cover-meta" style="margin-top: 20px;">Prepared for Justin Evans · DFA / Mana</div>
<div class="cover-meta-sub" style="margin-top: 6px;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>

---

<div class="eyebrow">The objective</div>

# What we are solving

<div class="intro">Mana is adopting <strong>Salesforce</strong> as the front end for all upstream Purchase and Sales contracts. Once a contract is approved in Salesforce, it should arrive in <strong>Trackon</strong> automatically, created in approved status, with no re-keying.</div>

<div class="intro">From that point, Trackon remains the <strong>system of record</strong> for the contract and everything downstream, exactly as it works today.</div>

<div class="intro">In parallel, Trackon keeps Salesforce current with the master data it depends on: counterparty status, payment terms, credit limits and addresses.</div>

<div style="margin-top: 30px;">
<span class="pill">No re-keying</span><span class="pill">No duplicate systems of record</span><span class="pill">Existing Trackon process untouched</span>
</div>

---

<div class="eyebrow">Confirmed scope</div>

# The agreed model

<div class="row">
<div class="col card card-accent">
<div class="card-title">Contracts <span class="tag">Salesforce → Trackon</span></div>
<div class="card-body">Approved contracts flow <strong>one way</strong> from Salesforce into Trackon, created in approved status. After creation, all edits, <strong>amendments</strong> and <strong>cancellation / termination</strong> happen in Trackon only. Trackon is the system of record.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Master data <span class="tag">Trackon → Salesforce</span></div>
<div class="card-body">Trackon is the <strong>master</strong> for customers and vendors. It pushes account status (active / inactive), payment terms, credit limits and addresses to Salesforce so the front end stays current. Changes always start in Trackon.</div>
</div>
</div>

<div class="caption">One way in each direction. No two-way sync, no conflicting edits to reconcile. The simplest, most robust design.</div>

---

<div class="eyebrow">How it works</div>

# The integration flow

<div class="flow-label first">Contract creation</div>
<div class="flow">
<div class="node"><div class="nt">Salesforce</div><div class="ns">contract approved</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Secure API</div><div class="ns">authenticated endpoint</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Validate &amp; map</div><div class="ns">durable, retried</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Trackon</div><div class="ns">contract created, approved</div></div>
</div>

<div class="flow-label">Master data</div>
<div class="flow">
<div class="node"><div class="nt">Trackon</div><div class="ns">master record changes</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Integration layer</div><div class="ns">status · terms · credit · address</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Salesforce</div><div class="ns">kept current</div></div>
</div>

<div style="margin-top: 26px;">
<span class="pill pill-green">Exceptions screen</span> &nbsp; <span style="font-size: 0.66em; color: #45566E;">Any contract that fails validation (e.g. a blocked counterparty) is flagged in Trackon for a user to resolve in place, never silently rejected.</span>
</div>

---

<div class="eyebrow">Clear boundaries</div>

# What sits where

<div class="row">
<div class="col card card-accent">
<div class="card-title">Trackon delivers</div>
<div class="li">Secure API on the Trackon side</div>
<div class="li">Inbound contract creation logic</div>
<div class="li">Outbound master-data feed</div>
<div class="li">Exceptions / validation screen</div>
<div class="li">Integration backbone &amp; monitoring</div>
<div class="li">Testing, go-live and support</div>
</div>
<div class="col card">
<div class="card-title" style="color: #7286A6;">DFA IT delivers</div>
<div class="li li-no">Salesforce platform &amp; licensing</div>
<div class="li li-no">The approval trigger in Salesforce</div>
<div class="li li-no">Outbound call to Trackon's endpoint</div>
<div class="li li-no">Salesforce field &amp; object setup</div>
<div class="li li-no">Sandbox for build &amp; testing</div>
<div class="li li-no">Salesforce-side credentials</div>
</div>
</div>

<div class="caption">Salesforce expertise stays on DFA's side, where the resources are. Trackon builds only on the Trackon side.</div>

---

<!-- _class: dark -->

<div class="eyebrow">The foundation</div>

# One piece is built once, and it lasts

<div class="intro">Trackon Legacy does not expose an API today. Before any integration can run, Trackon needs a <strong>secure API layer</strong> that creates a contract through Trackon's own business rules, not by writing raw data, which would risk invalid contracts downstream.</div>

<div class="intro">This foundation is the single largest part of the work. It is also a <strong>reusable asset</strong>: once built, it underpins not just Salesforce but any future integration Mana may want.</div>

<div style="margin-top: 30px;">
<span class="pill">Built through Trackon's real contract logic</span><span class="pill">Reusable beyond Salesforce</span><span class="pill">On Trackon's OCI cloud</span>
</div>

---

<div class="eyebrow">Your investment</div>

# A simple two-step path

<div class="step-intro">We design first, then build. You commit to a small, fixed first step; the larger build is priced firmly only after that design removes the unknowns. You never sign off a padded number.</div>

<div class="row">
<div class="col card step-hi">
<div class="step-tag hi">Step 1 · Start here</div>
<div class="card-title" style="margin-top: 8px;">Design &amp; Discovery</div>
<div class="step-price hi">$7,500</div>
<div class="card-body" style="margin-top: 10px;">Fixed price · ≈ 3 weeks · delivers a fixed Step 2 quote</div>
</div>
<div class="col card">
<div class="step-tag">Step 2 · Build &amp; go-live</div>
<div class="card-title" style="margin-top: 8px;">Full integration build</div>
<div class="step-price">$36k &ndash; $48k</div>
<div class="card-body" style="margin-top: 10px;">Indicative · fixed after Step 1</div>
</div>
</div>

<div class="recurring">
<div><div class="r-label">Once live · recurring</div><div class="r-title">Integration Support &amp; Maintenance</div><div class="r-sub">Hosting, monitoring, error handling and support, including third-party platform fees (Oracle Integration Cloud / OCI).</div></div>
<div class="r-price">from ~$1,000/mo</div>
</div>

<div class="steps-note">One-time build, indicative: ≈ $43,500 &ndash; $55,500. Salesforce licences (~35 users) are DFA's cost, excluded. Prices in USD, exclusive of any applicable taxes.</div>

---

<div class="eyebrow">Phase 1 · Design &amp; Discovery</div>

# Scope & investment

<div class="row">
<div class="col" style="flex: 1.6;">
<div class="step-tag hi" style="display: block; margin-bottom: 16px;">Deliverables</div>
<div class="li">Salesforce ↔ Trackon field-mapping specification</div>
<div class="li">Trackon API design (contract creation through business rules)</div>
<div class="li">Master-data feed design</div>
<div class="li">Contract authoring &amp; clause / printing workflow defined</div>
<div class="li">Integration pattern &amp; security confirmed with DFA IT</div>
<div class="li">Solution design document and a <strong>fixed, itemised Phase 2 quote</strong></div>
</div>
<div class="col card step-hi card-center">
<div class="step-tag hi">Fixed price</div>
<div class="big-num" style="margin-top: 8px;">$7,500</div>
<div class="step-tag" style="margin-top: 22px;">Duration</div>
<div style="font-family: 'Outfit'; font-weight: 700; font-size: 26px; color: #16203A; margin-top: 6px;">≈ 3 weeks</div>
<div style="margin-top: 18px;"><span class="pill">Delivers a fixed Phase 2 quote</span></div>
</div>
</div>

---

<div class="eyebrow">Phase 2 · Build &amp; Go-Live</div>

# Workstreams & estimate

<div class="ws">
<div class="ws-head"><div class="c1">Workstream</div><div class="c2">Scope</div></div>
<div class="ws-row"><div class="c1">Trackon API foundation</div><div class="c2">Secure API layer creating contracts through Trackon's business rules</div></div>
<div class="ws-row"><div class="c1">Inbound contracts</div><div class="c2">Receive, validate, map and create approved contracts; durability &amp; retry</div></div>
<div class="ws-row"><div class="c1">Outbound master data</div><div class="c2">Push status, payment terms, credit limits, addresses to Salesforce</div></div>
<div class="ws-row"><div class="c1">Exceptions screen</div><div class="c2">In-Trackon resolution of any contract that fails validation</div></div>
<div class="ws-row"><div class="c1">Integration backbone</div><div class="c2">Orchestration, monitoring, coordination with DFA IT on the SF connection</div></div>
<div class="ws-row"><div class="c1">Test &amp; go-live</div><div class="c2">Sandbox testing, UAT, deployment, go-live support</div></div>
</div>

<div class="row">
<div class="col card card-accent card-center">
<div class="step-tag hi">Indicative estimate</div>
<div class="step-price">$36k &ndash; $48k</div>
</div>
<div class="col card">
<div class="card-body">Range shown for planning. <strong>Fixed and itemised at the end of Phase 1</strong>, once field mapping and the API approach are confirmed.</div>
</div>
</div>

---

<div class="eyebrow">For clarity</div>

# Assumptions

<div style="margin-top: 18px;">
<div class="li">Salesforce <strong>pushes</strong> approved contracts to Trackon's endpoint (DFA IT builds the trigger and call).</div>
<div class="li">DFA IT provides Salesforce-side technical resources, credentials and a <strong>sandbox</strong> for build and testing.</div>
<div class="li">Salesforce captures the fields Trackon needs to create a valid contract; gaps identified in Phase 1 are closed on the Salesforce side.</div>
<div class="li">Clauses, document generation and the clause library remain in Trackon; Salesforce sends the deal terms.</div>
<div class="li">Salesforce consumes Trackon-originated counterparties only; it does not create vendors or customers locally.</div>
<div class="li">Everything downstream of contract creation in Trackon remains as it works today.</div>
<div class="li">Mana runs on Trackon's existing shared environment. If contract volume grows substantially, a dedicated server may be recommended; this would be scoped and <strong>priced separately</strong>.</div>
</div>

---

<!-- _class: dark -->
<!-- _footer: '' -->

<div class="eyebrow">Next steps</div>

# Let's get started

<div class="snum"><div class="badge">1</div><div class="scontent">Approve Phase 1 (Design &amp; Discovery): <strong>$7,500</strong>, ≈ 3 weeks.</div></div>
<div class="snum"><div class="badge">2</div><div class="scontent">Joint working session with DFA IT to confirm the Salesforce push pattern and field mapping.</div></div>
<div class="snum"><div class="badge">3</div><div class="scontent">Phase 1 delivers the design and a <strong>fixed Phase 2 quote</strong>, then we build.</div></div>

<div style="margin-top: 38px; font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: #fff;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>
<div style="margin-top: 4px; font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: #ffffff99;">sozturk@trackon.com</div>
