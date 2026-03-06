#!/bin/bash

# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Scanning hosts in the network..."

for ip in 192.168.8.{1..5}
do
    ping -c 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is reachable"
    else
        echo "$ip is not reachable"
    fi
done

# for ip in 192.168.8.{1..5} >> ip value will be 192.168.8.1, 192.168.8.2, ..., 192.168.8.5
# -c 1 >> send only 1 packet
# > /dev/null >> discard normal output
# 2>&1 >> discard error output
# if [ $? -eq 0 ] >> Check the exit status of the previous command
# -eq >> equal to
# $? >> result of the last command
# 0 >> success

echo "Scan completed."
