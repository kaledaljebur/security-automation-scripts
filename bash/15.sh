#!/bin/bash

# Stop script if any command fails
set -e

# Trap any error and display a message
trap 'echo "An error occurred. Exiting script."; exit 1' ERR

echo "Starting security checks..."
echo

# ---- Example 1: Exit Code Checking ----
echo "Checking host availability..."

ping -c 1 192.168.1.10 > /dev/null 2>&1

if [ $? -eq 0 ]
then
    echo "Host is reachable"
else
    echo "Host is unreachable"
fi

echo

# ---- Example 2: set -e (Stop on error) ----
echo "Copying security log to backup directory..."

cp /var/log/auth.log /tmp/auth_backup.log

echo "Backup completed."
echo

# ---- Example 3: trap error handler ----
echo "Testing trap error handler..."

ls /non_existing_directory

echo "This line will not execute if an error occurs."
