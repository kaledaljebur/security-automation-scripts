#!/bin/bash

NETWORK="192.168.1"

echo "Starting network discovery..."
echo

for host in {1..20}
do
    ip="$NETWORK.$host"

    ping -c 1 -W 1 "$ip" > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "Active host detected: $ip"
    fi
done

echo
echo "Network scan completed."
