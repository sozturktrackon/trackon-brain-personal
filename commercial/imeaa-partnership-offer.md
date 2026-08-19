---
marp: true
theme: default
paginate: true
size: A4
style: |
  @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@400;500;600;700;800&family=Raleway:wght@300;400;500;600&display=swap');

  :root {
    --a: #506CEA;
    --gold: #C8923B;
    --gold-soft: #E4B96B;
    --ink: #1A2540;
    --heading: #1E2A3A;
    --body: #3B566E;
    --label: #6F8BA4;
    --muted: #94A3B8;
    --border: #E2E8F0;
    --bg: #FFFFFF;
    --bg-soft: #FAF8F4;
  }

  section {
    background: var(--bg);
    color: var(--heading);
    font-family: 'Raleway', sans-serif;
    font-weight: 400;
    padding: 30px 42px;
    line-height: 1.4;
    font-size: 10pt;
  }

  section::after {
    color: var(--muted);
    font-family: 'Outfit';
    font-size: 8pt;
  }

  .doc-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 2px solid var(--a);
    padding-bottom: 10px;
    margin-bottom: 16px;
  }
  .doc-header img.logo {
    height: 40px;
  }
  .doc-header .meta {
    text-align: right;
    font-family: 'Outfit';
    font-weight: 500;
    font-size: 8pt;
    color: var(--label);
    letter-spacing: 0.14em;
    text-transform: uppercase;
    line-height: 1.5;
  }
  .doc-header .meta strong { color: var(--ink); font-weight: 700; }

  h1.title {
    font-family: 'Outfit';
    font-weight: 800;
    font-size: 19pt;
    color: var(--ink);
    line-height: 1.1;
    letter-spacing: -0.02em;
    margin: 0 0 6px;
  }
  h1.eyebrow {
    font-family: 'Outfit';
    font-weight: 700;
    font-size: 8pt;
    color: var(--gold);
    letter-spacing: 0.26em;
    text-transform: uppercase;
    margin: 0 0 4px;
  }
  h2.section {
    font-family: 'Outfit';
    font-weight: 700;
    font-size: 11pt;
    color: #fff;
    background: var(--ink);
    padding: 4px 10px;
    border-radius: 3px;
    margin: 12px 0 8px;
    letter-spacing: 0.01em;
  }
  h3.minor {
    font-family: 'Outfit';
    font-weight: 700;
    font-size: 9.5pt;
    color: var(--a);
    margin: 8px 0 4px;
  }
  p { margin: 0 0 6px; color: var(--body); font-size: 9.5pt; line-height: 1.5; }
  p strong { color: var(--ink); font-weight: 700; }

  ul, ol { margin: 4px 0 8px; padding-left: 18px; }
  li { margin: 1px 0; color: var(--body); font-size: 9.5pt; line-height: 1.45; }
  li strong { color: var(--ink); font-weight: 700; }

  table {
    border-collapse: collapse;
    width: 100%;
    font-size: 8pt;
    margin: 6px 0;
    font-family: 'Outfit';
    font-weight: 500;
  }
  th {
    background: var(--ink);
    color: #fff;
    padding: 5px 6px;
    text-align: left;
    font-weight: 700;
    font-size: 7.5pt;
    letter-spacing: 0.03em;
    border: 1px solid var(--ink);
  }
  td {
    padding: 5px 6px;
    border: 1px solid var(--border);
    color: var(--body);
    vertical-align: top;
  }
  td strong, td b { color: var(--ink); font-weight: 700; }
  tr:nth-child(even) td { background: var(--bg-soft); }

  .highlight-box {
    background: var(--bg-soft);
    border-left: 3px solid var(--gold);
    padding: 9px 14px;
    margin: 10px 0;
    border-radius: 3px;
  }
  .highlight-box p { color: var(--ink); margin: 0; font-size: 9.5pt; line-height: 1.5; }
  .highlight-box p strong { color: var(--a); }

  footer { color: var(--label); font-family: 'Outfit'; font-size: 7.5pt; letter-spacing: 0.06em; }

footer: 'Trackon Software FZCO  ·  Dubai, UAE  ·  trackon.ai  ·  Confidential proposal to IMEAA'
---

<div class="doc-header">
  <img src="./trackonai-logo-hires.png" class="logo" />
  <div class="meta">
    Confidential Proposal<br/>
    Prepared for IMEAA<br/>
    2026
  </div>
</div>

<h1 class="eyebrow">Partner Spotlight Program · Proposal</h1>
<h1 class="title">TrackonAI for the IMEAA Ecosystem.</h1>

