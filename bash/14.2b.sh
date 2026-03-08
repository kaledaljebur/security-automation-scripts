#!/bin/bash

# Modular security investigation script
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

HOST=$1
LOGDIR="/var/log"

echo "Searching logs for activity from $HOST"

grep -R "$HOST" $LOGDIR 2>/dev/null