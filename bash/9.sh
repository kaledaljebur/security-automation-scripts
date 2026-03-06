#!/bin/bash

LOGFILE="/var/log/auth.log"

echo "Extracting usernames involved in failed login attempts..."
echo

grep "Failed password" $LOGFILE 2>/dev/null | awk '{print $9}' | sort | uniq -c | sort -nr

echo
echo "Summary of targeted usernames displayed above."
