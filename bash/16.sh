#!/bin/bash

# Script check file permission
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

SCRIPT_NAME=./bash/1.sh

echo "Checking script permissions..."
echo

if [ -x "$SCRIPT_NAME" ]
then
    echo "Script has execute permission."
else
    echo "Script does NOT have execute permission."
    echo "Run: chmod +x $SCRIPT_NAME"
fi

echo
echo "Permission check completed."

# NOTE:
# The -x file test checks whether a file exists and has execute permission
# for the current user. It returns true if the file can be executed.
#
# In this script:
#   SCRIPT_NAME=$0
#   if [ -x "$SCRIPT_NAME" ]
#
# $0 contains the name/path of the currently running script. The test verifies
# that this script has execute permission. If the script is not executable,
# the user will be advised to enable execution using:
#
#   chmod +x script_name
# 
# Common Bash file test operators:
#   -x file   -> file is executable
#   -r file   -> file is readable
#   -w file   -> file is writable
#   -f file   -> file is a regular file
#   -d file   -> file is a directory
#
# Reference:
# GNU Bash Manual - Conditional Expressions
# https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html