#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title 2fa
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🛂
# @raycast.argument1 { "type": "text", "placeholder": "keych" }
# @raycast.packageName 2FA TOTP
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Copy 2FA token for a matching account
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

usage() {
	echo "Usage: $0 <search-text>"
	exit 1
}

require_cmd() {
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "Error: required command '$1' not found."
		exit 1
	fi
}

TWO_FA_BIN="/Users/utc/go/bin/2fa"

if [[ ! -x "$TWO_FA_BIN" ]]; then
	echo "Error: required binary '$TWO_FA_BIN' not found or not executable."
	exit 1
fi

selection="${1:-}"

if [[ -z "$selection" ]]; then
	usage
fi

set +e
result="$("$TWO_FA_BIN" "$selection" 2>&1)"
cmd_status=$?
set -e

line_count="$(printf '%s\n' "$result" | wc -l | tr -d ' ')"

if [[ "$line_count" -eq 1 ]]; then
	printf '%s\n' "$result"
	exit "$cmd_status"
fi

printf '%s\n' "$result" | sed -n '2,$p'
exit 1
