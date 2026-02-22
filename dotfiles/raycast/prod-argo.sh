#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title wg prod argo
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔒
# @raycast.argument1 { "type": "dropdown", "placeholder": "Select Prod App", "data": [{ "title": "Meteor", "value": "meteor-go-app" }, { "title": "Puzzle API", "value": "puzzle-api-app" }, { "title": "Astrozop", "value": "astrozop-service-app" }, { "title": "GZP AI", "value": "gzp-ai-common-app" }, { "title": "Events Stream Processor", "value": "events-stream-processor-app" }] }
# @raycast.packageName WireGuard Switcher
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Connect Prod VPN and open Argo app in Firefox
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WG_SWITCH_SCRIPT="$SCRIPT_DIR/wg-switch.sh"

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

require_cmd open
require_cmd /bin/bash

if [[ ! -f "$WG_SWITCH_SCRIPT" ]]; then
	echo "Error: wg-switch.sh not found at '$WG_SWITCH_SCRIPT'."
	exit 1
fi

app_name="${1:-}"

/bin/bash "$WG_SWITCH_SCRIPT" prod

url="https://argocd.k8s.gamezop.com/applications/$app_name"
open -a "Firefox" "$url"

echo "Prod VPN is now active. Opened $app_name in Firefox."
