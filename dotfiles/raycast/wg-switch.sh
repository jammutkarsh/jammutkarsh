#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title wgs
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔒
# @raycast.argument1 { "type": "dropdown", "placeholder": "Select WireGuard Config", "data": [{ "title": "Off", "value": "off" }, { "title": "UC", "value": "uc" }, { "title": "Prod", "value": "prod" }, { "title": "Dev", "value": "dev" }] }
# @raycast.packageName WireGuard Switcher
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Wire Guard Switcher
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

WG_BIN="wg-quick"

DEV_IF="dev"
PROD_IF="prod"
UC_IF="uc"

usage() {
	echo "Usage: $0 {off|dev|prod|uc}"
	exit 1
}

require_cmd() {
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "Error: required command '$1' not found."
		exit 1
	fi
}

stop_all() {
	sudo $WG_BIN down "$DEV_IF" 2>/dev/null || true
	sudo $WG_BIN down "$DEV_IF" 2>/dev/null || true
	sudo $WG_BIN down "$PROD_IF" 2>/dev/null || true
	sudo $WG_BIN down "$UC_IF" 2>/dev/null || true
}

require_cmd sudo
require_cmd "$WG_BIN"

selection="${1:-}"

if [[ -z "$selection" ]]; then
	usage
fi

if ! true 2>/dev/null; then
	echo "Error: this Raycast command requires passwordless sudo for '$WG_BIN'."
	echo "Hint: configure sudoers for 'wg-quick' and rerun."
	exit 1
fi

case "$selection" in
off)
	stop_all
	echo "All VPNs are now off."
	;;
dev)
	stop_all
	$WG_BIN up "$DEV_IF"
	echo "Dev VPN is now active."
	;;
prod)
	stop_all
	$WG_BIN up "$PROD_IF"
	echo "Prod VPN is now active."
	;;
uc)
	stop_all
	$WG_BIN up "$UC_IF"
	echo "UC VPN is now active."
	;;
*)
	usage
	;;
esac
