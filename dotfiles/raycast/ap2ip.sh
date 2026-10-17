#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title iap
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📱
# @raycast.packageName iPhone AirPods Connect
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description iPhone AirPods Connect
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

# Get MAC address from the first argument
MAC="14-28-76-b9-51-31" # iPhone AirPods

# Raycast runs with a minimal PATH; cover Apple silicon and Intel Homebrew
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
BLUEUTIL="$(command -v blueutil || true)"
if [ -z "$BLUEUTIL" ]; then
	echo "blueutil not found (brew install blueutil)"
	exit 1
fi

echo "$(date): Attempting to disconnect $MAC"

# Check if MAC is provided
if [ -z "$MAC" ]; then
	echo "No MAC address provided."
	exit 1
fi

# Disconnect
$BLUEUTIL --disconnect "$MAC"
if [ $? -eq 0 ]; then
	echo "$(date): Successfully disconnected $MAC"
else
	echo "$(date): Failed to disconnect $MAC"
fi
