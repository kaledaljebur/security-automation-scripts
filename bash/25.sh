#!/bin/bash

echo "=== Basic System Hardening Check ==="
echo

echo "Checking firewall status..."
sudo ufw status
echo

echo "Checking for world-writable files in /tmp..."
find /tmp -type f -perm -0002
echo

echo "Checking running services..."
systemctl list-units --type=service --state=running | head -10
echo

echo "Checking for available system updates..."
sudo apt update -qq
apt list --upgradable 2>/dev/null
echo

echo "Hardening check completed."
