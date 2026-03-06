#!/bin/bash

echo "Running system health checks..."
echo

echo "Disk usage:"
df -h
echo

echo "Memory usage:"
free -h
echo

echo "Top running processes:"
ps aux --sort=-%cpu | head -5
echo

echo "System check completed."
