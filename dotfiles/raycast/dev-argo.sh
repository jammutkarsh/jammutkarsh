#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title wg dev argo
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🔒
# @raycast.argument1 { "type": "dropdown", "placeholder": "Select Dev App", "data": [{ "title": "D1 Meteor ", "value": "meteor-go-app" }, { "title": "D2 Meteor ", "value": "dev2-meteor-go-app" }, { "title": "Astrozop", "value": "astrozop-service-app-new" }, { "title": "D1 Puzzle API", "value": "dev1-puzzle-api-app" }, { "title": "D2 Puzzle API", "value": "dev2-puzzle-api-app" }, { "title": "D2 GZP AI", "value": "dev2-gzp-ai-common-app" }, { "title": "GZP AI", "value": "gzp-ai-common-app" }, { "title": "Events Stream Processor", "value": "dev-events-stream-processor-app" }] }
# @raycast.packageName WireGuard Switcher
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Connect Dev VPN and open Argo app in Firefox
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WG_SWITCH_SCRIPT="$SCRIPT_DIR/wg-switch.sh"

usage() {
	echo "Usage: $0 <dev-app-name>"
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

/bin/bash "$WG_SWITCH_SCRIPT" dev

url="http://dev-argo.k8s.gamezop.io/applications/$app_name"
open -a "Firefox" "$url"

echo "Dev VPN is now active. Opened $app_name in Firefox."
