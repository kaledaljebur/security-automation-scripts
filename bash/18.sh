#!/bin/bash

LOGFILE="/var/log/auth.log"
NETWORK="192.168.1"

echo "=== Security Lab Script ==="
echo

echo "1. Checking failed login attempts..."
grep "Failed password" $LOGFILE 2>/dev/null | awk '{print $11}' | sort | uniq -c | sort -nr | head
echo

echo "2. Scanning first 5 hosts in the network..."

for host in {1..5}
do
    ip="$NETWORK.$host"

    ping -c 1 -W 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is active"
    fi
done

echo
echo "Lab script completed."
