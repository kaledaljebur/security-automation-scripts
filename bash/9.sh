#!/bin/bash

# awk example
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

OUTPUT="9-usernames.txt"

echo "Listing system usernames..."
echo

# Use `sudo cat /etc/passwd` to check the file content
awk -F: '{print $1}' /etc/passwd | tee "$OUTPUT"

echo
echo "Usernames saved in $OUTPUT"

# awk -F: -> use ":" as the field separator
# {print $1} -> print the first field (username)
# /etc/passwd -> system file storing user account information