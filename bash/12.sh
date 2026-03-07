#!/bin/bash

# Schedule a Bash script using crontab
# The script below was tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# PATH is set in case cron has a limited environment
PATH=/usr/bin:/bin:/usr/sbin:/sbin

LOGFILE="/home/kaled/system-health.log"

echo "===== System Health Check =====" >> "$LOGFILE"
date >> "$LOGFILE"

echo "Disk usage:" >> "$LOGFILE"
df -h >> "$LOGFILE"

echo "Memory usage:" >> "$LOGFILE"
free -h >> "$LOGFILE"

echo "Top CPU processes:" >> "$LOGFILE"
ps aux --sort=-%cpu | head -5 >> "$LOGFILE"

echo "-------------------------------" >> "$LOGFILE"
echo >> "$LOGFILE"

# The log file will be saved in ~/system-health.log

# Run this script first to make sure it creates the log file:
# bash 12.sh
# Do not use `sudo bash 12.sh`, or the log file will be created in /root/system-health.log

# Then make sure the log file has been created:
# cat ~/system-health.log

# You can then remove it to test crontab:
# rm ~/system-health.log

# To schedule the script:
# chmod +x /home/kaled/Desktop/security-automation-scripts/bash/12.sh

# 1. Run:
# crontab -e
# 2. Add the following line:
# * * * * * /home/kaled/Desktop/security-automation-scripts/bash/12.sh
# 3. Check that the cron job is installed:
# crontab -l

# After one minute, you can read the log file using:
# cat ~/system-health.log

# The log file will keep updating every minute.

# References:
# https://crontab.guru/#*_*_*_*_*