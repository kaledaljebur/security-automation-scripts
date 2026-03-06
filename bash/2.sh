#!/bin/bash

# Simple cybersecurity automation script

echo "Running basic security checks..."
echo

echo "1. Checking logged-in users"
who
echo

echo "2. Checking failed SSH login attempts"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5
echo

echo "3. Checking open network ports"
ss -tuln
echo

echo "Security check completed."
