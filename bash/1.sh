#!/bin/bash

# Week 7 example: simple bash script
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "=== CYB803 Bash Security Automation Demo ==="
echo "Current user: $USER"
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo

echo "Checking current logged-in users..."
w
# You may also use `who` in Ubuntu and Mint
echo

echo "Displaying last 5 failed login attempts (if available)..."

journalctl | grep authentication
# or `journalctl | grep authentication`, or `journalctl | grep pam`

# For Ubuntu and LinuxMint, follow the below:
# sudo apt update && sudo apt -y install openssh-server && sudo systemctl start ssh
# `ssh localhost` then use wrong password
# grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5

# For Alpine, use Hullu VM and SSH from Kali with wrong password
# ssh root@AlpineIP
# grep "Failed password" /var/log/messages

echo "Checking listening network ports..."
# In Kali and Mint make sure SSH is started `sudo systemctl start ssh`
ss -tuln
echo