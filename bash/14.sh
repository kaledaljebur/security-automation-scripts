#!/bin/bash

# Reusable script example: the script will be based on the first argument
# The script below was tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

check_host() {
    ip=$1

    ping -c 1 -W 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is reachable"
    else
        echo "$ip is not reachable"
    fi
}

for host in 192.168.8.{1..5}
do
    check_host $host
done
