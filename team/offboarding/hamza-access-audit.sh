#!/usr/bin/env bash
# READ-ONLY audit of Hamza's access across systems. Safe to run anytime, no changes made.
# Usage: ./hamza-access-audit.sh
set -uo pipefail

H_GH="hamzayb"
H_EMAIL="hamzayb@trackonsoftware.com"
TAI_POOL="ap-south-1_y1OhTgLij"   # tai-prod-ap-user-pool

echo "==== GitHub (org: trackon-software) ===="
if gh api "orgs/trackon-software/members/$H_GH" --silent 2>/dev/null; then
  echo "MEMBER: $H_GH is still an org member"
else
  echo "OK: $H_GH is not an org member"
fi
echo "-- open PRs authored by $H_GH:"
gh search prs --owner trackon-software --author "$H_GH" --state open --json repository,title \
  --jq '.[] | "\(.repository.nameWithOwner): \(.title)"' 2>/dev/null || echo "(search failed or none)"

echo
echo "==== TrackonAI portal (Cognito prod pool) ===="
aws cognito-idp admin-get-user --user-pool-id "$TAI_POOL" --username "$H_EMAIL" \
  --profile trackonai \
  --query '{Enabled:Enabled,Status:UserStatus}' --output json 2>&1

echo
echo "==== IAM users per AWS account ===="
for p in trackonai tradingdocs trackon-legacy pikiflow; do
  echo "-- profile: $p"
  aws iam list-users --profile "$p" --query 'Users[].UserName' --output text 2>&1
done

echo
echo "==== Shared 'deploy' IAM user access keys (TrackonAI acct) ===="
echo "(Hamza likely used these shared keys for Athena work — rotate on his exit)"
aws iam list-access-keys --user-name deploy --profile trackonai \
  --query 'AccessKeyMetadata[].{Id:AccessKeyId,Status:Status,Created:CreateDate}' --output table 2>&1
echo "-- last used:"
KEY=$(aws iam list-access-keys --user-name deploy --profile trackonai --query 'AccessKeyMetadata[0].AccessKeyId' --output text 2>/dev/null)
[ -n "${KEY:-}" ] && aws iam get-access-key-last-used --access-key-id "$KEY" --profile trackonai \
  --query 'AccessKeyLastUsed' --output json 2>&1

echo
echo "==== NOT auditable from here (check manually) ===="
echo "- Google Workspace: admin.google.com -> $H_EMAIL status"
echo "- Oracle customer DBs + SSH: runner-side tenant inventory (db_deploy_prod.sh hosts)"
echo "- APEX workspace users + Legacy app users: per customer instance"
echo "- Jira/Zendesk: Atlassian + Zendesk admin"
echo "- DeskTime: employee ID 382061"
echo "- CloudTrail/DB audit: unusual exports since 2026-09-01"
