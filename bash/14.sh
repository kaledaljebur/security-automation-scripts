#!/bin/bash

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

for host in 192.168.1.1 192.168.1.2 192.168.1.3
do
    check_host $host
done
