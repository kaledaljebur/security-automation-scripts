#!/bin/bash

# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Scanning hosts in the network..."

for ip in 192.168.1.{1..5}
do
    ping -c 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is reachable"
    else
        echo "$ip is not reachable"
    fi
done

echo "Scan completed."
