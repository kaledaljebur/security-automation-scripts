#!/bin/bash

# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# Define variables
TARGET_IP="192.168.1.10"
LOGFILE="/var/log/auth.log"

echo "Target IP: $TARGET_IP"
echo "Checking login attempts in $LOGFILE"
echo

# Search for activity from the target IP
grep "$TARGET_IP" $LOGFILE 2>/dev/null

echo
echo "Search completed."
