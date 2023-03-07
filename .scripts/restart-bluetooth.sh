#!/bin/bash

set -e

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Bluetooth
# @raycast.mode fullOutput
# @raycast.packageName System

# Optional parameters:
# @raycast.icon ♻

# Documentation:
# @raycast.description Restart bluetooth daemon
# @raycast.author Oleksandr Popov
# @raycast.authorURL https://github.com/alex-popov-tech

sudo pkill bluetoothd
echo "Bluetooth restarted"
