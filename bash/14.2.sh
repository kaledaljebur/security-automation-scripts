#!/bin/bash

# Modular security investigation script
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

read -p "Enter host IP address: " HOST

if [ -z "$HOST" ]
then
    echo "No IP address provided."
    exit 1
fi

echo "--------------------------------"
echo "Starting investigation for $HOST"
echo "--------------------------------"

# Module A: reconnaissance
bash ./bash/14.2a.sh $HOST

echo "--------------------------------"

# Module B: log investigation
bash ./bash/14.2b.sh $HOST

echo "--------------------------------"
echo "Investigation completed"