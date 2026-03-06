#!/bin/bash

LOGFILE="/var/log/auth.log"

echo "Analysing failed SSH login attempts..."
echo

grep "Failed password" $LOGFILE 2>/dev/null | awk '{print $11}' | sort | uniq -c | sort -nr | head

echo
echo "Top attacking IP addresses displayed above."
