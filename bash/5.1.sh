#!/bin/bash

# While loop example
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Scanning hosts in the network..."

i=1
while [ $i -le 5 ]
do
    ip="192.168.8.$i"

    ping -c 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is reachable"
    else
        echo "$ip is not reachable"
    fi

    i=$((i+1))
done

echo "Scan completed."

# -le -> less than or equal to