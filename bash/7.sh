#!/bin/bash

FILE="ips.txt"

echo "Reading IP addresses from $FILE"
echo

while read ip
do
    echo "Checking host: $ip"
    ping -c 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is reachable"
    else
        echo "$ip is not reachable"
    fi

    echo
done < $FILE

echo "Host checking completed."
