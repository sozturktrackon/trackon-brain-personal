---
type: commercial
status: analysis
tags: [aws, cloudfront, infrastructure, costs, trackon-legacy]
created: 2026-08-27
updated: 2026-08-27
related: [products/trackon-legacy/oci-migration-plan.md, _personal/commercial/oracle-cloud-order-2026-07.md]
---

# CloudFront edge costs — Legacy app-tier Option A (2026-08-27)

Cost analysis for fronting the OCI Tomcat with CloudFront + WAF (replacing GA + ALB + EC2 Tomcats). Rates verified on aws.amazon.com/cloudfront/pricing on 2026-08-27.

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

## Full-migration economics (Murat's calculation, 2026-08-27 — verified against live account data)

- AWS before (everything incl. Legacy RDS Oracle LI DBs + serverless products): **≈ $2,200/mo**
- AWS after full Legacy migration: serverless software $350–400 + EC2 estate ~$100 (measured: $94 → $65–70 post-cleanup, leaving room for CloudFront+WAF $15–20) = **≈ $500/mo** → **$1,700/mo AWS reduction**
- OCI: $15K/yr Universal Credits ≈ **$1,250/mo** (committed, fixed regardless of usage)
- **Net total infrastructure reduction ≈ $450–500/mo** ($2,200 → ~$1,750)
- Understated: the $2,200 baseline would have RISEN at the Sep/Nov RDS RI expiries (on-demand rollover), so savings vs the do-nothing world are larger.
- Non-cash win: cures the Oracle licensing exposure from serving customers on AWS RDS License-Included databases.
- Lever for next contract year: UDA→TrackonAI migration would let the OCI commitment renew smaller than $15K.

## MEASURED cost impact of the CloudFront cutover (2026-08-27, from live account data)

**Free-tier headroom check (the thing that decides everything).** CloudFront's perpetual free tier (1 TB egress + 10 M requests/month) is **per account and shared across all distributions**. Account has 7 distributions; month-to-date (27 days of Aug): trackon.com 0.63 GB/235 K, agrisar 6.61 GB/227 K, mana-dmcc 4.53 GB/105 K, trackon.ai 0.58 GB/63 K, tradingdocs.ai 0.36 GB/65 K, legacy-edge 0.30 GB/6 K → **≈ 13 GB and ≈ 0.70 M requests total**. Legacy adds ≈ 80 GB and ≈ 1.0 M req/month (measured on the ALB) → account total ≈ **93 GB (9 % of allowance) and 1.7 M requests (17 %)**. So CloudFront egress and request charges = **$0**, with ~10× headroom on transfer and ~6× on requests.

**New monthly costs**
| item | est. |
|---|---|
| CloudFront egress + requests | $0 (free tier, shared, ample headroom) |
| Origin Shield (per-request, NOT in free tier; scales with cache-MISS traffic) | ~$0.30–0.75 |
| CloudFront → origin transfer (POST/upload bodies, $0.02/GB NA) | ~$0.20 |
| WAF CLOUDFRONT ACL ($5 ACL + $1×5 rules + $0.60/1 M req) | ~$10.60 |
| Invalidations (`/*` = 1 path; 1,000/mo free) | $0 |
| ALB access-log bucket (temporary, 30-day expiry) | ~$0.10 |
| **total added** | **≈ $11–12** |

**Costs removed once decommissioned**
| item | est. |
|---|---|
| ALB `TrackonErp` (fixed + LCU + $0.09/GB × 80 GB egress) | ~$24 |
| Global Accelerator `Trackon` (fixed + premium DT) | ~$19 |
| Regional WAF ACL + 4 rule groups | ~$9.60 |
| 4 unattached Elastic IPs | ~$14.60 |
| Stopped `staging-ubuntu` + `al2023` EBS | ~$4 |
| `prod-ubuntu` EIP (optional, if not kept as failover) | ~$3.65 |
| **total removed** | **≈ $71–75** |

**Net ≈ $60/month saved (~$720/year)**, and note the WAF line is really a lateral move (regional ACL → CloudFront ACL), so almost all the "added" cost is spend we already had.

**Where it could inflate instead — watch these:**
1. **Decommission must actually happen.** During the overlap we pay BOTH stacks (~+$11/mo). Forgetting step 2–4 of the decommission checklist turns a saving into an increase.
2. **Free tier is shared and finite.** Six other distributions draw on it. If Legacy traffic grew ~6× (or another product spikes), requests cross 10 M and egress starts billing at $0.085/GB (NA/EU) / $0.11 (ME/Africa). Set a billing alarm rather than discovering it on an invoice.
3. **Origin Shield scales with cache misses** — all `.doms` traffic is uncacheable by design, so this line grows with user activity, not with page weight. Still cents at current volume.
4. **WAF request charges** scale linearly with traffic ($0.60/1 M).
5. Enabling CloudFront standard access logging later adds S3 storage/PUT costs (not enabled).

