#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ap
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎧
# @raycast.packageName AirPods Connect
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description AirPods Connect
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

# Get MAC address from the first argument
MAC="14-28-76-b9-51-31" # AirPods

# Raycast runs with a minimal PATH; cover Apple silicon and Intel Homebrew
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
BLUEUTIL="$(command -v blueutil || true)"
if [ -z "$BLUEUTIL" ]; then
	echo "blueutil not found (brew install blueutil)"
	exit 1
fi

echo "$(date): Attempting to connect $MAC"

# Check if MAC is provided
if [ -z "$MAC" ]; then
	echo "No MAC address provided."
	exit 1
fi

# Connect
$BLUEUTIL --connect "$MAC"

if [ $? -eq 0 ]; then
	echo "$(date): Successfully connected $MAC"
else
	echo "$(date): Failed to connect $MAC"
fi
