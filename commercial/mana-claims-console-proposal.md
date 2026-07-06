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
footer: 'Trackon Software FZCO  ·  Claims Console  ·  Confidential · Prepared for Mana'
---

<!-- _class: lead -->
<!-- _paginate: false -->
<!-- _footer: '' -->

<div class="kicker">Implementation Proposal · July 2026</div>

![h:110](./trackon-logo.png)

<div class="cover-title">Claims Console<br/>for Mana</div>

<div class="rule"></div>

<div class="cover-sub">A new Claims Console in Trackon, working like the Logistics Console your team already knows. An Add button opens a guided wizard for claim details and supporting documents, and approved claims become claim records automatically.</div>

<div class="cover-meta" style="margin-top: 20px;">Prepared for Josh Hosking · Mana</div>
<div class="cover-meta-sub" style="margin-top: 6px;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>

---

<div class="eyebrow">The objective</div>

# What we are solving

<div class="intro">Today, raising a claim depends on emails, spreadsheets and manual entry. Details arrive incomplete, supporting evidence is scattered, and someone still has to key the final claim into the system by hand.</div>

<div class="intro">The <strong>Claims Console</strong> replaces that: a new console in Trackon, sitting alongside the consoles your team already uses, such as the Logistics Console. It lists every claim with its status, and an <strong>Add</strong> button opens a guided wizard that walks the user through the claim step by step. Required details and supporting documents are collected up front; nothing can be submitted incomplete.</div>

<div class="intro">Every claim then passes through a formal <strong>approve / reject</strong> step. Only approved claims become claim records in Trackon, created automatically with no re-keying. No separate system, no new sign-in: it all lives where your team already works.</div>

<div style="margin-top: 30px;">
<span class="pill">Inside Trackon, no new system</span><span class="pill">Guided, step-by-step entry</span><span class="pill">Complete claims only</span><span class="pill">Controlled approval</span>
</div>

---

<div class="eyebrow">How it works</div>

# From first entry to a claim in Trackon

<div class="flow-label first">The claim journey</div>
<div class="flow">
<div class="node"><div class="nt">Add</div><div class="ns">opens the guided wizard from the console</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Wizard</div><div class="ns">details &amp; documents, step by step</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Review</div><div class="ns">approve or reject, with comments</div></div>
<div class="arrow">→</div>
<div class="node"><div class="nt">Claim record</div><div class="ns">created in Trackon automatically</div></div>
</div>

<div style="margin-top: 26px;">
<div class="li">The wizard validates as the user goes: mandatory fields, amounts, references and attachments are checked <strong>before</strong> submission, not after.</div>
<div class="li">Reviewers see the full claim with its evidence in one place and approve or <strong>reject with a reason</strong>; the submitter is notified either way.</div>
<div class="li">Rejected claims never become claim records. Approved claims are created through Trackon's real business rules, so what lands is always valid.</div>
</div>

---

<div class="eyebrow">The experience</div>

# Built for the people filing claims

<div class="row">
<div class="col card card-accent">
<div class="card-title">For submitters</div>
<div class="li">A wizard that asks one thing at a time, with no blank forms and no guesswork</div>
<div class="li">Upload supporting documents directly into the claim</div>
<div class="li">The console shows every claim and its status: submitted, in review, approved, rejected</div>
<div class="li">Clear rejection reasons, so a claim can be corrected and resubmitted</div>
</div>
<div class="col card card-accent">
<div class="card-title">For reviewers</div>
<div class="li">Pending claims in one console view, complete with evidence</div>
<div class="li">Approve or reject with comments in one click</div>
<div class="li">Full audit trail of who filed, who decided, when and why</div>
<div class="li">Approved claims become claim records with zero manual entry</div>
</div>
</div>

<div class="caption">Claim types, required fields, evidence rules and the approval chain follow what we defined together in our working sessions.</div>

---

<div class="eyebrow">Clear boundaries</div>

# What sits where

<div class="row">
<div class="col card card-accent">
<div class="card-title">Trackon delivers</div>
<div class="li">The new Claims Console in Trackon, alongside your existing consoles</div>
<div class="li">The Add-button wizard for guided claim entry</div>
<div class="li">Approval / rejection workflow &amp; notifications</div>
<div class="li">Document upload &amp; storage with the claim</div>
<div class="li">Claim records created automatically on approval, with a full audit trail</div>
<div class="li">Testing, go-live and training</div>
</div>
<div class="col card">
<div class="card-title" style="color: #7286A6;">Mana provides</div>
<div class="li li-no">Claim types, required fields and business rules</div>
<div class="li li-no">The approval chain: who reviews, who decides</div>
<div class="li li-no">Which Trackon users submit and which approve</div>
<div class="li li-no">Sample historical claims for testing</div>
<div class="li li-no">UAT participation before go-live</div>
</div>
</div>

