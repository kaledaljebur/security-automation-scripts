#!/bin/bash

echo "=== Automated Security Check ==="
echo

echo "Checking logged-in users..."
who
echo

echo "Checking open network ports..."
ss -tuln
echo

echo "Checking last failed login attempts..."
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5
echo

echo "Security check completed."