## Expected bill for Legacy tenants

Legacy traffic (handful of tenants, web app + document up/downloads) is almost certainly under 1 TB and 10M requests/month → **PAYG CloudFront ≈ $0 + a few cents of upload-to-origin transfer + $10–20 WAF, or simply the Pro plan at flat $15/mo.** OCI-side egress to CloudFront is covered by OCI's 10 TB/month free egress.

## What it replaces (current monthly spend that disappears)

- Global Accelerator: ~$18/mo fixed ($0.025/h) + premium data transfer per GB
- ALB: ~$16/mo fixed + LCUs
- EC2 Tomcat instances (the big line item — post-RI-expiry these roll to on-demand)
- AWS data transfer out via ALB (~$0.09/GB) on all downloads today

Net: Option A is strictly cheaper than the current stack — roughly $15–20/mo total vs the GA+ALB fixed fees alone, before counting EC2.

**Action before deciding: read actual monthly volume from ALB `ProcessedBytes` / request-count CloudWatch metrics to confirm the free-tier / Pro-plan fit.**

## EC2 RI Marketplace economics (assessed 2026-08-27, updated same day from live inventory — decision: don't sell, repurpose)

- Live inventory (us-west-1): 2× r6g.medium Standard **No Upfront → 2028-12-25** (prod + UDA Tomcats), 1× t4g.medium + 1× t3.micro Standard Partial Upfront → 2027-06-18 (runner + wireguard, stay regardless). The ~Sep/~Nov 2026 expiries are the RDS RIs, not EC2.
- Marketplace (CORRECTED 2026-08-27 vs official AWS docs — first assessment overstated the blocker): only Standard RIs sellable (Convertible excluded). Non-US entities CAN register (W-8BEN-E tax interview); hard requirement is a **disbursement bank with a US address** — attainable via Wise-Business-type USD account (verify AWS accepts). No Upfront RIs sellable ≥30d active / ≥1mo remaining, min price $0.00; buyer assumes recurring payments; 12% AWS fee on upfront price only.
- **Remaining commitment on the r6g pair: $0.0242/h × 2 instances × ~28.2 months to 2028-12-25 ≈ $500/instance ≈ $1,000 total** — this is what selling would relieve. Selling one (prod-ubuntu's, if warm-DR judged not worth it) relieves ~$500; udaz's RI is worth keeping regardless (on-demand replacement ~50% more per hour). Terminate the instance before/at sale — post-sale usage bills on-demand immediately. Lifetime seller caps ($50K / 5,000 RIs) irrelevant at our scale.
- **RI→credit conversion: no such AWS mechanism** (Murat asked 2026-08-27). Credits come from programs (Activate, MAP, account-team POC grants), never from RI buy-backs. Cross-product absorption also fails: RIs discount EC2 in us-west-1 (+ same-org accounts) only; TrackonAI/TradingDocs are serverless, mostly ap-south-1.
- Decision (refined 2026-08-27): udaz-ubuntu stays as UDA file-ingestion host on its prepaid r6g RI (downsizing before Dec 2028 would ADD cost: r6g.medium is the smallest r6g and the RI bills regardless); prod-ubuntu becomes CloudFront warm-DR failover origin on the other r6g RI; runner + wireguard stay on their matched RIs. Let everything lapse at term, never renew.
- Housekeeping: 4 unattached EIPs in us-west-1 bill ~$0.005/h each ≈ $3.65/mo each ≈ **$175/yr for the four** — release unless parked deliberately.
- **EC2 estate monthly run-rate (computed from live account 2026-08-27): ≈ $94/mo total** = RI recurring $46.80 (2× r6g.medium $35.33 to Dec-2028 + t4g.medium $8.76 + t3.micro $2.70 to Jun-2027) + 9 public IPv4 $32.85 + 154 GB gp3 EBS ≈ $14.78. Zero on-demand compute (all running instances RI-covered). Trimmable to ≈ **$65–70/mo** by releasing the 4 unattached EIPs (−$14.60) and deleting staging-ubuntu + al2023 volumes/EIPs once staging is on OCI (≈ −$10–14). Excludes RDS (UDA until Nov), S3, data transfer, ALB/GA.
