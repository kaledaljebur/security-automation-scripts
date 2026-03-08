#!/bin/bash

# Script to check file integrity baseline
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

FILE="/etc/passwd"
BASELINE="/tmp/passwd.hash"

if [ ! -f "$BASELINE" ]
then
    echo "BASELINE is not exist!"
else
    echo "Checking file integrity..."

    CURRENT=$(sha256sum "$FILE")

    if grep -q "$CURRENT" "$BASELINE"
    then
        echo "File integrity OK."
    else
        echo "WARNING: File has been modified!"
    fi
fi

# This script verifies the integrity of the /etc/passwd file by
# comparing its current SHA-256 hash with a previously generated
# baseline hash stored in /tmp/passwd.hash.
#
# The baseline hash represents the trusted state of the file
# when the system was known to be clean. During execution, the
# script calculates a new SHA-256 hash of /etc/passwd and then
# checks whether this value matches the stored baseline.
#
# Verification process:
# 1. Confirm that the baseline file exists.
# 2. Calculate the current hash of /etc/passwd.
# 3. Compare the current hash with the stored baseline hash.
#
# If the hashes match:
#    The file has not changed and integrity is confirmed.
#
# If the hashes differ:
#    The script prints a warning indicating that the file may
#    have been modified, which could indicate system changes
#    or a potential security compromise.
#
# This demonstrates a basic File Integrity Monitoring (FIM)
# technique used by security tools such as Tripwire, AIDE,
# and Wazuh.