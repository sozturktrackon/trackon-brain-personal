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
  footer { font-family: 'Raleway'; font-size: 11px; color: var(--muted); letter-spacing: 0.02em; }
  section.dark footer { color: #ffffff55; }

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

  .flow { display: flex; align-items: stretch; gap: 18px; margin-top: 14px; background: transparent; }
  .flow .node { flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; box-shadow: 0 2px 10px rgba(20,32,64,.05); padding: 18px 14px; text-align: center; display: flex; flex-direction: column; justify-content: center; }
  .flow .nt { font-family: 'Outfit'; font-weight: 700; font-size: 15px; color: var(--heading); }
  .flow .ns { font-family: 'Raleway'; font-weight: 400; font-size: 12px; color: var(--label); margin-top: 4px; }
  .flow .arrow { display: flex; align-items: center; font-family: 'Outfit'; font-weight: 800; color: var(--a); font-size: 22px; }
  .flow-label { font-family: 'Outfit'; font-weight: 700; font-size: 0.55em; color: var(--label); letter-spacing: 0.14em; text-transform: uppercase; margin-top: 22px; }
  .flow-label.first { margin-top: 8px; }

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

  .recurring { margin-top: 20px; display: flex; align-items: center; justify-content: space-between; gap: 18px; background: #FAFBFF; border: 1px dashed var(--a); border-radius: 14px; padding: 16px 26px; }
  .recurring .r-label { font-family: 'Outfit'; font-weight: 800; font-size: 11px; color: var(--a); letter-spacing: 0.16em; text-transform: uppercase; }
  .recurring .r-title { font-family: 'Outfit'; font-weight: 700; font-size: 18px; color: var(--heading); margin-top: 3px; }
  .recurring .r-sub { font-family: 'Raleway'; font-weight: 400; font-size: 13px; color: var(--label); margin-top: 4px; max-width: 760px; }
  .recurring .r-price { font-family: 'Outfit'; font-weight: 800; font-size: 25px; color: var(--heading); white-space: nowrap; }
  .steps-note { margin-top: 18px; text-align: center; font-size: 0.55em; color: var(--muted); }

  .step-tag { font-family: 'Outfit'; font-weight: 800; font-size: 12px; letter-spacing: 0.16em; color: var(--label); text-transform: uppercase; }
  .step-tag.hi { color: var(--a); }
  .step-price { font-family: 'Outfit'; font-weight: 800; font-size: 52px; letter-spacing: -0.02em; line-height: 1; margin-top: 8px; color: var(--heading); }
  .step-price.hi { color: var(--a); }
  .card.step-hi { border: 2px solid var(--a); background: linear-gradient(180deg, #506CEA0c, #ffffff 62%); }

  .tl { display: flex; gap: 14px; margin-top: 24px; }
  .tl .seg { flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 16px 14px; text-align: center; box-shadow: var(--shadow-sm); }
  .tl .seg.hi { border: 2px solid var(--a); }
  .tl .st { font-family: 'Outfit'; font-weight: 700; font-size: 15px; color: var(--heading); }
  .tl .sd { font-family: 'Outfit'; font-weight: 800; font-size: 12px; letter-spacing: 0.1em; color: var(--a); text-transform: uppercase; margin-bottom: 6px; }
  .tl .ss { font-size: 12px; color: var(--label); margin-top: 4px; line-height: 1.4; }

  .code { font-family: 'SF Mono', Menlo, monospace; font-size: 0.56em; background: #16203A; color: #dbe6ff; border-radius: 10px; padding: 14px 20px; margin-top: 12px; line-height: 1.7; }
  .code .m { color: #6ee7a0; font-weight: 600; }
  .code .c { color: #8ea3c8; }

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
footer: 'Trackon Software FZCO · Trackon Legacy · Live Demo · Confidential'
---

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _footer: '' -->

<div class="kicker">Live Demo · August 2026</div>

<img class="logo" src="./trackon-logo.png" />

<div class="cover-title">One cargo, from contract to profit.<br/>Everything in one place.</div>

<div class="rule"></div>

<div class="cover-sub">How a ten-person trading house runs contracts, shipments, documents, invoices, cash and P&amp;L without a large back office, from the first cargo onwards.</div>

<div class="cover-meta" style="margin-top: 20px;">Prepared for Mr Ayhan Yalcintas · Mr Fatih Ziya Akdogan and team</div>
<div class="cover-meta-sub" style="margin-top: 6px;">Murat Selim Ozturk · CEO, Trackon Software FZCO · Dubai</div>

---

<div class="eyebrow">Who we are</div>

# Built by traders, for trading

<div class="row">
<div class="col card card-accent">
<div class="card-title">30 years of trading know-how</div>
<div class="card-body">Trackon was not designed by software people guessing how trading works. It was written inside a trading house, by the people who ran the trades, and refined with every cargo since.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Proven at USD 2 billion a year</div>
<div class="card-body">Developed within Hakan as the main tool to manage about USD 2 billion of trade and 5 million tonnes of sales a year, from Africa to Russia and from Canada to India.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Running today, around the clock</div>
<div class="card-body">Live at trading and processing companies in the United States, the Gulf and Turkey. Cloud hosted, web based, with a measured uptime of 99.99% across all customers.</div>
</div>
</div>

<div class="caption">Multi-branch · multi-currency · multi-language · integrated accounting, finance, warehouse and general ledger</div>

---

<div class="eyebrow">The next 60 minutes</div>

# One trade, start to finish. Then the owner's view.

<div class="row">
<div class="col card">
<div class="badge">1</div>
<div class="card-title" style="margin-top: 14px;">One cargo, live in the system</div>
<div class="card-body">Purchase contract, sale contract, shipment, documents, costs, invoices, payment. We follow a single trade through every desk. About 30 minutes.</div>
</div>
<div class="col card">
<div class="badge">2</div>
<div class="card-title" style="margin-top: 14px;">The owner's view</div>
<div class="card-body">Open positions, mark to market, profit per trade, cash, limits, who sees what. What the founders look at every morning. About 15 minutes.</div>
</div>
<div class="col card">
<div class="badge">3</div>
<div class="card-title" style="margin-top: 14px;">Your questions</div>
<div class="card-body">Anything you want opened on screen. Tell us your commodities, routes and payment terms and we will use your example, not ours. About 15 minutes.</div>
</div>
</div>

---

<div class="eyebrow">How it works</div>

# The contract is the source. Everything downstream inherits from it.

<div class="flow-label first">One trade thread</div>
<div class="flow">
<div class="node"><div class="nt">Contracts</div><div class="ns">Purchase and sale, approvals, estimated costs, e-signature</div></div>
<div class="arrow">›</div>
<div class="node"><div class="nt">Shipment</div><div class="ns">Steps, logisticians, documents, checklists, containers, trucks</div></div>
<div class="arrow">›</div>
<div class="node"><div class="nt">Costs</div><div class="ns">Accrued the day they happen, not when the invoice arrives</div></div>
<div class="arrow">›</div>
<div class="node"><div class="nt">Invoices</div><div class="ns">Per shipment or per container, bank document sets</div></div>
<div class="arrow">›</div>
<div class="node"><div class="nt">Cash</div><div class="ns">Payment requests, approvals, treasury, advances</div></div>
<div class="arrow">›</div>
<div class="node"><div class="nt">P&amp;L and GL</div><div class="ns">Profit per trade, monthly P&amp;L, general ledger, FX averaging</div></div>
</div>

<div class="intro" style="margin-top: 30px;">Nothing is typed twice. The trader enters the contract once; logistics, finance and accounting work on the same record, each from their own screen. The estimate the trader made on day one is compared against the real result on the last day, automatically.</div>

---

<div class="eyebrow">Who sees what</div>

# Four desks, one record, four different screens

<div class="row">
<div class="col card">
<div class="card-title">Trader</div>
<div class="card-body">Contracts, estimated costs, own counterparties only. Profit of each own trade. Open positions, mark to market, monthly and shipment P&amp;L. Email alerts on receipts, payments, vessels arriving.</div>
</div>
<div class="col card">
<div class="card-title">Logistics</div>
<div class="card-body">Shipment steps in sequence or parallel, mandatory or optional. Expenses, documents and checklists per step. In-transit warehouse for cargo on water. Warehouse acceptance on iPad.</div>
</div>
<div class="col card">
<div class="card-title">Finance</div>
<div class="card-body">Mostly control and approval. Payment requests, advances, bank document submissions. Origination FX averaging per vendor. Accruals posted to GL monthly.</div>
</div>
<div class="col card">
<div class="card-title">Owner</div>
<div class="card-body">Everything. Dashboards, limits per customer and vendor (open account, CAD, LC), blacklists, approval flows per department, prices hidden where needed, full audit trail.</div>
</div>
</div>

<div class="caption">Two traders on the same desk do not see each other's customers or vendors unless you decide they should.</div>

---

<div class="eyebrow">What you saw</div>

# Six things that protect a trading house

<div class="row">
<div class="col">
<div class="li"><strong>No double entry.</strong> One contract feeds shipment, invoice, payment and ledger. Fewer people do more, with fewer mistakes.</div>
<div class="li"><strong>Profit known at any moment.</strong> Every cost is attached to its trade the day it happens, so the trade's result is never a surprise at month end.</div>
<div class="li"><strong>Costs accrued before invoices arrive.</strong> Late freight and truck invoices do not distort your monthly P&amp;L.</div>
</div>
<div class="col">
<div class="li"><strong>Documents and bank sets built in.</strong> Checklists, generated documents, submissions to the bank, all on the shipment record.</div>
<div class="li"><strong>Risk controls before the mistake.</strong> Limits per counterparty and payment term, blacklists, approval flows, hidden prices.</div>
<div class="li"><strong>Nothing depends on one person.</strong> Every action is recorded and visible. A trader leaving, a laptop lost, an unfortunate event: the business keeps running.</div>
</div>
</div>

---

<div class="eyebrow">Why day one</div>

# A new company has an advantage: nothing to unlearn

<div class="row">
<div class="col card card-accent">
<div class="card-title">Process designed in from the first cargo</div>
<div class="card-body">No spreadsheets to migrate, no habits to break. Approval flows, cost estimates and document checklists are how the team works from the first day.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Startup package</div>
<div class="card-body">Company and product setup, business process setup, standard report pack with your header, training for your users. You start clean, so you start fast.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Grows with you</div>
<div class="card-body">Add branches, currencies, languages and users as volume grows. Dashboards, AI assistant access to your own reports, and TrackonAI logistics modules when you need them.</div>
</div>
</div>

<div style="margin-top: 26px;">
<span class="pill">Cloud hosted</span><span class="pill">Web based</span><span class="pill">iPad warehouse app</span><span class="pill">1C and Logo ERP integration</span><span class="pill">Multi-branch</span><span class="pill">Multi-currency</span><span class="pill">Multi-language</span>
</div>

---

<!-- _class: dark -->
<!-- _footer: '' -->

<div class="eyebrow">Next steps</div>

# From this demo to your first cargo in the system

<div class="snum"><div class="badge">1</div><div class="scontent">Sign the agreement with Trackon Software FZCO: order form and service agreement, agreed with Mr Yalcintas and Mr Akdogan.</div></div>
<div class="snum"><div class="badge">2</div><div class="scontent">Implementation starts on your staging environment: company and branches, products, counterparties, approval flows, document and cost templates, report pack with your header.</div></div>
<div class="snum"><div class="badge">3</div><div class="scontent">Training for your users on staging, acceptance, then production and your first live cargo in the system.</div></div>

<div style="margin-top: 38px; font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: #fff;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>
<div style="margin-top: 4px; font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: #ffffff99;">sozturk@trackonsoftware.com</div>