---

<div class="eyebrow">Your investment</div>

# Capped hours. You won't pay more.

<div class="step-intro">The design is already clear from our working sessions together, so we go straight to build. The whole engagement, including meetings, development, testing and go-live, is billed on actual time at <strong>$100/hour</strong>, capped at <strong>160 hours</strong>.</div>

<div class="row">
<div class="col card step-hi">
<div class="step-tag hi">Maximum investment</div>
<div class="card-title" style="margin-top: 8px;">This scope, delivered</div>
<div class="step-price hi">$16,000</div>
<div class="card-body" style="margin-top: 10px;">Hard cap · 160 hours · includes meetings, development, testing and go-live</div>
</div>
<div class="col card">
<div class="step-tag">Pay only for time used</div>
<div class="card-title" style="margin-top: 8px;">Actual hours billed</div>
<div class="step-price">&le; 160 h</div>
<div class="card-body" style="margin-top: 10px;">Finish in fewer hours and you are invoiced only the time spent. Take longer for any reason within this scope and the overrun is <strong>ours</strong>; the cap holds.</div>
</div>
</div>

<div class="steps-note">Prices in USD, exclusive of any applicable taxes. Once live, the Claims Console is supported like the rest of your Trackon system.</div>

---

<div class="eyebrow">Build &amp; Go-Live</div>

# Workstreams

<div class="ws">
<div class="ws-head"><div class="c1">Workstream</div><div class="c2">Scope</div></div>
<div class="ws-row"><div class="c1">Claims Console</div><div class="c2">New console in Trackon, like the Logistics Console, listing every claim with its status</div></div>
<div class="ws-row"><div class="c1">Add wizard</div><div class="c2">Guided multi-step entry dialog with live validation and document upload</div></div>
<div class="ws-row"><div class="c1">Approval workflow</div><div class="c2">Review from the console, approve / reject with comments, notifications, audit trail</div></div>
<div class="ws-row"><div class="c1">Claim creation</div><div class="c2">Approved claims become claim records in Trackon through its business rules</div></div>
<div class="ws-row"><div class="c1">Roles &amp; access</div><div class="c2">Submitter and reviewer roles for existing Trackon users</div></div>
<div class="ws-row"><div class="c1">Test &amp; go-live</div><div class="c2">End-to-end testing with real claim samples, UAT, deployment, training</div></div>
</div>

<div class="row">
<div class="col card card-accent card-center">
<div class="step-tag hi">Maximum · all workstreams</div>
<div class="step-price">$16,000</div>
</div>
<div class="col card">
<div class="card-body">Everything above is covered by the <strong>160-hour cap</strong>, with meetings, development, testing and go-live included. Actual hours are reported transparently and invoiced as spent, never beyond the cap.</div>
</div>
</div>

---

<div class="eyebrow">For clarity</div>

# Assumptions

<div style="margin-top: 18px;">
<div class="li">The scope baseline is what we defined together in our working sessions: a new <strong>Claims Console</strong> in Trackon with an Add-button wizard, an approve / reject workflow, and claim records created automatically on approval.</div>
<div class="li">The <strong>160-hour / $16,000 cap</strong> applies to this scope, including meetings, development, testing and go-live. Time is billed at $100/hour on actual hours spent, never beyond the cap.</div>
<div class="li">The console is used by <strong>existing Trackon users</strong>; Mana confirms who can submit and who approves.</div>
<div class="li">Approved claims become claim records through Trackon's business rules; everything downstream of claim creation works as it does today.</div>
<div class="li">Mana provides sample historical claims for testing and participates in UAT.</div>
<div class="li">Changes to claim types or workflow beyond this scope are quoted separately as amendments.</div>
</div>

---

<!-- _class: dark -->
<!-- _footer: '' -->

<div class="eyebrow">Next steps</div>

# Let's get started

<div class="snum"><div class="badge">1</div><div class="scontent">Confirm the go-ahead: maximum <strong>$16,000</strong>, capped at 160 hours, this scope delivered.</div></div>
<div class="snum"><div class="badge">2</div><div class="scontent">Short kickoff to lock the console layout, wizard steps and the approval chain from our working sessions.</div></div>
<div class="snum"><div class="badge">3</div><div class="scontent">We build, test with your team, and go live, with <strong>actual hours invoiced and never beyond the cap</strong>.</div></div>

<div style="margin-top: 38px; font-family: 'Outfit'; font-weight: 600; font-size: 18px; color: #fff;">Murat Selim Ozturk · CEO, Trackon Software FZCO</div>
<div style="margin-top: 4px; font-family: 'Raleway'; font-weight: 400; font-size: 15px; color: #ffffff99;">sozturk@trackon.com</div>
