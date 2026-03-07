#!/bin/bash

# For loop example
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Scanning hosts in the network..."

for ip in 192.168.8.{1..5}
do
    ping -c 1 $ip > /dev/null 2>&1

    # status=$?
    # echo "Exit status: $status"
    # if [ $status -eq 0 ]
    # To print the exit status of ping, enable the above three lines and disable the if line below
    if [ $? -eq 0 ]
    then
        echo "$ip is reachable"
    else
        echo "$ip is not reachable"
    fi
done

echo "Scan completed."

# for ip in 192.168.8.{1..5} -> ip will take the values 192.168.8.1, 192.168.8.2, ..., 192.168.8.5
# > sign is used for output redirection
# -c 1 -> send only 1 packet
# > /dev/null -> discard normal output
# 2>&1 -> redirect error output to the same location as normal output. Since normal output is sent to /dev/null, errors are also discarded

    # In Linux, 0, 1, and 2 are standard file descriptors:
    # 0 -> stdin (input)
    # 1 -> stdout (normal output)
    # 2 -> stderr (error output)

# if [ $? -eq 0 ] -> check the exit status of the previous command

    # $? stores the exit status of the last executed command (ping)
    # 0 -> success
    # non-zero (1,2,etc.) -> failure

# -eq -> equal to (numeric comparison)