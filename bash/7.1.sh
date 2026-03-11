#!/bin/bash

# Files read example
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

FILE="./bash/7-ips.txt"

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


# make sure to create 7-ips.txt with content like:
# 192.168.8.1
# 192.168.8.2
# 192.168.8.3
# 192.168.8.4
# 192.168.8.5

# read ip -> reads one line at a time from the input
# ip -> stores the line value from $FILE
# < $FILE will redirect the file as input to the while loop


# References:
# https://www.gnu.org/software/bash/manual/bash.html#Redirections