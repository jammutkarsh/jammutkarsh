#!/bin/bash

# Get MAC address from the first argument
MAC="40:72:18:34:C5:45" # Sony Headphones

# Path to blueutil (for Intel Mac)
BLUEUTIL="/usr/local/bin/blueutil"

# Log file (optional, for debugging)
LOG_FILE="$HOME/.disconnect_bt.log"

echo "$(date): Attempting to disconnect $MAC" >> "$LOG_FILE"

# Check if MAC is provided
if [ -z "$MAC" ]; then
    echo "No MAC address provided." >> "$LOG_FILE"
    exit 1
fi

# Disconnect
$BLUEUTIL --disconnect "$MAC" >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "$(date): Successfully disconnected $MAC" >> "$LOG_FILE"
else
    echo "$(date): Failed to disconnect $MAC" >> "$LOG_FILE"
fi
