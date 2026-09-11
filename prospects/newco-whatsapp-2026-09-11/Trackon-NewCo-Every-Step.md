---
marp: true
theme: trackon-portrait
size: portrait
paginate: false
style: |
  @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@500;600;700;800&family=Raleway:wght@400;500;600&display=swap');
  :root { --a: #506CEA; --a2: #3C96EE; --bg: #F6F8FE; --card: #ffffff; --border: #E6EBF5; --heading: #16203A; --body: #45566E; --label: #7286A6; --muted: #9AA8C2; --red: #ef4444; --green: #16a34a; }
  section { background: radial-gradient(900px 500px at 90% -10%, #E7EEFF 0%, rgba(231,238,255,0) 60%), var(--bg); color: var(--heading); font-family: 'Raleway', sans-serif; font-weight: 400; font-size: 30px; line-height: 1.5; padding: 84px 80px 90px; display: flex; flex-direction: column; justify-content: flex-start; }
  section.dark { background: linear-gradient(150deg, #0E1526 0%, #1b2748 60%, #243561 100%); color: #fff; }
  section.dark .eyebrow { color: var(--a2); } section.dark h1 { color: #fff; } section.dark .body { color: #c7d3ec; }
  h1 { font-family: 'Outfit'; font-weight: 800; font-size: 62px; letter-spacing: -0.03em; line-height: 1.06; margin: 0 0 30px; color: var(--heading); }
  .eyebrow { font-family: 'Outfit'; font-weight: 700; font-size: 20px; color: var(--a); letter-spacing: 0.22em; text-transform: uppercase; margin-bottom: 22px; }
  .body { font-size: 30px; color: var(--body); line-height: 1.55; }
  .body + .body { margin-top: 22px; }
  strong { color: var(--a); font-weight: 600; }
  .card { background: var(--card); border: 1px solid var(--border); border-radius: 22px; padding: 30px 34px; box-shadow: 0 10px 30px rgba(20,32,64,.08); margin-top: 22px; }
  .card-label { font-family: 'Outfit'; font-weight: 700; font-size: 18px; color: var(--label); letter-spacing: 0.18em; text-transform: uppercase; }
  .card-text { font-size: 29px; color: var(--body); line-height: 1.5; margin-top: 8px; }
  .accent-red { border-left: 6px solid var(--red); } .accent-blue { border-left: 6px solid var(--a); } .accent-y { border-left: 6px solid #f5a623; }
  .step { background: var(--card); border: 1px solid var(--border); border-radius: 22px; padding: 34px 38px; box-shadow: 0 12px 34px rgba(20,32,64,.10); margin: 10px 0 30px; }
  .step-head { display: flex; justify-content: space-between; align-items: center; }
  .step-id { font-family: 'Outfit'; font-weight: 800; font-size: 19px; color: var(--a); letter-spacing: 0.16em; }
  .step-done { background: #16a34a18; color: var(--green); font-family: 'Outfit'; font-weight: 700; font-size: 17px; letter-spacing: 0.14em; padding: 6px 16px; border-radius: 8px; }
  .step-title { font-family: 'Outfit'; font-weight: 700; font-size: 38px; color: var(--heading); margin-top: 12px; }
  .step-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px 28px; margin-top: 24px; }
  .k { font-family: 'Outfit'; font-weight: 700; font-size: 16px; color: var(--label); letter-spacing: 0.16em; text-transform: uppercase; }
  .v { font-size: 26px; color: var(--heading); font-weight: 500; margin-top: 2px; }
  .li { position: relative; padding-left: 40px; font-size: 29px; color: var(--body); line-height: 1.45; margin: 18px 0; }
  .li::before { content: ''; position: absolute; left: 6px; top: 0.55em; width: 12px; height: 12px; border-radius: 50%; background: var(--a); }
  .num { display: flex; gap: 24px; align-items: flex-start; margin: 26px 0; }
  .badge { width: 58px; height: 58px; border-radius: 16px; background: linear-gradient(135deg, #506CEA, #3C96EE); color: #fff; font-family: 'Outfit'; font-weight: 800; font-size: 24px; display: flex; align-items: center; justify-content: center; flex: none; box-shadow: 0 8px 18px rgba(80,108,234,.35); }
  .num .t { font-size: 29px; line-height: 1.45; padding-top: 8px; }
  section.dark .num .t { color: #e3eaf8; }
  .slogan { font-family: 'Outfit'; font-weight: 800; font-size: 44px; letter-spacing: -0.02em; margin-top: 34px; color: var(--heading); }
  section.dark .slogan { color: #fff; }
  .next { margin-top: 30px; background: rgba(255,255,255,0.07); border: 1px solid rgba(255,255,255,0.18); border-radius: 18px; padding: 26px 30px; font-size: 27px; color: #fff; line-height: 1.5; }
  .next .k { color: var(--a2); margin-bottom: 8px; }
  .footer { margin-top: auto; font-size: 20px; color: var(--muted); }
  section.dark .footer { color: #ffffff88; }
  section.lead { justify-content: center; align-items: center; text-align: center; }
  img.logo { height: 190px; width: auto; }
  .kicker { font-family: 'Raleway'; font-weight: 600; font-size: 20px; color: var(--label); text-transform: uppercase; letter-spacing: 0.3em; margin-bottom: 34px; }
  .cover-title { font-family: 'Outfit'; font-weight: 800; font-size: 60px; color: var(--heading); letter-spacing: -0.03em; line-height: 1.08; margin-top: 30px; }
  .rule { width: 80px; height: 5px; background: linear-gradient(90deg, #506CEA, #3C96EE); border-radius: 3px; margin: 30px auto; }
  .cover-sub { font-size: 29px; color: var(--body); line-height: 1.55; max-width: 860px; }
  .cover-for { font-family: 'Outfit'; font-weight: 600; font-size: 25px; color: var(--heading); margin-top: 40px; }
  .cover-from { font-size: 21px; color: var(--body); margin-top: 8px; }
---
<!-- _class: lead -->

<div class="kicker">Five pages · September 2026</div>

<img class="logo" src="./trackon-logo.png" />

<div class="cover-title">Every step has<br/>a name on it.</div>

<div class="rule"></div>

<div class="cover-sub">Five pages you can read on your phone. Where a trading house actually loses money, why the questions your team asked in the demo are the right ones, and what happens next.</div>

<div class="cover-for">Prepared for Mr Ayhan Yalcintas · Mr Fatih Ziya Akdogan and team</div>
<div class="cover-from">Murat Selim Ozturk · CEO, Trackon Software FZCO · Dubai</div>

---

<div class="eyebrow">1 · Where Trackon began</div>

# A logistics floor, a spreadsheet, and nobody's name

<div class="body">The logistics department of a grain trading house ran every cargo from Excel. Millions of tonnes a year. Vessels, documents, trucks, banks.</div>

<div class="card accent-y"><div class="card-label">The work</div><div class="card-text">Tasks had no order. Two people did the same job. Nobody did the next one.</div></div>

<div class="card accent-red"><div class="card-label">The moment</div><div class="card-text">When a cargo went wrong, every explanation ended the same way: <strong style="color: var(--red);">"It was not me."</strong> Nobody accepted an error, so nobody could prevent the next one.</div></div>

<div class="card accent-blue"><div class="card-label">What we did</div><div class="card-text">We did not start by writing software. We sat on that floor and watched how a cargo really moved. The flow was already there. Nobody had written it down. We wrote it down as steps and gave every step a name.</div></div>

<div class="footer">Thirty years and five million tonnes a year later, every screen in Trackon still runs on that flow.</div>

---

<div class="eyebrow">2 · The idea</div>

# A step is a task with one owner, one deadline, one record

<div class="step">
  <div class="step-head"><span class="step-id">STEP 05 · LOGISTICS</span><span class="step-done">DONE</span></div>
  <div class="step-title">Shipping documents to bank</div>
  <div class="step-grid">
    <div><div class="k">Owner</div><div class="v">Documents specialist</div></div>
    <div><div class="k">Due</div><div class="v">B/L date + 5 days</div></div>
    <div><div class="k">Completed</div><div class="v">by name, date, time</div></div>
    <div><div class="k">Attached</div><div class="v">B/L · invoice · COA · courier cost</div></div>
  </div>
</div>

<div class="li"><strong>Configured per department.</strong> Logistics, execution and finance each define their own steps: in sequence or in parallel, mandatory or optional. Your flow, not ours.</div>
<div class="li"><strong>People organised by profession.</strong> Document steps go to the documents specialist, vessel steps to chartering, payment steps to treasury. Not to whoever is free.</div>
<div class="li"><strong>The record is the accountability.</strong> Who did what, when, with which document and at what cost sits on the step. A cost entered on a step lands on that cargo's profit the same day, not at month end.</div>

<div class="footer">Contracts, shipments, documents, invoices, cash and P&amp;L sit on this one spine. Nothing is typed twice.</div>

---

<div class="eyebrow">3 · What your team asked on 29 August</div>

# You already found the steps that matter

<div class="body">Ten people, multimillion-dollar cargoes, and numbers that must be true in front of a bank or an investor. Three questions from the demo, and where each one lives in the system.</div>

<div class="card accent-blue"><div class="card-label">Emrah · storage cost over months</div><div class="card-text">Bulk stock sitting for months carries its storage cost per lot, on the remaining quantity, refreshed as the lot is drawn down. It is a step with an owner, not a spreadsheet formula.</div></div>
<div class="card accent-blue"><div class="card-label">Fatih · claims arriving months after close</div><div class="card-text">A late claim or invoice is entered on its shipment. It adjusts that cargo's result and the month it belongs to, and the record shows who entered it and when. Your three-month grace policy sits on top.</div></div>
<div class="card accent-red"><div class="card-label">Ayhan · numbers for banks and investors</div><div class="card-text">Every trader sees only their own counterparties. The monthly P&amp;L locks. There is no second version prepared for the bank, because every number is the sum of steps someone signed.</div></div>


<div class="footer">Index price feed and the operational budgeting module are part of your implementation, as agreed on the call.</div>

---

<!-- _class: dark -->

<div class="eyebrow">4 · What you now know</div>

# Contributions

<div class="num"><div class="badge">1</div><div class="t">A trading house rarely loses money on the trade. It loses it between desks, on steps nobody owns.</div></div>
<div class="num"><div class="badge">2</div><div class="t">The flow already exists in your company. Writing it down as steps, one name on each, is the system.</div></div>
<div class="num"><div class="badge">3</div><div class="t">For a company starting from zero, this is the advantage: nothing to migrate, nothing to unlearn. Approval flows, cost estimates and document steps are how the team works from the first cargo.</div></div>

<div class="slogan">Every step has a name on it.</div>

<div class="next"><div class="k">Next step</div>Your demo account. Mehmet sends the product list and the customer and vendor names, we configure it and open the WhatsApp support group. Three to five days with your own cargo, then we sit down on the agreement.</div>

<div class="footer">Murat Selim Ozturk · sozturk@trackon.com · trackon.com</div>