<p>Trackon Software FZCO proposes a Partner Spotlight Program through which IMEAA member companies gain discounted access to TrackonAI, a cloud-native CTRM purpose-built for the soft-commodities trade. In exchange, IMEAA receives a co-branded technology partner that strengthens the member-value proposition across the IGC and GAFTA ecosystem.</p>

<div class="highlight-box">
<p><strong>The ask in one line.</strong> IMEAA members get an SME-friendly grain-trade CTRM at meaningful partner discounts, paired with a co-marketing partnership that brings TrackonAI to the IMEAA ecosystem and reinforces IMEAA's position as a digital-enablement catalyst for its members.</p>
</div>

<h2 class="section">The product: IMEAA Spotlight Grain Edition</h2>

<p>A pre-configured TrackonAI tenant, ready to trade on day one. Standard TrackonAI requires customer configuration. The IMEAA Spotlight Edition ships pre-loaded with:</p>

<ul>
  <li><strong>Grain contract templates</strong> (GAFTA 48, 49, 64, 80 starter set, ready to copy and customize)</li>
  <li><strong>193 country import rulesets</strong> activated and configurable</li>
  <li><strong>WhatsApp approval workflows</strong> out of the box</li>
  <li><strong>Sanctions screening</strong> on counterparties at creation (OFAC, UN, EU, UK HMT and 130+ lists)</li>
  <li><strong>Vessel intelligence</strong> integrated in the shipment journey (port calls, ETA, ownership, flag)</li>
  <li><strong>Multi-lingual UI</strong>: EN / FR / TR / ES / PT / DE; Arabic on the roadmap</li>
  <li><strong>MCP integration</strong>: Claude and ChatGPT access to live tenant data with per-user permissions and full audit trail</li>
  <li><strong>24-hour go-live</strong> for IMEAA members</li>
</ul>

---

<div class="doc-header">
  <img src="./trackonai-logo-hires.png" class="logo" />
  <div class="meta">
    <strong>Pricing Bouquet</strong><br/>
    Subscription matrix
  </div>
</div>

<h2 class="section">Pricing — Subscription Bouquet</h2>

<table>
<thead>
<tr>
<th>Tier</th>
<th>IMEAA<br/>Founding-50</th>
<th>IMEAA<br/>Standard</th>
<th>List<br/>equivalent</th>
<th>Discount<br/>vs list</th>
<th>Users<br/>included</th>
<th>Branches</th>
<th>Shipments / mo<br/>included</th>
<th>Overage</th>
<th>AI Credits / mo</th>
<th>Document Storage</th>
<th>Workflows</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Spotlight Starter</strong></td>
<td><strong>$199 / mo</strong></td>
<td>$249 / mo</td>
<td>$447 / mo</td>
<td>55% / 44%</td>
<td>Up to 3</td>
<td>1</td>
<td>15</td>
<td>$5 / shipment</td>
<td>2,000</td>
<td>5 GB</td>
<td>Up to 5</td>
</tr>
<tr>
<td><strong>Spotlight Professional</strong></td>
<td><strong>$799 / mo</strong></td>
<td>$999 / mo</td>
<td>$1,495 / mo</td>
<td>47% / 33%</td>
<td>Up to 5</td>
<td>Up to 3</td>
<td>50</td>
<td>$5 / shipment</td>
<td>5,000</td>
<td>25 GB</td>
<td>Up to 25</td>
</tr>
<tr>
<td><strong>Spotlight Enterprise</strong></td>
<td>Contact us</td>
<td>Contact us</td>
<td>Custom</td>
<td>Custom</td>
<td>Unlimited</td>
<td>Unlimited</td>
<td>Volume</td>
<td>Negotiated</td>
<td>Custom</td>
<td>Custom</td>
<td>Custom</td>
</tr>
</tbody>
</table>

<h3 class="minor">Additional users beyond bundle</h3>

<p>Spotlight Starter: $49 per additional user / month. Spotlight Professional: $99 per additional user / month. Members who consistently exceed the bundle headcount are natural upgrades to the next tier or to Spotlight Enterprise.</p>

<h3 class="minor">Founding-50 promotion (urgency for the launch window)</h3>

<p>The first 50 IMEAA companies to enroll lock the Founding-50 prices for 24 months. After 50 members are enrolled, IMEAA Standard pricing applies to new members. The cap protects unit economics and gives IMEAA a tangible reason to push hard during the launch window.</p>

<h3 class="minor">Why the shipment cap exists</h3>

<p>Each tracked shipment carries an external-API cost of approximately $2.50 (vessel intelligence and sanctions screening). The included-shipment cap covers typical SME usage. Above the cap, the $5 overage covers cost with a healthy margin. The structure keeps Spotlight pricing sustainable across heavy users.</p>

