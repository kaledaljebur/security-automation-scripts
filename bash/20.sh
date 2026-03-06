#!/bin/bash

LOGFILE="/var/log/auth.log"
THRESHOLD=5

echo "Checking for brute force login attempts..."
echo

grep "Failed password" "$LOGFILE" 2>/dev/null | awk '{print $11}' | sort | uniq -c | while read count ip
do
    if [ "$count" -ge "$THRESHOLD" ]
    then
        echo "Potential brute force attack from $ip ($count failed attempts)"
    fi
done

echo
echo "Brute force detection completed."
