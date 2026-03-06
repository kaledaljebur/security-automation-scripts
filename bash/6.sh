#!/bin/bash

# Function to check host availability
check_host() {
    ping -c 1 $1 > /dev/null 2>&1

    if [ $? -eq 0 ]
    then
        echo "$1 is reachable"
    else
        echo "$1 is not reachable"
    fi
}

# Call the function
check_host 192.168.1.1
check_host 192.168.1.2
check_host 192.168.1.3
