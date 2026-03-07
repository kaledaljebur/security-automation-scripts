#!/bin/bash

# Function example
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

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
check_host 192.168.8.1
check_host 192.168.8.2
check_host 192.168.8.3
check_host 192.168.8.4
check_host 192.168.8.5

# References:
# https://www.gnu.org/software/bash/manual/bash.html#Shell-Functions