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
