#!/bin/bash

# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# Enable SSH in Kali:
# sudo systemctl start ssh
# ssh kali@KaliIP 192.168.8.131

# Define variables
TARGET_IP="192.168.8.131"
echo "Target IP: $TARGET_IP"
echo "Checking login attempts in system journal"
echo

# Search journal logs for the target IP
sudo journalctl | grep "$TARGET_IP"
echo
echo "Search completed."