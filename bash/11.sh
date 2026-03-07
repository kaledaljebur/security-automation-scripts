#!/bin/bash

# Automating System Administration Tasks as a Service
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# This script continuously checks basic system health information
# and writes the results to a log file.

LOGFILE="/var/log/system-health.log"

while true
do
    echo "-------------------------------------" >> "$LOGFILE"
    echo "Running system health checks..." >> "$LOGFILE"
    date >> "$LOGFILE"
    echo >> "$LOGFILE"

    echo "Disk usage:" >> "$LOGFILE"
    df -h >> "$LOGFILE"
    echo >> "$LOGFILE"

    echo "Memory usage:" >> "$LOGFILE"
    free -h >> "$LOGFILE"
    echo >> "$LOGFILE"

    echo "Top running processes:" >> "$LOGFILE"
    ps aux --sort=-%cpu | head -5 >> "$LOGFILE"
    echo >> "$LOGFILE"

    echo "System check completed." >> "$LOGFILE"
    echo >> "$LOGFILE"

    sleep 10
done


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


# -------------------------------
# HOW TO RUN THIS SCRIPT AS A SERVICE
# -------------------------------

# 1. Save the script
# sudo nano /usr/local/bin/myscript.sh

# 2. Make it executable
# sudo chmod +x /usr/local/bin/myscript.sh


# 3. Create a systemd service file
# sudo nano /etc/systemd/system/myscript.service

# 4. Add the following content to the service file (remove the hashes):
# [Unit]
# Description=System Health Monitoring Script
# After=network.target
#
# [Service]
# ExecStart=/usr/local/bin/myscript.sh
# Restart=always
# User=root
#
# [Install]
# WantedBy=multi-user.target

# 5. Reload systemd so it detects the new service
# sudo systemctl daemon-reload

# 6. Enable the service to start automatically at boot if needed (optional step)
# sudo systemctl enable myscript

# 7. Start the service
# sudo systemctl start myscript

# 8. Check the service status
# sudo systemctl status myscript

# 9. Restart the service if needed
# sudo systemctl restart myscript

# 10. Stop the service
# sudo systemctl stop myscript

# 11. Disable the service from starting at boot
# sudo systemctl disable myscript