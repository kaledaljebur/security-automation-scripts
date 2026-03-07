#!/bin/bash

# File read and save output example
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

FILE="7-ips.txt"

echo "Reading IP addresses from $FILE" | tee 7.1-output.txt
echo

while read ip
do
    echo "Checking host: $ip" >> 7.1-output.txt
    ping -c 1 $ip > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$ip is reachable" >> 7.1-output.txt
    else
        echo "$ip is not reachable" >> 7.1-output.txt
    fi

    echo >> 7.1-output.txt
done < $FILE

echo "Host checking completed." | tee -a 7.1-output.txt

# echo "text" > output.txt -> write to file only (overwrite)
# echo "text" >> output.txt -> append to file only
# echo "text" | tee output.txt -> show on terminal and write to file
# echo "text" | tee -a output.txt -> show on terminal and append to file

