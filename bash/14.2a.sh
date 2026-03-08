#!/bin/bash

# Modular security investigation script
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

HOST=$1

echo "Reconnaissance for $HOST"

ping -c 1 -W 1 $HOST > /dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "$HOST is reachable"
else
    echo "$HOST is not reachable"
fi

echo "Checking common ports..."

nc -z -w 1 $HOST 22 2>/dev/null && echo "Port 22 (SSH) open"
nc -z -w 1 $HOST 80 2>/dev/null && echo "Port 80 (HTTP) open"
nc -z -w 1 $HOST 443 2>/dev/null && echo "Port 443 (HTTPS) open"