#!/bin/bash

# Script to automate network reconnaissance with automatic subnet detection
# The script below was tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# Detect network from eth0
NETWORK=$(ip -o -f inet addr show eth0 | awk '{print $4}')

# Output file
OUTPUT="/var/log/network_scan.log"

echo "===== Network Scan =====" | tee -a $OUTPUT
date | tee -a $OUTPUT

echo "Detected interface address: $NETWORK" | tee -a $OUTPUT
echo "Running Nmap scan on the network..." | tee -a $OUTPUT

# Run scan
nmap $NETWORK | tee -a $OUTPUT

echo "" | tee -a $OUTPUT
echo "Scan completed" | tee -a $OUTPUT
echo "" | tee -a $OUTPUT

# -o (oneline) -> tells ip to print each record on a single line (useful for scripting)
# -f inet (address family) -> shows IPv4 addresses only and excludes IPv6 (inet6)

# awk can select the line containing a specific string (e.g., "inet"):
# ip addr show eth0 | awk '/inet / {print $2}'

# awk can also select a line based on its line number:
# ip addr show eth0 | awk 'NR==3 {print $2}'