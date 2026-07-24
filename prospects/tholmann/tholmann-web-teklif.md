---
marp: true
theme: default
paginate: true
style: |
  @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Raleway:wght@100;200;300&display=swap');
  :root {
    --accent: #ff6b1a; --accent-hover: #ff8c4a;
    --dark: #000; --card: #080808; --border: #111;
    --body: #999; --label: #666; --muted: #555; --light: #fff;
    --green: #22c55e; --red: #ef4444; --yellow: #f5a623;
  }
  section { background: var(--dark); color: var(--light); font-family: 'Raleway', sans-serif; font-weight: 200; padding: 56px 72px; }
  h1 { font-family: 'Outfit'; font-weight: 800; font-size: 2.6em; color: var(--light); letter-spacing: -0.02em; line-height: 1.05; margin: 0 0 6px; }
  h2 { font-family: 'Raleway'; font-weight: 100; font-size: 1.2em; color: #888; margin: 0 0 18px; }
  h3 { font-family: 'Outfit'; font-weight: 600; font-size: 0.6em; color: var(--muted); text-transform: uppercase; letter-spacing: 0.2em; margin: 0 0 6px; }
  strong { color: var(--accent); font-weight: 300; }
  section::after { font-family: 'Outfit'; font-size: 0.55em; color: #222; }
  .tag { font-family: 'Outfit'; font-weight: 600; font-size: 0.55em; letter-spacing: 0.12em; text-transform: uppercase; padding: 3px 10px; border-radius: 4px; }
  .row { transition: background 0.2s; border-radius: 6px; }
footer: ''
---

<!-- _paginate: false -->

![bg brightness:0.35](https://images.unsplash.com/photo-1494412574643-ff11b0a5c1c3?w=1400)

<div style="display: flex; flex-direction: column; justify-content: center; height: 100%; padding: 0 40px;">
  <div style="font-family: 'Outfit'; font-weight: 700; font-size: 0.72em; color: #ff8c4a; text-transform: uppercase; letter-spacing: 0.3em; margin-bottom: 14px;">Website Redesign Proposal</div>
  <div style="font-family: 'Outfit'; font-weight: 800; font-size: 3.8em; color: #fff; line-height: 1.05; letter-spacing: -0.03em;">Tholmann DMCC</div>
  <div style="width: 60px; height: 2px; background: #ff6b1a; border-radius: 1px; margin: 22px 0;"></div>
  <div style="font-family: 'Raleway'; font-weight: 300; font-size: 0.85em; color: #ffffffee; text-shadow: 0 1px 8px rgba(0,0,0,0.8);">Prepared by <b>Trackon Software FZCO</b> &nbsp;·&nbsp; July 2026 &nbsp;·&nbsp; For the attention of Mr. H. Ozgur Erdogan</div>
</div>

---

### Current State: tholmann.com

# Your site describes the business, but it doesn't sell it

<div style="display: flex; gap: 14px; margin-top: 18px;">
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.62em; color: var(--muted); letter-spacing: 0.15em; margin-bottom: 12px;">WHAT WORKS</div>
    <div style="font-size: 0.72em; color: var(--body); line-height: 2.1;">
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2" style="vertical-align: -2px;"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg> Clear service story (ocean, air, inland, project cargo)<br>
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2" style="vertical-align: -2px;"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg> Industry-based page structure in place<br>
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2" style="vertical-align: -2px;"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg> Clean, uncluttered overall look
    </div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.62em; color: var(--muted); letter-spacing: 0.15em; margin-bottom: 12px;">WHAT HOLDS IT BACK</div>
    <div style="font-size: 0.72em; color: var(--body); line-height: 2.1;">
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2" style="vertical-align: -2px;"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg> Generic Wix template, not built around your brand<br>
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2" style="vertical-align: -2px;"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg> No contact or quote form, so enquiries walk away<br>
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2" style="vertical-align: -2px;"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg> Social media icons are non-functional placeholders<br>
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#f5a623" stroke-width="2" style="vertical-align: -2px;"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg> Single language and weak SEO make it hard to find on Google
    </div>
  </div>
</div>

---

### Current vs. New

# Side by side

<div style="margin-top: 10px;">
  <div style="display: flex; padding: 8px 0; border-bottom: 1px solid #18181b; font-size: 0.68em;">
    <div style="flex: 2; color: var(--muted); font-weight: 400;">Capability</div>
    <div style="flex: 1; text-align: center; color: var(--muted); font-family: 'Outfit'; font-weight: 600;">Current (Wix)</div>
    <div style="flex: 1; text-align: center; color: var(--accent); font-family: 'Outfit'; font-weight: 600;">New Site</div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 9px 0; border-bottom: 1px solid #111; font-size: 0.7em;">
    <div style="flex: 2; color: var(--body);">Custom brand-first design</div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg></div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 9px 0; border-bottom: 1px solid #111; font-size: 0.7em;">
    <div style="flex: 2; color: var(--body);">Quote request & contact forms</div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg></div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 9px 0; border-bottom: 1px solid #111; font-size: 0.7em;">
    <div style="flex: 2; color: var(--body);">Multi-language (EN / TR / AR)</div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg></div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 9px 0; border-bottom: 1px solid #111; font-size: 0.7em;">
    <div style="flex: 2; color: var(--body);">SEO & Google visibility</div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#f59e0b" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="8" y1="12" x2="16" y2="12"/></svg></div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 9px 0; border-bottom: 1px solid #111; font-size: 0.7em;">
    <div style="flex: 2; color: var(--body);">Speed & mobile performance</div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#f59e0b" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="8" y1="12" x2="16" y2="12"/></svg></div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 9px 0; font-size: 0.7em;">
    <div style="flex: 2; color: var(--body);">Analytics & visitor tracking</div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#ef4444" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg></div>
    <div style="flex: 1; text-align: center;"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#22c55e" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div>
  </div>
</div>

---

### Scope

# Proposed site structure

<div style="display: flex; gap: 14px; margin-top: 18px;">
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px;">Company</div>
    <div style="font-size: 0.68em; color: var(--body); line-height: 1.9;">Home<br>About us<br>Team & values</div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px;">Services</div>
    <div style="font-size: 0.68em; color: var(--body); line-height: 1.9;">Ocean / air / inland<br>Project cargo & heavy lift<br>Advisory & compliance</div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px;">Industries</div>
    <div style="font-size: 0.68em; color: var(--body); line-height: 1.9;">Construction & engineering<br>Retail & technology<br>Oil & gas</div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--accent); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px; color: var(--accent);">Contact & Quote</div>
    <div style="font-size: 0.68em; color: var(--body); line-height: 1.9;">Instant quote form<br>WhatsApp integration<br>Map & office details</div>
  </div>
</div>

<div style="text-align: center; margin-top: 20px; font-size: 0.68em; color: var(--muted);">Every page built mobile-first, multi-language ready and search-engine friendly.<br>All photography, icons and fonts are licensed for commercial use, so you carry no copyright risk, ever.</div>

---

### Performance & Hosting

# Fast everywhere, and hosting is on us for 4 years

<div style="display: flex; gap: 14px; margin-top: 18px;">
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px;">Static Architecture</div>
    <div style="font-size: 0.66em; color: var(--body); line-height: 1.8;">No database, no plugins. Nothing to hack, nothing to break. Pages load in under a second.</div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px;">Global CDN</div>
    <div style="font-size: 0.66em; color: var(--body); line-height: 1.8;">Served from 300+ edge locations on every continent, equally fast in Dubai, Istanbul, Singapore or Sydney.</div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px;">Speed-Optimized</div>
    <div style="font-size: 0.66em; color: var(--body); line-height: 1.8;">Optimized images and code, targeting a Google PageSpeed score of 95+. Speed is an SEO ranking factor.</div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--accent); border-radius: 10px; padding: 20px 22px;">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="var(--accent)" stroke-width="1.5"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.8em; margin: 10px 0 8px; color: var(--accent);">4 Years Free Hosting</div>
    <div style="font-size: 0.66em; color: var(--body); line-height: 1.8;">Hosting included until 2030. No monthly fees, SSL certificate and CDN included.</div>
  </div>
</div>

<div style="text-align: center; margin-top: 20px; font-size: 0.65em; color: var(--muted);">After 4 years, hosting continues at cost. No lock-in, the site and domain stay fully yours.</div>

---

### Our Work

# Sites we've built

<div style="margin-top: 14px;">
  <div class="row" style="display: flex; align-items: center; padding: 12px 14px; border-bottom: 1px solid #111; font-size: 0.72em; background: #ff6b1a08; border-radius: 6px;">
    <div style="flex: 2; font-family: 'Outfit'; font-weight: 600; color: var(--light);">agrisar.com</div>
    <div style="flex: 3; color: var(--body);">Agrisar, the site we built for Mr. Can Tekin's company, who referred you</div>
    <div style="flex: 1; text-align: right;"><span class="tag" style="background: var(--accent); color: #000;">Your referral</span></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 12px 14px; border-bottom: 1px solid #111; font-size: 0.72em;">
    <div style="flex: 2; font-family: 'Outfit'; font-weight: 600; color: var(--light);">mana-dmcc.com</div>
    <div style="flex: 3; color: var(--body);">Mana DMCC, corporate site for a Dubai-based commodity trading firm</div>
    <div style="flex: 1; text-align: right;"><span class="tag" style="background: #ff6b1a12; color: var(--accent); border: 1px solid #ff6b1a22;">DMCC</span></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 12px 14px; border-bottom: 1px solid #111; font-size: 0.72em;">
    <div style="flex: 2; font-family: 'Outfit'; font-weight: 600; color: var(--light);">trackon.com</div>
    <div style="flex: 3; color: var(--body);">Trackon Software, our own enterprise software company site</div>
    <div style="flex: 1; text-align: right;"><span class="tag" style="background: #ff6b1a12; color: var(--accent); border: 1px solid #ff6b1a22;">Corporate</span></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 12px 14px; border-bottom: 1px solid #111; font-size: 0.72em;">
    <div style="flex: 2; font-family: 'Outfit'; font-weight: 600; color: var(--light);">tradingdocs.ai</div>
    <div style="flex: 3; color: var(--body);">TradingDocs.AI, AI-powered SaaS product site</div>
    <div style="flex: 1; text-align: right;"><span class="tag" style="background: #ff6b1a12; color: var(--accent); border: 1px solid #ff6b1a22;">SaaS</span></div>
  </div>
  <div class="row" style="display: flex; align-items: center; padding: 12px 14px; font-size: 0.72em;">
    <div style="flex: 2; font-family: 'Outfit'; font-weight: 600; color: var(--light);">trackon.ai</div>
    <div style="flex: 3; color: var(--body);">TrackonAI, cloud CTRM product site</div>
    <div style="flex: 1; text-align: right;"><span class="tag" style="background: #ff6b1a12; color: var(--accent); border: 1px solid #ff6b1a22;">SaaS</span></div>
  </div>
</div>

<div style="text-align: center; margin-top: 16px; font-size: 0.65em; color: var(--muted);">Two of these are Dubai-based trading companies, the same profile as Tholmann. Feel free to browse them live.</div>

---

### Investment

# Three package options

<div style="display: flex; gap: 14px; margin-top: 16px;">
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 24px;">
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.75em; color: var(--body);">STANDARD</div>
    <div style="font-family: 'Outfit'; font-weight: 800; font-size: 1.8em; margin: 10px 0 2px;">$1,500</div>
    <div style="font-size: 0.6em; color: var(--muted); margin-bottom: 14px;">one-time</div>
    <div style="font-size: 0.65em; color: var(--body); line-height: 2;">
      6-page modern design<br>
      Mobile responsive<br>
      Contact form<br>
      Essential SEO<br>
      Single language (EN)
    </div>
  </div>
  <div style="flex: 1.15; background: var(--card); border: 1px solid var(--accent); border-radius: 12px; padding: 24px; position: relative;">
    <div style="position: absolute; top: -10px; left: 50%; transform: translateX(-50%);"><span class="tag" style="background: var(--accent); color: #000;">Recommended</span></div>
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.75em; color: var(--accent);">CORPORATE</div>
    <div style="font-family: 'Outfit'; font-weight: 800; font-size: 1.8em; margin: 10px 0 2px;">$2,900</div>
    <div style="font-size: 0.6em; color: var(--muted); margin-bottom: 14px;">one-time</div>
    <div style="font-size: 0.65em; color: var(--body); line-height: 2;">
      Custom design, 10+ pages<br>
      Two languages (EN + TR)<br>
      Quote & WhatsApp forms<br>
      Advanced SEO + Analytics<br>
      News / announcements module
    </div>
  </div>
  <div style="flex: 1; background: var(--card); border: 1px solid var(--border); border-radius: 12px; padding: 24px;">
    <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.75em; color: var(--body);">PREMIUM</div>
    <div style="font-family: 'Outfit'; font-weight: 800; font-size: 1.8em; margin: 10px 0 2px;">$4,900</div>
    <div style="font-size: 0.6em; color: var(--muted); margin-bottom: 14px;">one-time</div>
    <div style="font-size: 0.65em; color: var(--body); line-height: 2;">
      Everything in Corporate<br>
      Third language (AR)<br>
      Content management panel<br>
      Shipment-tracking integration ready<br>
      Priority support
    </div>
  </div>
</div>

<div style="text-align: center; margin-top: 16px; font-size: 0.62em; color: var(--muted);">All packages include <span style="color: var(--accent);">4 years of free hosting</span> on a global CDN · Prices exclude VAT · Quote valid for 30 days</div>

---

### Timeline

# Live in 4 weeks

<div style="margin-top: 30px; position: relative;">
  <div style="position: absolute; top: 19px; left: 5%; right: 5%; height: 1px; background: #1a1a1a;"></div>
  <div style="display: flex; justify-content: space-between; position: relative;">
    <div style="text-align: center; flex: 1;">
      <div style="width: 38px; height: 38px; border-radius: 50%; background: var(--card); border: 1px solid var(--accent); display: flex; align-items: center; justify-content: center; margin: 0 auto; font-family: 'Outfit'; font-weight: 700; font-size: 0.7em; color: var(--accent);">1</div>
      <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.72em; margin-top: 12px;">Design</div>
      <div style="font-size: 0.6em; color: var(--muted); margin-top: 4px; line-height: 1.6;">Visual concept<br>2 revision rounds</div>
    </div>
    <div style="text-align: center; flex: 1;">
      <div style="width: 38px; height: 38px; border-radius: 50%; background: var(--card); border: 1px solid var(--accent); display: flex; align-items: center; justify-content: center; margin: 0 auto; font-family: 'Outfit'; font-weight: 700; font-size: 0.7em; color: var(--accent);">2</div>
      <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.72em; margin-top: 12px;">Development</div>
      <div style="font-size: 0.6em; color: var(--muted); margin-top: 4px; line-height: 1.6;">Build & forms<br>Multi-language setup</div>
    </div>
    <div style="text-align: center; flex: 1;">
      <div style="width: 38px; height: 38px; border-radius: 50%; background: var(--card); border: 1px solid var(--accent); display: flex; align-items: center; justify-content: center; margin: 0 auto; font-family: 'Outfit'; font-weight: 700; font-size: 0.7em; color: var(--accent);">3</div>
      <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.72em; margin-top: 12px;">Content & QA</div>
      <div style="font-size: 0.6em; color: var(--muted); margin-top: 4px; line-height: 1.6;">Content entry, SEO<br>Mobile & speed tests</div>
    </div>
    <div style="text-align: center; flex: 1;">
      <div style="width: 38px; height: 38px; border-radius: 50%; background: var(--accent); display: flex; align-items: center; justify-content: center; margin: 0 auto; font-family: 'Outfit'; font-weight: 700; font-size: 0.7em; color: #000;">4</div>
      <div style="font-family: 'Outfit'; font-weight: 600; font-size: 0.72em; margin-top: 12px; color: var(--accent);">Launch</div>
      <div style="font-size: 0.6em; color: var(--muted); margin-top: 4px; line-height: 1.6;">Domain migration<br>Go-live</div>
    </div>
  </div>
</div>

<div style="background: var(--card); border: 1px solid var(--border); border-radius: 10px; padding: 16px 22px; margin-top: 40px; font-size: 0.68em; color: var(--body);">
  <strong>Payment plan:</strong> 40% to start · 40% on design approval · 20% at launch. Your current site stays online throughout, zero downtime.<br>
  <span style="font-size: 0.9em; color: var(--muted);">The 4-week schedule assumes content and feedback reach us within 2 business days at each step.</span>
</div>

---

<!-- _paginate: false -->

![bg brightness:0.2](https://images.unsplash.com/photo-1578575437130-527eed3abbec?w=1400)

<div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 100%; text-align: center; padding: 0 120px;">
  <div style="font-family: 'Raleway'; font-weight: 100; font-size: 0.65em; color: #ff6b1a; text-transform: uppercase; letter-spacing: 0.3em; margin-bottom: 14px;">Next Step</div>
  <div style="font-family: 'Outfit'; font-weight: 800; font-size: 2.8em; color: #fff; line-height: 1.1;">A 30-minute call to<br>finalize the scope</div>
  <div style="width: 60px; height: 2px; background: #ff6b1a; border-radius: 1px; margin: 24px auto;"></div>
  <div style="font-family: 'Raleway'; font-weight: 200; font-size: 0.8em; color: #ffffff99; line-height: 2;">
    Murat Selim Ozturk · Trackon Software FZCO<br>
    sozturk@trackon.com
  </div>
</div>
