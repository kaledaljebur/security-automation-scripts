#!/bin/bash

NETWORK="192.168.1"

echo "Scanning network: $NETWORK.0/24"
echo

for host in {1..10}
do
    ip="$NETWORK.$host"

    ping -c 1 -W 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is active"
    fi
done

echo
echo "Network scan completed."
