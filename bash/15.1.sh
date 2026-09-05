#!/bin/bash

# Script demonstrating error handling using exit codes, set -e, and trap
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# Stop script if any command fails
set -e

# Trap any error and display a message
trap 'echo "An error occurred. The script will now exit."; exit 1' ERR
echo "Starting security checks..."
echo

# ---- Example 1: Exit Code Checking ----
echo "Ex1: Checking host availability..."
if ping -c 1 192.168.1.10 > /dev/null 2>&1
then
    echo "Host is reachable"
else
    echo "Host is unreachable"
fi
echo

# ---- Example 2: set -e demonstration (script stops if command fails) ----
# This may fail if:
#   the file does not exist
#   the user does not have permission
#   the destination directory cannot be written

# echo "Ex2: Copying security log to backup directory..."
# cp /var/log/auth.log /tmp/auth_backup.log
# echo "Backup completed."
# echo

# ---- Example 3: Intentional error example ----
# This will fail because /non_existing_directory is not exist

# echo "Ex3: Testing trap error handler..."
# ls /non_existing_directory
# echo "This line will not execute if an error occurs."

# NOTE 1:
# ------------------------------------------
# This script contains multiple examples demonstrating different error-handling techniques.
# For learning purposes, run one example at a time.
# Uncomment the example you want to test and comment out the others.
# This helps you clearly observe how each mechanism works (exit codes, set -e, and trap).

# NOTE 2:
# ------------------------------------------
# This script uses both "set -e" and "trap ERR".
# "set -e" stops the script immediately if a command fails.
# "trap ERR" executes specific commands automatically when an error occurs.
# In this script, the trap prints a message before the script exits.
#
# Because of "set -e", once an error occurs the script will terminate,
# so any commands after the failing command will not run.

# NOTE 3:
# ------------------------------------------
# When the actions inside a trap become longer, it is better to place them
# in a function and call that function from the trap.
# This keeps the script cleaner and easier to maintain.
#
# Example idea:
# trap error_handler ERR
#
# The function "error_handler" would then contain the commands that should
# run when an error occurs (printing messages, cleaning temporary files, etc.).

# NOTE 4:
# ------------------------------------------
# In Bash, the "if" statement does not check true/false values directly.
# Instead, it runs the command and evaluates its exit status.
# An exit code of 0 means success (true), while any non-zero value means failure (false).
#
# Example:
# If ping succeeds (exit code 0), the "then" block runs.
# If ping fails (exit code not 0), the "else" block runs.
#
# Because the command is used inside an "if" condition, Bash allows it to fail
# without terminating the script, even when "set -e" is enabled.

# NOTE 5:
# ------------------------------------------
# Using "$?" after a command can be problematic when "set -e" is enabled.
#
# Example of risky pattern:
# ping -c 1 192.168.1.10
# if [ $? -eq 0 ]
# then
#     echo "Host reachable"
# else
#     echo "Host unreachable"
# fi
#
# If the command fails, the script may exit before the exit code is checked.
# A safer approach is to place the command directly inside the "if" condition:
#
# if ping -c 1 192.168.1.10
# then
#     echo "Host reachable"
# else
#     echo "Host unreachable"
# fi