---
title: hop30.com (fitness app) & superileri.com (dormant science portal)
updated: 2026-07-20
owner: sozturk
status: active
related:
  - ../README.md
  - ../strategy/open-threads.md
---

# hop30.com & superileri.com — personal side projects

## hop30.com — fitness app

- Renamed from **"Superileri Fit"** (previously at app.superileri.com) → own brand **hop30.com** (July 2026).
- Client-side rendered web app (SPA, login-gated). Stage: **family validation** — 3 users (Murat, wife, son).
- Decision (2026-07-20): next step is validation with strangers (~20–50 non-family users, watch week-2 retention), NOT public announcement or marketing. Announcing on superileri.com rejected — dead audience + science/fitness audience mismatch.
- Rebrand decouples the app from superileri.com entirely.
- TODO: redirect app.superileri.com → hop30.com so old links/bookmarks survive.

## superileri.com — Turkish science portal (dormant)

- WordPress ("pinstagram" theme), ~600 posts, last content ~2021. Permalinks are `/post-slug/`, categories at `/category/name/`. Linked Facebook page (auto-posting) — reach presumed throttled after years dormant.
- History: crashed under viral load (200K users) — classic PHP/MySQL per-request rendering.
- **Decision (2026-07-20): no reinvestment.** Evaluated and rejected in sequence: (1) AI Reddit→Turkish translation pipeline — translation arbitrage is dead, AI content farms + Google scaled-content penalties; (2) fitness-app launchpad — dead audience, topic mismatch; (3) full rebuild as publishing platform (Astro + Sveltia CMS + client-side recommendations) — killed by zero-click search / AI Overviews absorbing informational content.
- **Only surviving action: decommission to static archive** — `wget` snapshot → S3 + CloudFront (copy deploy pattern from trackon-saas-webpage), switch DNS, cancel PHP/MySQL hosting. ~$1/month, preserves archive/domain/Facebook page. Not yet executed as of 2026-07-20.
- If hop30 ever validates and wants a content funnel, the domain + archive remain available as an option.
