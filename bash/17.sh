#!/bin/bash

LOGFILE="/var/log/auth.log"
THRESHOLD=5

echo "Detecting possible brute force attempts..."
echo

grep "Failed password" "$LOGFILE" 2>/dev/null | awk '{print $11}' | sort | uniq -c | while read count ip
do
    if [ "$count" -ge "$THRESHOLD" ]
    then
        echo "Suspicious activity detected from IP: $ip ($count attempts)"
    fi
done

echo
echo "Detection completed."
