#!/bin/bash

# Script to generate file integrity baseline
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

FILE="/etc/passwd"
BASELINE="/tmp/passwd.hash"

echo "Creating baseline hash..."
sha256sum "$FILE" > "$BASELINE"
echo "Baseline created."

cat $BASELINE

# A file integrity baseline is a trusted reference value used
# to detect unauthorized changes to important system files.
# The baseline is usually a cryptographic hash (such as SHA-256)
# calculated when the system is known to be in a clean and
# trusted state.
#
# In this script, a SHA-256 hash of the critical Linux file
# /etc/passwd is generated and stored in a baseline file
# (/tmp/passwd.hash). This stored hash represents the original
# state of the file.
#
# Example of a baseline hash:
# 0f91d74c893ecb56b7d65fc591b9144cdd2c53675475e75d97fc399e3ddf307e
#
# Later, another script (17.1b.sh) can recalculate the hash of the same
# file and compare it with this baseline. If the values differ,
# it may indicate that the file has been modified, either by a
# legitimate system change or by a potential security incident.
#
# This concept is commonly used in File Integrity Monitoring
# (FIM) systems such as Tripwire, AIDE, and Wazuh.