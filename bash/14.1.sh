#!/bin/bash

# Script to search all log files for a given string
# Usage: sudo ./log_search.sh "search_string"
# The script below was tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

SEARCH=$1
LOGDIR="/var/log"
RESULT="14.1-result.txt"

if [ -z "$SEARCH" ]
then
    echo "Usage: $0 <search_string>"
    echo 'Example: sudo bash ./bash/14.1.sh "Failed password"'
    exit 1
fi

echo "Searching for: $SEARCH"
echo "Log directory: $LOGDIR"
echo "--------------------------------"

grep -iR "$SEARCH" $LOGDIR 2>/dev/null > ./bash/$RESULT

# To easily edit the file afterward
chmod a+w ./bash/$RESULT

if [ -s ./bash/$RESULT ]
then
    echo "Results saved in ./bash/$RESULT"
else
    echo "No matching entries were found"
fi

echo "--------------------------------"
echo "Search completed"

# -z -> checks whether $SEARCH is empty (zero length). If the user did not provide an argument,
#       the code inside the if block runs

# grep -iR:
# -i -> ignore case when searching
# -R -> recursive search, grep will search inside subdirectories

# 2>/dev/null -> redirects error messages to /dev/null (discard them)

# > ./bash/$RESULT -> grep results will be saved in the bash directory