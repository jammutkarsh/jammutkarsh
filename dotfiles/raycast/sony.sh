#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sony
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎧
# @raycast.packageName Sony Headphones Connect
# @raycast.needsConfirmation false

# Documentation:
# @raycast.description Sony Headphones Connect
# @raycast.author jammutkarsh
# @raycast.authorURL https://raycast.com/jammutkarsh

# Get MAC address from the first argument
MAC="40:72:18:34:C5:45" # Sony Headphones

# Path to blueutil (for Intel Mac)
BLUEUTIL="/usr/local/bin/blueutil"

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
