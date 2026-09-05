#!/bin/bash

# Schedule a Bash script using crontab
# The script below was tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# PATH is set in case cron runs with a limited environment
# Otherwise commands should be specified using their full path
# For example: `date` is located at /usr/bin/date
PATH=/usr/bin:/bin:/usr/sbin:/sbin

LOGFILE="/var/log/system-health.log"

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

# Run this script first to make sure it creates the log file:
# sudo bash ./bash/12.sh
# Then make sure the log file has been created:
# cat /var/log/system-health.log
# You can then remove it to test crontab:
# sudo rm /var/log/system-health.log

# To schedule the script:
# chmod +x /home/kaled/Desktop/security-automation-scripts/bash/12.sh

# 1. Run the below and select /bin/nano as an editor:
# sudo crontab -e
# 2. Add the following line:
# * * * * * /home/kaled/Desktop/security-automation-scripts/bash/12.sh
# 3. Check that the cron job is installed:
# sudo crontab -l

# After one minute, you can read the log file using:
# cat /var/log/system-health.log

# The log file will keep updating every minute.

# References:
# https://crontab.guru/#*_*_*_*_*