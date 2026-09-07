---
type: commercial
status: active
tags:
  - aws
  - lambda
  - trackonai
  - cost
  - snapstart
created: 2026-09-07
updated: 2026-09-07
related:
  - "[[decisions/2026-pdf-converter-provisioned-concurrency]]"
  - "[[company/processes/lambda-snapstart]]"
  - "[[_personal/commercial/aws-cloudfront-edge-costs-2026-08]]"
---

# PDF converter (LibreOffice Lambda): Provisioned Concurrency vs SnapStart cost

Computed 2026-09-07 from the public Lambda pricing page (US East rates; Mumbai Lambda rates are the same for the components below, verify on the bill after the swap). Function: `PdfConverterFunction`, Image package, 2048 MB, **x86_64** (no `Architectures` in the template, so x86 rates apply; the 2026-06-30 ADR used the arm64 figure by mistake).

## Rates used

| Component | Rate |
|---|---|
| Provisioned Concurrency keep-warm (x86) | $0.0000041667 per GB-s |
| PC invocation duration (x86) | $0.0000097222 per GB-s |
| SnapStart cache (x86, Python) | $0.0000015046 per GB-s, 3 h minimum per version |
| SnapStart restore (x86) | $0.0001397998 per GB restored |

## Monthly, one region stack (730 h), 2 GB

| Item | PC=1 today | SnapStart |
|---|---|---|
| Standby (keep-warm or cached version) | 5,256,000 GB-s x 0.0000041667 = **$21.90** | 5,256,000 GB-s x 0.0000015046 = **$7.91** per cached version |
| Cold starts | none within PC=1 | $0.00028 per restore (2 GB), 1,000 restores = $0.28 |
| Deploy churn | none | old version cached until daily cleanup: max $0.26 per deploy; 3 h minimum = $0.03 |
| **Total** | **~$21.90** | **~$8 to $9** |

Net in prod ap-south-1: about **$13/month saved (~60%)** if SnapStart replaces PC there only.

## Scope multiplier

Standby is per version per stack. Enabling SnapStart also in prod us-east-1 and staging (which pay $0 standby today) adds ~$7.91/month each, so "SnapStart everywhere" lands at roughly $24/month, slightly above today's $21.90, but with the 7-8 s cold start removed in all three stacks instead of one.

## Notes

- Cache is billed on function memory, for as long as the version exists, whether or not it is invoked. Deleting non-alias versions promptly is what keeps this at one version's cost: the daily `CleanupLambdaVersions` run with `VERSIONS_TO_KEEP=0` does that (verified working on the image function 2026-09-07: only v8 + $LATEST remained in prod ap).
- Cutting memory to 1024 MB, if LibreOffice tolerates it, halves both columns.
