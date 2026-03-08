#!/bin/bash

# Script to automate active network reconnaissance
# The script below was tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# Network range to scan
NETWORK="192.168.8.0/24"

# Output file
OUTPUT="/var/log/network_scan.log"

echo "===== Network Scan =====" | tee -a $OUTPUT
date | tee -a $OUTPUT

echo "Running Nmap scan on $NETWORK" | tee -a $OUTPUT

# Run the scan
nmap $NETWORK | tee -a $OUTPUT

echo "" | tee -a $OUTPUT
echo "Scan completed" | tee -a $OUTPUT
echo "" | tee -a $OUTPUT