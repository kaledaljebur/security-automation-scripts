#!/bin/bash

# Script to generate file integrity baseline
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

FILE="/etc/passwd"
BASELINE="/tmp/passwd.hash"

echo "Creating baseline hash..."
sha256sum "$FILE" > "$BASELINE"
echo "Baseline created."

cat $BASELINE