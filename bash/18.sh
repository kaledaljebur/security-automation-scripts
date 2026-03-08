#!/bin/bash

# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

LOGFILE="/var/log/auth.log"
THRESHOLD=5

echo "Checking for attacking IP addresses..."
echo

grep "Failed password" "$LOGFILE" 2>/dev/null | awk '{print $11}' | sort | uniq -c | while read count ip
do
    if [ "$count" -ge "$THRESHOLD" ]
    then
        echo "Blocking attacker: $ip ($count attempts)"
        sudo iptables -A INPUT -s "$ip" -j DROP
    fi
done

echo
echo "Firewall update completed."