<div class="highlight-box">
<p><strong>Headline discount.</strong> Up to <strong>55% off list price</strong> at the Spotlight Starter tier for the founding 50 IMEAA members, plus a meaningful discount at every other tier. Defensible, capped, and protected by usage-based overages.</p>
</div>

---

<div class="doc-header">
  <img src="./trackonai-logo-hires.png" class="logo" />
  <div class="meta">
    <strong>Partnership terms</strong>
  </div>
</div>

<h2 class="section">What IMEAA brings</h2>

<p>The Founding-50 and Spotlight pricing is unlocked by IMEAA's distribution commitments. Without them, IMEAA Standard pricing applies at most.</p>

<ol>
  <li><strong>Newsletter feature</strong>: TrackonAI introduced to the IMEAA ecosystem via the monthly newsletter (feature article plus a recurring listing for the launch window)</li>
  <li><strong>Three co-hosted webinars per year</strong>: TrackonAI and IMEAA, targeted at member SMEs, recorded and distributed across IMEAA channels</li>
  <li><strong>Co-branded landing page</strong> at imeaa.org/trackonai (or similar) with a direct sign-up flow</li>
  <li><strong>Featured booth or speaking slot</strong> at IMEAA-DMCC 2027 and other major IMEAA-organized events</li>
  <li><strong>Direct introductions</strong> from IMEAA leadership to the top 100 grain-trading member companies</li>
  <li><strong>Channel awareness</strong> across GAFTA, IGTC, and IGC where appropriate, leveraging the MoU framework</li>
</ol>

<h2 class="section">What Trackon brings</h2>

<ol>
  <li><strong>The Spotlight Grain Edition tenant</strong>, pre-configured as described above</li>
  <li><strong>24-hour go-live</strong> for any IMEAA member</li>
  <li><strong>IMEAA Partner badge</strong> on the platform UI and on member dashboards</li>
  <li><strong>Dedicated WhatsApp and email success channel</strong> during the Founding-50 wave</li>
  <li><strong>Co-marketing assets</strong>: case studies, social posts, and a banner ad pack ready for IMEAA channels</li>
  <li><strong>Roadmap voice</strong>: a quarterly product briefing and a feature-request channel for IMEAA</li>
</ol>

<h2 class="section">Revenue model options — to be discussed</h2>

<p>The discount structure above can be paired with a referral fee, or replaced with one. We are flexible. Three structures to discuss:</p>

<table>
<thead>
<tr><th>Structure</th><th>Member price</th><th>IMEAA earns</th><th>Suited to</th></tr>
</thead>
<tbody>
<tr>
<td><strong>Discount only</strong></td>
<td>Spotlight prices</td>
<td>Channel value, brand strength</td>
<td>Maximum member adoption</td>
</tr>
<tr>
<td><strong>Referral fee only</strong></td>
<td>List prices</td>
<td>20% of first-year subscription revenue</td>
<td>Direct IMEAA revenue</td>
</tr>
<tr>
<td><strong>Hybrid (recommended)</strong></td>
<td>Spotlight prices</td>
<td>15% of first-year subscription revenue + channel value</td>
<td>Aligned incentives both sides</td>
</tr>
</tbody>
</table>

---

<div class="doc-header">
  <img src="./trackonai-logo-hires.png" class="logo" />
  <div class="meta">
    <strong>Timeline · Next steps</strong>
  </div>
</div>

<h2 class="section">Proposed timeline</h2>

<table>
<thead>
<tr><th>Milestone</th><th>Target</th></tr>
</thead>
<tbody>
<tr><td><strong>Offer review and direction call</strong></td><td>Within 2 weeks</td></tr>
<tr><td><strong>Light MoU drafting (2 pages)</strong></td><td>Following 2 weeks</td></tr>
<tr><td><strong>Co-branded landing page live</strong></td><td>30 days from MoU signing</td></tr>
<tr><td><strong>Founding-50 wave opens</strong></td><td>Within 60 days of MoU signing</td></tr>
<tr><td><strong>First IMEAA newsletter feature</strong></td><td>Aligned with Founding-50 wave open</td></tr>
<tr><td><strong>First co-hosted webinar</strong></td><td>90 days from MoU signing</td></tr>
</tbody>
</table>

<h2 class="section">Open question for the direction call</h2>

<div class="highlight-box">
<p><strong>Preferred revenue model.</strong> Which structure best suits IMEAA's preferred operating model: pure discount, pure referral fee, or hybrid? The pricing matrix above is built on the discount frame. The other two structures change the per-member price but not the bouquet design.</p>
</div>

<h2 class="section">Contact</h2>

<p><strong>Trackon Software FZCO</strong><br/>
Dubai, United Arab Emirates<br/>
trackon.ai · trackon.com<br/>
info@trackon.com · WhatsApp +971 58 632 4166</p>
