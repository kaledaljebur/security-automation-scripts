#!/bin/bash

echo "Analysing failed SSH login attempts..."
echo

# Make sure the SSH service is enabled, then try logging in with a wrong password
# sudo service ssh start
# ssh 127.0.0.1
# If you use ssh localhost, you may see IPv6 (::1)

journalctl -u ssh | grep "Failed password" | awk '{print $11}' | sort | uniq -c | sort -nr | head

# You may use the below instead in Ubuntu or LinuxMint
# LOGFILE="/var/log/auth.log"
# grep "Failed password" $LOGFILE 2>/dev/null | awk '{print $11}' | sort | uniq -c | sort -nr | head

echo
echo "Top attacking IP addresses displayed above."


# -u ssh -> filter logs by the SSH service
# grep "Failed password" -> keep only lines containing "Failed password"
# awk -> process columns separated by spaces
# '{print $11}' -> $11 prints the 11th field (space-separated column), which is the attacker IP.
    # Mar 06 22:49:54 kali sshd-session[72281]: Failed password for kaled from 127.0.0.1 port 42258 ssh2
# sort -> group identical IPs together
# uniq -c -> count how many times each IP appears
# sort -nr -> -n numeric sort, -r reverse order (largest first)
# head -> display the top 10 attacking IP addresses (10 is the default)