#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title wg prod argo
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔒
# @raycast.argument1 { "type": "dropdown", "placeholder": "Select Prod App", "data": [{ "title": "meteor-go-app", "value": "meteor-go-app" }, { "title": "puzzle-api-app", "value": "puzzle-api-app" }, { "title": "astrozop-service-app", "value": "astrozop-service-app" }, { "title": "gzp-ai-common-app", "value": "gzp-ai-common-app" }, { "title": "events-stream-processor-app", "value": "events-stream-processor-app" }] }
# @raycast.packageName WireGuard Switcher
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Connect Prod VPN and open Argo app in Firefox
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

WG_BIN="wg-quick"
DEV_IF="dev"
PROD_IF="prod"
UC_IF="uc"

usage() {
  echo "Usage: $0 <prod-app-name>"
  exit 1
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Error: required command '$1' not found."
    exit 1
  fi
}

stop_all() {
  sudo -n "$WG_BIN" down "$DEV_IF" 2>/dev/null || true
  sudo -n "$WG_BIN" down "$PROD_IF" 2>/dev/null || true
  sudo -n "$WG_BIN" down "$UC_IF" 2>/dev/null || true
}

require_cmd sudo
require_cmd "$WG_BIN"
require_cmd open

if ! sudo -n true 2>/dev/null; then
  echo "Error: this command requires passwordless sudo for '$WG_BIN'."
  exit 1
fi

app_name="${1:-}"
[[ -n "$app_name" ]] || usage

case "$app_name" in
  meteor-go-app|puzzle-api-app|astrozop-service-app|gzp-ai-common-app|events-stream-processor-app)
    ;;
  *)
    echo "Error: invalid prod app '$app_name'."
    exit 1
    ;;
esac

stop_all
sudo -n "$WG_BIN" up "$PROD_IF"

url="https://argocd.k8s.gamezop.com/applications/$app_name"
open -a "Firefox" "$url"

echo "Prod VPN is now active. Opened $app_name in Firefox."
