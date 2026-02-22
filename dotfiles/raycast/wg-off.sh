#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title wg off
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔓
# @raycast.packageName WireGuard Switcher
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Disconnect all WireGuard VPNs
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

WG_BIN="wg-quick"
DEV_IF="dev"
PROD_IF="prod"
UC_IF="uc"

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

if ! sudo -n true 2>/dev/null; then
  echo "Error: this command requires passwordless sudo for '$WG_BIN'."
  exit 1
fi

stop_all

echo "All VPNs are now off."
