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
