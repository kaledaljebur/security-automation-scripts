#!/bin/bash

SCRIPT_NAME=$0

echo "Checking script permissions..."
echo

if [ -x "$SCRIPT_NAME" ]
then
    echo "Script has execute permission."
else
    echo "Script does NOT have execute permission."
    echo "Run: chmod +x $SCRIPT_NAME"
fi

echo
echo "Permission check completed."
