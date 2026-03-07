#!/bin/bash

# Automating System Administration Tasks example
# The script below was tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Running system health checks..."
echo

echo "Disk usage:"
df -h
echo

echo "Memory usage:"
free -h
echo

echo "Top running processes:"
ps aux --sort=-%cpu | head -5
echo

echo "System check completed."


# ps aux -> show all running processes
# aux:
#   a -> show processes for all users
#   u -> display processes in user-oriented format (shows CPU, memory, user, etc.)
#   x -> include processes not attached to a terminal (background services)

# --sort -> tells ps how to sort the output
# %cpu -> sort by CPU usage
# - before %cpu -> descending order (highest first)
# --sort=-%cpu -> sort processes by highest CPU usage

# head -5 -> display the top 5 processes