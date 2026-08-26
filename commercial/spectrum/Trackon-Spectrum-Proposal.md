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

  .flow { display: flex; align-items: stretch; gap: 18px; margin-top: 14px; background: transparent; }
  .flow .node { flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; box-shadow: 0 2px 10px rgba(20,32,64,.05); padding: 18px 14px; text-align: center; display: flex; flex-direction: column; justify-content: center; }
  .flow .node.hi { border: 2px solid var(--a); background: linear-gradient(180deg, #506CEA0c, #ffffff 62%); }
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

  /* per-deck column layouts */
  section.t2 th:first-child, section.t2 td:first-child { width: 26%; }
  section.t2 th:last-child, section.t2 td:last-child { width: 74%; text-align: left; }
  section.t3w th:first-child, section.t3w td:first-child { width: 24%; }
  section.t3w th:nth-child(2), section.t3w td:nth-child(2) { width: 56%; }
  section.t3w th:last-child, section.t3w td:last-child { width: 20%; text-align: left; }
  section.tcmp th:first-child, section.tcmp td:first-child { width: 24%; }
  section.tcmp th:nth-child(2), section.tcmp td:nth-child(2) { width: 38%; }
  section.tcmp th:last-child, section.tcmp td:last-child { width: 38%; text-align: left; }
  section.t4 th:first-child, section.t4 td:first-child { width: 28%; }
  section.t4 th:nth-child(2), section.t4 td:nth-child(2) { width: 44%; }
  section.t4 th:nth-child(3), section.t4 td:nth-child(3) { width: 14%; text-align: right; }
  section.t4 th:last-child, section.t4 td:last-child { width: 14%; text-align: right; }
  section.t4 table { font-size: 0.54em; }
  section.t4 td, section.t4 th { padding: 8px 14px; }
  section.tprice table { font-size: 0.5em; margin-top: 4px; }
  section.tprice td, section.tprice th { padding: 6px 14px; }
  section.tprice h1 { font-size: 1.9em; }
  section.tprice .row { margin-top: 10px; gap: 16px; }
  section.tprice .card { padding: 10px 16px !important; }
  section.tprice .step-price { font-size: 32px !important; margin-top: 4px; }
  section.tprice .step-sub { margin-top: 4px; font-size: 12px; }
  section.tprice .card-body { font-size: 0.56em; line-height: 1.5; }
  section.tprice .steps-note { margin-top: 10px; }

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
  .step-sub { font-family: 'Raleway'; font-size: 13px; color: var(--label); margin-top: 8px; }
  .card.step-hi { border: 2px solid var(--a); background: linear-gradient(180deg, #506CEA0c, #ffffff 62%); }

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
footer: 'Trackon Software FZCO  ·  Spectrum DMCC  ·  Commercial Proposal · Confidential · Prepared for Spectrum DMCC'
---

<!-- INTERNAL DRAFT 2026-08-26, not sent. Built from _templates/customer-deck-marp.md. Pricing basis: Legacy rate card as used in the Newco (Yalcintas) deck, July 2026 (platform 4,593 / user 765 AED); new Africa-shops user tier 190 AED (75% off) decided for this deal; TrackonAI list USD 299/user = AED 1,098. User split 10 HO + 30 shops is an ASSUMPTION stated on the deck; totals adjust at unit rates. -->

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _footer: '' -->

<div class="kicker">Commercial Proposal · August 2026</div>

<img class="logo" src="./trackon-logo.png" />

<div class="cover-title">One System from Dubai<br/>to Every Shop in Africa</div>

<div class="rule"></div>

<div class="cover-sub">Head-office trading, shipping and finance on Trackon, with a mobile Point of Sale app for your shop staff on any Android or iPhone. Scope, implementation plan and pricing for 40 users, with two platform options.</div>

<div class="cover-meta" style="margin-top: 20px;">Prepared for Mr. Shilpen · Spectrum DMCC</div>
<div class="cover-meta-sub" style="margin-top: 6px;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>

---

<div class="eyebrow">Your operation</div>

# What we understood

<div class="row" style="margin-top: 14px;">
<div class="col card card-accent">
<div class="card-title">Head office, Dubai</div>
<div class="card-body">Buys the goods, arranges <strong>international shipping</strong>, and moves stock to the depot and shops in Africa. Needs full visibility: what was bought, what is on the water, what is in each shop, and what each shop earns.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Shops in Africa</div>
<div class="card-body">Staff work on <strong>mobile phones only</strong>. Each shop must <strong>accept incoming goods</strong>, <strong>sell</strong>, and <strong>record its own expenses</strong>, with as few taps as possible. Adding their own customers comes later.</div>
</div>
<div class="col card card-accent">
<div class="card-title">40 users, one system</div>
<div class="card-body">A small head-office team on the full system and a larger number of shop users on a focused app. The shop users should not carry the cost of a full ERP seat, and in this proposal they do not.</div>
</div>
</div>

<div class="caption">In our last meeting we showed you shop profitability and the new mobile POS screens. This document turns that into a concrete scope and price.</div>

---

<div class="eyebrow">The solution</div>

# From purchase to shop shelf to profit

<div class="flow-label first">Head office · Trackon</div>
<div class="flow">
<div class="node"><div class="nt">Purchase</div><div class="ns">supplier, contract, price</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">International shipment</div><div class="ns">containers, documents, ETA</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Depot in Africa</div><div class="ns">landed cost per item</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Transfer to shops</div><div class="ns">stock moves branch to branch</div></div>
</div>

<div class="flow-label">Shops · mobile POS app</div>
<div class="flow">
<div class="node hi"><div class="nt">Receive stock</div><div class="ns">one tap to accept the transfer</div></div>
<div class="arrow">→</div>
<div class="node hi"><div class="nt">Sell</div><div class="ns">product, quantity, price, receipt</div></div>
<div class="arrow">→</div>
<div class="node hi"><div class="nt">Record expenses</div><div class="ns">rent, transport, utilities, wages</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Shop profitability</div><div class="ns">sales, cost of goods, expenses, per shop</div></div>
</div>

<div class="caption">Every shop transaction lands in the same books the head office runs on. No re-keying, no spreadsheets, profitability per shop and per product as shown in the demo.</div>

---

<!-- _class: t2 -->

<div class="eyebrow">Head office</div>

# What the head office runs on Trackon

| Area | Coverage |
|---|---|
| **Purchasing** | Supplier contracts, purchase orders, prices, counterparties, payment terms |
| **International shipping** | Shipments and containers, shipping documents, ETAs, arrival at the depot |
| **Landed cost** | Freight, clearing, transport and other costs allocated to the goods, so every item carries its true cost into the shops |
| **Stock and transfers** | Depot and shop warehouses, transfers between branches, stock in transit, stock on hand per shop |
| **Finance** | Sales and purchase invoices, shop expenses, payments, ledgers, multi-currency (AED, USD, local currencies) |
| **Reporting** | Sales per shop, stock per shop, expenses per shop, profitability per shop and per product, plus the standard report pack |

<div class="caption">Every shop is a branch with its own warehouse and its own books. The head office sees all of them; each shop sees only its own.</div>

---

<div class="eyebrow">Shops</div>

# The mobile POS app for your shop staff

<div class="row" style="margin-top: 10px;">
<div class="col card">
<div class="card-title">Ready today <span class="tag tag-live">Demonstrated</span></div>
<div class="li li-done"><strong>Sell</strong>: pick the product, quantity and price, confirm, receipt on screen</div>
<div class="li li-done"><strong>Receive Stock</strong>: incoming transfers from the depot, accepted with one tap</div>
<div class="li li-done"><strong>Inventory</strong> and <strong>Product Search</strong>: what the shop has on hand</div>
<div class="li li-done"><strong>Sales</strong> and <strong>Today</strong>: the shop's own sales history and the day so far</div>
</div>
<div class="col card">
<div class="card-title">Added for Spectrum <span class="tag">Implementation</span></div>
<div class="li"><strong>Record Expenses</strong>: shop staff record rent, transport, utilities and other costs against their shop; head office approves and the expense flows into the shop's profitability</div>
<div class="li">Your logo and receipt layout, your product list, your currencies</div>
<div class="li li-no"><strong>Later</strong>: shops add their own customers and sell on account. Kept out of this phase deliberately; added when you ask for it.</div>
</div>
</div>

<div class="row" style="margin-top: 16px;">
<div class="col card" style="padding: 16px 24px;">
<div class="card-body"><strong>Any Android or iPhone.</strong> The app installs from a link to the phone's home screen, opens full screen, and runs on mobile data. No app store, no device management. Each user sees only the shop they are assigned to.</div>
</div>
</div>

---

<!-- _class: t3w -->

<div class="eyebrow">Implementation</div>

# The work we will do

| Workstream | What we do | Input from Spectrum |
|---|---|---|
| **Discovery and process design** | Requirements workshops with head office and shop managers; how goods, money and information flow today; the target process written down and agreed before configuration starts | Workshop time, sample documents |
| **Company and shop setup** | Dubai head office, the depot and every shop as a branch with its own warehouse; currencies, tax, chart of accounts, users and roles | List of shops and staff |
| **Master data and opening balances** | Products, suppliers, customers, opening stock per shop and opening balances loaded from your Excel files | Data in our Excel templates |
| **Head-office processes** | Purchase contracts, international shipments, landed cost, transfers to the depot and shops, configured to how you work | Two working sessions |
| **Shop app rollout** | POS app configured per shop; the new Record Expenses screen built and approved; your branding; home-screen install on staff phones | Approval of the expenses screen |
| **Reports** | Standard report pack with your header and footer; sales, stock, expenses and profitability per shop and per product | Sign-off |
| **Testing, training and go-live** | Four weeks of testing with your team on real data; head-office training online; short sessions for shop staff with one-page guides; go-live support and hypercare | Testers, availability of staff |

---

<div class="eyebrow">Timeline</div>

# Live in three months

<div class="tl">
<div class="seg hi"><div class="sd">Week 1</div><div class="st">Kick-off</div><div class="ss">your environment provisioned · discovery workshops start</div></div>
<div class="seg"><div class="sd">Weeks 2 to 6</div><div class="st">Build and configure</div><div class="ss">processes, master data, opening stock, shop app, Record Expenses screen, reports · <strong>system ready end of week 6</strong></div></div>
<div class="seg"><div class="sd">Weeks 7 to 10</div><div class="st">Testing and training</div><div class="ss">your team tests on real data · corrections · head office and shop staff trained</div></div>
<div class="seg"><div class="sd">Weeks 11 to 13</div><div class="st">Go-live</div><div class="ss">first live sales · hypercare through the end of the period</div></div>
</div>

<div class="caption">Six weeks to a ready system, four weeks of testing with your people, then go-live: about three months end to end. The mobile app already exists on your environment, so the plan is driven by requirements, data readiness and staff availability, not development.</div>

---

<!-- _class: t4 -->

<div class="eyebrow">Implementation</div>

# What the implementation fee covers

| Item | Detail | Option A (AED) | Option B (AED) |
|---|---|---|---|
| Discovery and process design | Workshops, current and target process, agreed design | **10,000** | **10,000** |
| Company and shop setup, data load | Branches, warehouses, users, currencies, accounts; master data and opening stock from Excel | **10,000** | **10,000** |
| Shop app rollout | Per-shop configuration, branding, Record Expenses screen, phone installation | **12,000** | **32,000** |
| Reports | Standard pack with your header and footer; sales, stock, expenses and profitability per shop | **5,000** | **5,000** |
| Testing, training and go-live | Four weeks of testing support, training for 40 users, go-live and hypercare | **8,000** | **8,000** |
| **Total, one-time** | | **45,000** | **65,000** |

<div class="caption">Option B is higher because the shop screens are built on TrackonAI for you; on Option A they already exist. Invoiced on acceptance. Prices in AED, exclusive of 5% VAT.</div>

---

<!-- _class: tprice -->

<div class="eyebrow">Option A · Recommended</div>

# Trackon with the mobile POS app

| Item | Detail | Monthly (AED) |
|---|---|---|
| Trackon platform, shared cloud | Database, application servers, daily backups, monitoring, upgrades | **4,593** |
| Head-office users, 10 × 765 | Full system: purchasing, shipping, stock, finance, reports | **7,650** |
| Africa shop users, 30 × 190 | Mobile POS app: sell, receive stock, expenses, inventory, sales | **5,700** |
| Mobile POS app for every shop | Already built and demonstrated | *Included* |
| Record Expenses screen | Built during implementation | *Included* |
| Profitability per shop and product | Standard reports with your header and footer | *Included* |
| **Total for 40 users** | | **17,943** |

<div class="row">
<div class="col card step-hi card-center">
<div class="step-tag hi">Monthly · from environment ready</div>
<div class="step-price hi">AED 17,943</div>
<div class="step-sub">months 1 to 3 at 50%: AED 8,972 per month</div>
</div>
<div class="col card card-center">
<div class="step-tag">One-time · implementation</div>
<div class="step-price">AED 45,000</div>
<div class="step-sub">all workstreams, incl. the expenses screen</div>
</div>
<div class="col card" style="display:flex; flex-direction:column; justify-content:center;">
<div class="card-body"><strong>Africa shops rate: AED 190 per user, 75% below the standard AED 765.</strong> Shop staff need one focused app, not a full ERP seat. Add users any time at the same rates.</div>
</div>
</div>

<div class="steps-note">Implementation invoiced on acceptance. Subscription monthly in advance from the week your environment is provisioned: 50% for months 1 to 3, full rate from month 4. Prices in AED, exclusive of 5% VAT. Dedicated server available on request.</div>

---

<div class="eyebrow">Option B · The newer platform</div>

# TrackonAI, our next-generation product

<div class="intro">TrackonAI is the platform we launched after Trackon: cloud-native, built for smaller and mid-size trading operations, with an AI assistant you can ask questions about your own data and reports you design yourself. It is the newer product, live with its first customers since 2025, and we can provide it to Spectrum as well.</div>

<div class="row" style="margin-top: 16px;">
<div class="col card">
<div class="card-title">What you would gain</div>
<div class="li">Modern interface, no server fee, same profitability logic: purchase price, freight, landed cost and shop expenses traced to every sale</div>
<div class="li"><strong>AI assistant</strong>: ask "which shop sold the most this week" and get the answer from your live data</div>
<div class="li"><strong>Self-service reports</strong>: design and change your own reports and document templates</div>
<div class="li">Approval workflows you define, WhatsApp approvals, sanctions and vessel tracking available as add-ons</div>
</div>
<div class="col card">
<div class="card-title">What is different for Spectrum</div>
<div class="li">The shop screens (sell, receive, expenses) exist today on Trackon. On TrackonAI they are <strong>built for you during implementation</strong> on its mobile-friendly interface</div>
<div class="li">Go-live in <strong>four to five months</strong> instead of three</div>
<div class="li">A younger product: fewer years in production, a faster release cycle</div>
<div class="li">A migration path from Trackon to TrackonAI exists, so choosing Option A today does not close this door</div>
</div>
</div>

---

<!-- _class: tprice -->

<div class="eyebrow">Option B · pricing</div>

# TrackonAI for 40 users

| Item | Detail | Monthly (AED) |
|---|---|---|
| TrackonAI platform | Cloud-native, no server fee; AI assistant with a monthly usage allowance | *Included* |
| Head-office users, 10 × 1,098 | Full platform: purchasing, shipping, stock, finance, self-service reports | **10,980** |
| Africa shop users, 30 × 190 | Mobile shop screens built on TrackonAI, same Africa shops rate | **5,700** |
| Profitability per shop and product | Automatic cost tracing, built in | *Included* |
| **Total for 40 users** | | **16,680** |

<div class="row">
<div class="col card card-center">
<div class="step-tag">Monthly · from environment ready</div>
<div class="step-price">AED 16,680</div>
<div class="step-sub">months 1 to 3 at 50%: AED 8,340 per month</div>
</div>
<div class="col card card-center">
<div class="step-tag">One-time · implementation</div>
<div class="step-price">AED 65,000</div>
<div class="step-sub">incl. building the shop screens on TrackonAI</div>
</div>
<div class="col card" style="display:flex; flex-direction:column; justify-content:center;">
<div class="card-body">Lower monthly, higher one-time, longer to go live. <strong>Our recommendation is Option A</strong>: the shop app is ready, you have seen it, and your shops can be selling on it within three months.</div>
</div>
</div>

<div class="steps-note">Implementation invoiced on acceptance. Subscription monthly in advance from the week your environment is provisioned: 50% for months 1 to 3, full rate from month 4. Prices in AED, exclusive of 5% VAT.</div>

---

<!-- _class: tcmp -->

<div class="eyebrow">Side by side</div>

# Choosing between the two

| | Option A · Trackon | Option B · TrackonAI |
|---|---|---|
| **Maturity** | In production with trading houses for over ten years | Newer platform, live with first customers since 2025 |
| **Shop app** | Ready and demonstrated on your environment | Built for you during implementation |
| **Time to go-live** | About 3 months | 4 to 5 months |
| **Reports** | Standard pack, built by Trackon to your needs | Self-service designer plus AI assistant |
| **Monthly, 40 users** | AED 17,943 | AED 16,680 |
| **One-time** | AED 45,000 | AED 65,000 |
| **Best for** | Selling from your shops before year end | A longer runway and a preference for the newest platform |

<div class="caption">Both options use the same Africa shops rate of AED 190 per shop user. Confirm your choice with your acceptance.</div>

---

<div class="eyebrow">Hosting, data and connectivity</div>

# Where your system runs and what we are responsible for

<div class="row" style="margin-top: 10px;">
<div class="col card card-accent">
<div class="card-title">Hosting</div>
<div class="card-body">Your system runs on <strong>Oracle Cloud Infrastructure in the United States</strong>, on Trackon's managed estate, in your own isolated database. Head office and shops connect over encrypted HTTPS. Hosting in the <strong>UAE (Dubai region)</strong> is available under the dedicated-server option.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Backups and your data</div>
<div class="card-body"><strong>Nightly encrypted backups</strong> (AES-256) are copied to an independent cloud provider in the United States and kept for 35 days, with a monthly locked archive retained for over a year. Restores are tested every quarter. Your data is your property, with export rights at any time.</div>
</div>
<div class="col card card-accent">
<div class="card-title">Connectivity at the shops</div>
<div class="card-body">Each shop connects through its <strong>local mobile network operator</strong> on the staff phones' data plans. Trackon is responsible for the system being available; <strong>network coverage, outages and data costs at the shops are between Spectrum and its operators</strong>. The app uses short, one-step submissions so it copes with weak signal, but it needs a connection to work.</div>
</div>
</div>

<div class="caption">Head office uses its normal internet connection. Working without connectivity is possible as a separate, scoped piece of work.</div>

---

<div class="eyebrow">For clarity</div>

# The prices assume

<div style="margin-top: 8px;">
<div class="li"><strong>10 head-office users and 30 shop users.</strong> If your split differs, the total adjusts at the unit rates shown; nothing else changes.</div>
<div class="li">Each shop is one branch with one warehouse. Shop phones have mobile data; the app works online. Working without connectivity is possible as a separate, scoped piece of work.</div>
<div class="li">Spectrum provides master data and opening stock in our Excel templates; Trackon loads and validates them.</div>
<div class="li">Reports are the standard pack with your header and footer plus the shop reports listed. Bespoke documents and reports beyond that are quoted separately.</div>
<div class="li">Support: ticketing portal and email, Monday to Friday 09:00 to 18:00 Dubai time; response within 4 business hours for system-down issues.</div>
<div class="li">Contract: Trackon SaaS agreement, 12-month initial term, annual renewal. Your data is yours, with export rights. UAE law.</div>
<div class="li"><strong>Subscription starts the week your environment is provisioned</strong> (week 1), at 50% for months 1 to 3, full rate from month 4. Implementation is invoiced on acceptance.</div>
<div class="li">Proposal valid to <strong>25 September 2026</strong>; the three-month timeline holds for acceptance within that window.</div>
</div>

---

<!-- _class: dark -->
<!-- _footer: '' -->

<div class="eyebrow">Next steps</div>

# Let's put your shops on it

<div class="snum"><div class="badge">1</div><div class="scontent">Accept by <strong>25 September 2026</strong> and confirm Option A or B, plus your head-office and shop user counts.</div></div>
<div class="snum"><div class="badge">2</div><div class="scontent">We issue the agreement and the implementation invoice, provision your environment, and send the Excel templates for your shops, products and stock.</div></div>
<div class="snum"><div class="badge">3</div><div class="scontent">Kick-off the following week: system ready in six weeks, four weeks of testing, and with Option A your shops are selling on the app <strong>within three months</strong>.</div></div>

<div style="margin-top: 38px; font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: #fff;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>
<div style="margin-top: 4px; font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: #ffffff99;">sozturk@trackon.com</div>
