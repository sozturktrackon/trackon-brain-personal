#!/usr/bin/env bash
# STAGED revocation of Hamza's access. DRY-RUN by default; add --execute to act.
# Usage: ./hamza-access-revoke.sh stage1|stage2|stage3 [--execute]
#
# stage1 (day 1, with acceptance email): TrackonAI portal user disabled + signed out everywhere
# stage2 (after code/SQL handover):      GitHub org removal
# stage3 (2026-09-30):                   prints the final manual checklist
set -euo pipefail

H_GH="hamzayb"
H_EMAIL="hamzayb@trackonsoftware.com"
TAI_POOL="ap-south-1_y1OhTgLij"

STAGE="${1:?usage: $0 stage1|stage2|stage3 [--execute]}"
EXECUTE="${2:-dry-run}"

run() {
  if [ "$EXECUTE" = "--execute" ]; then
    echo ">> EXECUTING: $*"
    "$@"
  else
    echo ">> DRY-RUN (would run): $*"
  fi
}

case "$STAGE" in
  stage1)
    echo "== Stage 1: TrackonAI portal access =="
    run aws cognito-idp admin-user-global-sign-out --user-pool-id "$TAI_POOL" --username "$H_EMAIL" --profile trackonai
    run aws cognito-idp admin-disable-user --user-pool-id "$TAI_POOL" --username "$H_EMAIL" --profile trackonai
    echo
    echo "MANUAL, same day (not scriptable from here):"
    echo "  1. Oracle customer DBs: lock his DB account + rotate shared schema passwords (per tenant, via runner inventory)"
    echo "  2. Legacy app + APEX workspace users: disable per customer instance"
    echo "  3. SSH: remove his key from authorized_keys on all legacy EC2 hosts"
    echo "  4. Rotate shared 'deploy' IAM key in TrackonAI acct (create new -> update GH Actions secret -> disable old)"
    echo "  5. Rotate secrets he knows: jira_deploy.env, ShipsGo/SeaRates/Twilio keys (on EC2)"
    ;;
  stage2)
    echo "== Stage 2: GitHub =="
    echo "NOTE: only after his code/SQL/training handover is complete."
    run gh api -X DELETE "orgs/trackon-software/members/$H_GH"
    ;;
  stage3)
    echo "== Stage 3 (2026-09-30) — manual checklist =="
    echo "  1. Google Workspace: SUSPEND (not delete) $H_EMAIL — kills Gmail, chat, any Google SSO"
    echo "  2. Jira + Zendesk: deactivate user"
    echo "  3. DeskTime: deactivate employee 382061"
    echo "  4. Final salary + signed data-deletion/confidentiality confirmation"
    echo "  5. Re-run hamza-access-audit.sh — everything should show disabled/absent"
    ;;
  *)
    echo "unknown stage: $STAGE" >&2; exit 1;;
esac
