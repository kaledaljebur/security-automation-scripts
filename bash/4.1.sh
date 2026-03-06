#!/bin/bash

# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# Enable SSH in Kali:
# sudo systemctl start ssh
# ssh kali@KaliIP, KaliIP can be like 192.168.8.131
# Then run this script like the below:
# sudo bash 4.1.sh 192.168.8.131

TARGET_IP=$1
echo "Target IP: $TARGET_IP"
echo
sudo journalctl | grep "$TARGET_IP"
echo
echo "Search completed."

# Or you may use the below shorter version:
# echo "Target IP: $1"
# sudo journalctl | grep "$1"
# echo
# echo "Search completed."