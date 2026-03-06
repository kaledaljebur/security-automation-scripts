#!/bin/bash

FILE="/etc/passwd"
BASELINE="/tmp/passwd.hash"

if [ ! -f "$BASELINE" ]
then
    echo "Creating baseline hash..."
    sha256sum "$FILE" > "$BASELINE"
    echo "Baseline created."
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
