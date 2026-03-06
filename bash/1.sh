#!/bin/bash

# Week 7 example: simple bash script
# The below script is tested in Kali, LinuxMint and Hullu
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

echo "Checking listening network ports..."
# In Kali and Mint, make sure SSH is started: sudo systemctl start ssh
# This also works on Hullu
ss -tuln
echo

echo "Displaying last 5 failed login attempts (if available)..."
journalctl | grep "Failed password" | tail -5
# or use:
# journalctl | grep authentication | tail -5
# journalctl | grep pam | tail -5

# For Ubuntu and Linux Mint:
# sudo apt update && sudo apt -y install openssh-server && sudo systemctl start ssh
# ssh localhost
# then enter a wrong password
# grep "Failed password" /var/log/auth.log | tail -5

# For Hulu:
# ssh root@HulluIP
# then enter a wrong password
# grep "Failed password" /var/log/messages | tail -5