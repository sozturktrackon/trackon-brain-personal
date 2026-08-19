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

  img.logo { height: 205px; width: auto; margin: 4px 0 0; }

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
  .tag-live { background: #16a34a15; color: var(--green); }

  .li { position: relative; padding-left: 22px; font-size: 0.62em; color: var(--body); margin: 11px 0; line-height: 1.45; }
  .li::before { content: ''; position: absolute; left: 0; top: 0.5em; width: 7px; height: 7px; border-radius: 50%; background: var(--a); }
  .li-no::before { background: var(--muted); }
  .li-done::before { background: var(--green); }

  .badge { width: 44px; height: 44px; border-radius: 12px; background: linear-gradient(135deg, #506CEA, #3C96EE); color: #fff; font-family: 'Outfit'; font-weight: 800; font-size: 18px; display: flex; align-items: center; justify-content: center; box-shadow: 0 6px 16px rgba(80,108,234,.32); flex: none; }

  .step-tag { font-family: 'Outfit'; font-weight: 800; font-size: 12px; letter-spacing: 0.16em; color: var(--label); text-transform: uppercase; }
  .step-tag.hi { color: var(--a); }
  .step-price { font-family: 'Outfit'; font-weight: 800; font-size: 52px; letter-spacing: -0.02em; line-height: 1; margin-top: 8px; color: var(--heading); }
  .step-price.hi { color: var(--a); }
  .card.step-hi { border: 2px solid var(--a); background: linear-gradient(180deg, #506CEA0c, #ffffff 62%); }

  .recurring { margin-top: 20px; display: flex; align-items: center; justify-content: space-between; gap: 18px; background: #FAFBFF; border: 1px dashed var(--a); border-radius: 14px; padding: 16px 26px; }
  .recurring .r-label { font-family: 'Outfit'; font-weight: 800; font-size: 11px; color: var(--a); letter-spacing: 0.16em; text-transform: uppercase; }
  .recurring .r-title { font-family: 'Outfit'; font-weight: 700; font-size: 18px; color: var(--heading); margin-top: 3px; }
  .recurring .r-sub { font-family: 'Raleway'; font-weight: 400; font-size: 13px; color: var(--label); margin-top: 4px; max-width: 760px; }
  .recurring .r-price { font-family: 'Outfit'; font-weight: 800; font-size: 25px; color: var(--heading); white-space: nowrap; }
  .steps-note { margin-top: 18px; text-align: center; font-size: 0.55em; color: var(--muted); }

  table { display: table; border-collapse: collapse; width: 100%; table-layout: fixed; font-size: 0.6em; margin-top: 10px; background: var(--card); border-radius: 14px; overflow: hidden; box-shadow: var(--shadow-sm); }
  th:first-child, td:first-child { width: 42%; }
  th:nth-child(2), td:nth-child(2) { width: 38%; }
  th:last-child, td:last-child { width: 20%; text-align: right; }
  th { font-family: 'Outfit'; font-weight: 700; text-align: left; color: #fff; background: linear-gradient(135deg, #16203A, #2a3858); text-transform: uppercase; letter-spacing: 0.07em; font-size: 0.82em; padding: 12px 16px; }
  td { padding: 11px 16px; border-bottom: 1px solid var(--border); color: var(--body); }
  tr:last-child td { border-bottom: none; }
  tr:nth-child(even) td { background: #FAFBFF; }
  td strong { color: var(--heading); font-weight: 700; }
  td em { font-style: normal; font-family: 'Outfit'; font-weight: 700; color: var(--green); }

  .tl { display: flex; gap: 14px; margin-top: 24px; }
  .tl .seg { flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 16px 14px; text-align: center; box-shadow: var(--shadow-sm); }
  .tl .seg.hi { border: 2px solid var(--a); }
  .tl .st { font-family: 'Outfit'; font-weight: 700; font-size: 15px; color: var(--heading); }
  .tl .sd { font-family: 'Outfit'; font-weight: 800; font-size: 12px; letter-spacing: 0.1em; color: var(--a); text-transform: uppercase; margin-bottom: 6px; }
  .tl .ss { font-size: 12px; color: var(--label); margin-top: 4px; line-height: 1.4; }

  section.dark { background: linear-gradient(140deg, #0E1526 0%, #1b2748 58%, #243561 100%); color: #fff; }
  section.dark h1 { color: #fff; }
  section.dark .eyebrow { color: var(--a2); }
  section.dark .intro { color: #c7d3ec; }
  section.dark strong { color: var(--a2); }
  section.dark .pill { background: #ffffff14; border-color: #ffffff33; color: #dbe6ff; }
  section.dark::after { color: #ffffff66; }

  section.lead { align-items: center; text-align: center; }
  .kicker { font-family: 'Raleway'; font-weight: 500; font-size: 15px; color: var(--label); text-transform: uppercase; letter-spacing: 0.28em; }
  .cover-title { font-family: 'Outfit'; font-weight: 800; font-size: 35px; color: var(--heading); letter-spacing: -0.02em; line-height: 1.1; }
  .rule { width: 60px; height: 4px; background: linear-gradient(90deg, #506CEA, #3C96EE); border-radius: 3px; margin: 14px auto 14px; }
  .cover-sub { font-family: 'Raleway'; font-weight: 400; font-size: 17px; color: var(--body); max-width: 760px; line-height: 1.5; }
  .cover-meta { font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: var(--heading); }
  .cover-meta-sub { font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: var(--body); }

  .snum { display: flex; align-items: flex-start; gap: 18px; margin: 18px 0; }
  .snum .scontent { font-family: 'Raleway'; font-weight: 400; font-size: 18px; color: #dbe6ff; line-height: 1.5; padding-top: 9px; }

header: ''
footer: 'Trackon Software FZCO  ·  Salesforce → Trackon Integration  ·  Phase 2 Proposal · Confidential · Prepared for DFA / Mana'
---

<!-- INTERNAL DRAFT 2026-08-19, not sent. Price DECIDED by Murat 2026-08-19: BELOW the accepted $36–48k range to accelerate approval → $34,500 fixed (itemisation sums to it). Still open: payment schedule (drafted 40/40/20), validity (drafted 4 September = acceptance deadline). -->

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _footer: '' -->

<div class="kicker">Phase 2 Proposal · August 2026</div>

<img class="logo" src="./trackon-logo.png" />

<div class="cover-title">Build &amp; Go-Live<br/>Fixed Quote</div>

<div class="rule"></div>

<div class="cover-sub">Phase 1 (Design &amp; Discovery) is complete. This is the fixed, itemised Phase 2 quote committed in the June proposal: the full integration build, tested and live before the end of December.</div>

<div class="cover-meta" style="margin-top: 20px;">Prepared for Justin Evans · DFA / Mana</div>
<div class="cover-meta-sub" style="margin-top: 6px;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>

---

<div class="eyebrow">Phase 1 · closed</div>

# Delivered ahead of schedule

<div class="row" style="margin-top: 14px;">
<div class="col">
<div class="li li-done"><strong>Live, secured API platform</strong>: delivered two days ahead of the committed date, verified end-to-end from the public internet.</div>
<div class="li li-done"><strong>Master-data feed live</strong>: customers &amp; vendors served to Salesforce with the same IDs as DFA's reference files.</div>
<div class="li li-done"><strong>Credentials with DFA</strong>: issued and handed over at the 14 August working session.</div>
</div>
<div class="col">
<div class="li li-done"><strong>Field mapping settled</strong>: ownership agreed per field; option lists delivered with Trackon IDs.</div>
<div class="li li-done"><strong>Security &amp; integration pattern confirmed</strong>: OAuth 2.0 direct Salesforce callouts, no middleware needed.</div>
<div class="li li-done"><strong>Solution Design Document</strong>: the full design, including the contract-creation API and reference-data refresh patterns.</div>
</div>
</div>

<div class="caption">Phase 1 was quoted at ≈ 3 weeks of design work. It closed with part of the integration already running in production.</div>

---

<div class="eyebrow">Phase 2 · scope</div>

# What the build delivers

| Workstream | Scope | Status |
|---|---|---|
| **Contract-creation API** | Single-payload contract creation through Trackon's business rules: validation, mapping, idempotent retries, per-field error responses | |
| **Exceptions console** | In-Trackon screen to resolve and re-process any contract that fails validation, never silently rejected | |
| **Reference-data API** | Payment terms, currencies, products, packing, ports: live endpoints so Salesforce picklists never go stale | *Included* |
| **Master-data feed** | Customers &amp; vendors: status, terms, credit limits, addresses | *Live* |
| **Integration backbone** | Monitoring, logging, coordination with DFA IT on the Salesforce connection | |
| **Test &amp; go-live** | Sandbox testing with DFA's Salesforce team, UAT support, deployment, go-live support | |

<div class="caption">Everything in the Solution Design Document: no scope gaps between the design and the quote.</div>

---

<div class="eyebrow">Your investment</div>

# The fixed quote

| Item | Detail | Price |
|---|---|---|
| Contract-creation API, the core build | validation, business rules, idempotency &amp; retry | **$21,500** |
| Exceptions console in Trackon | resolve &amp; re-process failed contracts in place | **$5,500** |
| Integration backbone &amp; monitoring | incl. coordination with DFA IT | **$3,000** |
| Sandbox testing, UAT &amp; go-live support | through December go-live | **$4,500** |
| Reference-data API (all picklist endpoints) | scheduled + on-demand refresh support | *Included* |
| Master-data feed (customers &amp; vendors) | already live | *Included* |
| API documentation &amp; training | contract API reference for DFA IT, exceptions-console training | *Included* |

<div class="row" style="margin-top: 14px;">
<div class="col card step-hi card-center" style="padding: 18px;">
<div class="step-tag hi">Phase 2 · Fixed price</div>
<div class="step-price hi" style="font-size: 44px;">$34,500</div>
</div>
<div class="col card" style="display:flex; flex-direction:column; justify-content:center;">
<div class="card-body"><strong>Below the $36–48k range</strong> indicated in the June proposal. Phase 1 ran smoothly and part of the platform is already live, so we are passing that efficiency on. Firm and itemised, fixed on the assumptions on the next pages.</div>
</div>
</div>

<div class="steps-note">Payment schedule: 40% on acceptance · 40% at UAT start · 20% at go-live. Prices in USD, exclusive of any applicable taxes.</div>

---

<div class="eyebrow">Once live</div>

# Integration support

<div class="intro">From go-live, the integration runs under a monthly support arrangement, as set out in the June proposal. This covers the day-to-day reality of an integration: user tickets, failed contracts, and error investigation.</div>

<div class="recurring">
<div><div class="r-label">Recurring · from go-live</div><div class="r-title">Integration Support</div><div class="r-sub">Ticket support for integration issues (contracts that fail to arrive in Trackon, validation and API errors), exception investigation and resolution, hosting, monitoring, and underlying platform fees. Covers routine integration support; new development and scope changes are quoted separately.</div></div>
<div class="r-price">$1,000/mo</div>
</div>

<div class="steps-note">Billed monthly from the go-live date. Prices in USD, exclusive of any applicable taxes.</div>

---

<div class="eyebrow">Timeline</div>

# Protecting the December go-live

<div class="tl">
<div class="seg hi"><div class="sd">By 4 Sep</div><div class="st">Acceptance</div><div class="ss">quote accepted · approval flow confirmed</div></div>
<div class="seg"><div class="sd">Sep → mid-Nov</div><div class="st">Build</div><div class="ss">~10 weeks · contract API, exceptions console, reference endpoints</div></div>
<div class="seg"><div class="sd">mid-Nov</div><div class="st">Sandbox &amp; UAT</div><div class="ss">joint testing with DFA's Salesforce team</div></div>
<div class="seg"><div class="sd">Dec</div><div class="st">Go-live</div><div class="ss">deployment, training, go-live support · contingency inside</div></div>
</div>

<div class="caption">The critical path is acceptance: development needs ~10 weeks, and UAT depends on DFA's sandbox and Salesforce-side build being ready in parallel. <strong>Acceptance by 4 September keeps December safe.</strong></div>

---

<div class="eyebrow">For clarity</div>

# The fixed price assumes

<div style="margin-top: 12px;">
<div class="li">The field set per the Solution Design Document (14 Aug session). DFA's field-mapping workbook confirms it; <strong>material additions beyond it are scoped and priced separately</strong>.</div>
<div class="li">DFA IT delivers the Salesforce side: approval trigger, outbound callout, field/picklist setup, the refresh job &amp; admin refresh button, sandbox, and Salesforce-side credentials.</div>
<div class="li">The dedicated Salesforce sandbox is available at build start; DFA's Salesforce build progresses in parallel so UAT can begin mid-November.</div>
<div class="li">Clauses selected by reference; clause wording, document generation and printing remain in Trackon.</div>
<div class="li">Approval flow Option 1 or 2 (per the design document): either is covered by this price.</div>
<div class="li">Quote valid to <strong>4 September 2026</strong>; the December timeline is achievable within that window.</div>
</div>

---

<!-- _class: dark -->
<!-- _footer: '' -->

<div class="eyebrow">Next steps</div>

# Let's build it

<div class="snum"><div class="badge">1</div><div class="scontent">Accept Phase 2 by <strong>4 September</strong>: <strong>$34,500 fixed</strong>. 40% on acceptance, 40% at UAT start, 20% at go-live.</div></div>
<div class="snum"><div class="badge">2</div><div class="scontent">Confirm the approval flow with your acceptance (Option 1 or 2 in the design document). Either is covered by this price.</div></div>
<div class="snum"><div class="badge">3</div><div class="scontent">Build starts immediately. Platform, credentials and design are already in place. <strong>Live in December.</strong></div></div>

<div style="margin-top: 38px; font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: #fff;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>
<div style="margin-top: 4px; font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: #ffffff99;">sozturk@trackon.com</div>
