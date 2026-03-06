#!/bin/bash

# Week 7 example: simple bash script

echo "=== CYB803 Bash Security Automation Demo ==="
echo "Current user: $USER"
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo

echo "Checking current logged-in users..."
who
echo

echo "Checking listening network ports..."
ss -tuln
echo

echo "Displaying last 5 failed login attempts (if available)..."
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5
