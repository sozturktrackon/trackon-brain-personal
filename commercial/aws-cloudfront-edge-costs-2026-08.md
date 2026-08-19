---
type: commercial
status: analysis
tags: [aws, cloudfront, infrastructure, costs, trackon-legacy]
created: 2026-08-19
updated: 2026-08-19
related: [products/trackon-legacy/oci-migration-plan.md, _personal/commercial/oracle-cloud-order-2026-07.md]
---

# CloudFront edge costs — Legacy app-tier Option A (2026-08-19)

Cost analysis for fronting the OCI Tomcat with CloudFront + WAF (replacing GA + ALB + EC2 Tomcats). Rates verified on aws.amazon.com/cloudfront/pricing on 2026-08-19.

## Two pricing models available

**Pay-as-you-go (with always-free tier, every month, indefinitely):**
- First 1 TB/month data transfer out + first 10M requests/month: FREE
- Beyond that: $0.085/GB (NA/EU), $0.110/GB (Middle East/Africa), $0.120/GB (APAC); HTTPS requests $0.010–0.012 per 10,000
- Data transfer CloudFront → origin (uploads, POST/PUT): NOT in free tier — $0.020/GB (NA/EU), $0.060/GB (ME), up to $0.160/GB (parts of Asia). Trivial at document-upload volumes.
- Invalidations: first 1,000 paths free. SNI TLS: free (never use dedicated-IP SSL at $600/mo).
- WAF billed separately at standard WAF rates (~$5/web ACL + $1/rule + $0.60/1M requests → typically $10–20/mo for a rule set like the current ALB one).

**Flat-rate plans (2025 packaging, no overage charges):**
- Free $0/mo: 100 GB + 1M req, CDN + DNS + DDoS, but NO WAF
- **Pro $15/mo: 50 TB + 10M req + WAF (25 rules) + logging** ← likely sweet spot: one flat fee, WAF bundled, no metering anxiety
- Business $200/mo (125M req, advanced WAF, private VPC origins), Premium $1,000/mo — irrelevant at our scale
- Caveat: verify flat plans support custom public origins (OCI) with all HTTP methods before committing; PAYG definitely does.

## Expected bill for Legacy tenants

Legacy traffic (handful of tenants, web app + document up/downloads) is almost certainly under 1 TB and 10M requests/month → **PAYG CloudFront ≈ $0 + a few cents of upload-to-origin transfer + $10–20 WAF, or simply the Pro plan at flat $15/mo.** OCI-side egress to CloudFront is covered by OCI's 10 TB/month free egress.

## What it replaces (current monthly spend that disappears)

- Global Accelerator: ~$18/mo fixed ($0.025/h) + premium data transfer per GB
- ALB: ~$16/mo fixed + LCUs
- EC2 Tomcat instances (the big line item — post-RI-expiry these roll to on-demand)
- AWS data transfer out via ALB (~$0.09/GB) on all downloads today

Net: Option A is strictly cheaper than the current stack — roughly $15–20/mo total vs the GA+ALB fixed fees alone, before counting EC2.

**Action before deciding: read actual monthly volume from ALB `ProcessedBytes` / request-count CloudWatch metrics to confirm the free-tier / Pro-plan fit.**

## EC2 RI Marketplace economics (assessed 2026-08-19, updated same day from live inventory — decision: don't sell, repurpose)

- Live inventory (us-west-1): 2× r6g.medium Standard **No Upfront → 2028-12-25** (prod + UDA Tomcats), 1× t4g.medium + 1× t3.micro Standard Partial Upfront → 2027-06-18 (runner + wireguard, stay regardless). The ~Sep/~Nov 2026 expiries are the RDS RIs, not EC2.
- Marketplace (CORRECTED 2026-08-19 vs official AWS docs — first assessment overstated the blocker): only Standard RIs sellable (Convertible excluded). Non-US entities CAN register (W-8BEN-E tax interview); hard requirement is a **disbursement bank with a US address** — attainable via Wise-Business-type USD account (verify AWS accepts). No Upfront RIs sellable ≥30d active / ≥1mo remaining, min price $0.00; buyer assumes recurring payments; 12% AWS fee on upfront price only.
- **Remaining commitment on the r6g pair: $0.0242/h × 2 instances × ~28.2 months to 2028-12-25 ≈ $500/instance ≈ $1,000 total** — this is what selling would relieve. Selling one (prod-ubuntu's, if warm-DR judged not worth it) relieves ~$500; udaz's RI is worth keeping regardless (on-demand replacement ~50% more per hour). Terminate the instance before/at sale — post-sale usage bills on-demand immediately. Lifetime seller caps ($50K / 5,000 RIs) irrelevant at our scale.
- **RI→credit conversion: no such AWS mechanism** (Murat asked 2026-08-19). Credits come from programs (Activate, MAP, account-team POC grants), never from RI buy-backs. Cross-product absorption also fails: RIs discount EC2 in us-west-1 (+ same-org accounts) only; TrackonAI/TradingDocs are serverless, mostly ap-south-1.
- Decision (refined 2026-08-19): udaz-ubuntu stays as UDA file-ingestion host on its prepaid r6g RI (downsizing before Dec 2028 would ADD cost: r6g.medium is the smallest r6g and the RI bills regardless); prod-ubuntu becomes CloudFront warm-DR failover origin on the other r6g RI; runner + wireguard stay on their matched RIs. Let everything lapse at term, never renew.
- Housekeeping: 4 unattached EIPs in us-west-1 bill ~$0.005/h each ≈ $3.65/mo each ≈ **$175/yr for the four** — release unless parked deliberately.
- **EC2 estate monthly run-rate (computed from live account 2026-08-19): ≈ $94/mo total** = RI recurring $46.80 (2× r6g.medium $35.33 to Dec-2028 + t4g.medium $8.76 + t3.micro $2.70 to Jun-2027) + 9 public IPv4 $32.85 + 154 GB gp3 EBS ≈ $14.78. Zero on-demand compute (all running instances RI-covered). Trimmable to ≈ **$65–70/mo** by releasing the 4 unattached EIPs (−$14.60) and deleting staging-ubuntu + al2023 volumes/EIPs once staging is on OCI (≈ −$10–14). Excludes RDS (UDA until Nov), S3, data transfer, ALB/GA.
