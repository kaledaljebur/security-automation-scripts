# Py sample for Functions and Modules
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import re

def detect_failed_login(log_line):
    pattern = "Failed password"
    if re.search(pattern, log_line):
        print("Alert: Failed login detected")

log1 = "Mar 10 server sshd: Failed password for admin from 192.168.1.5"
log2 = "Mar 10 server sshd: Accepted password for user from 192.168.1.8"

detect_failed_login(log1)
detect_failed_login(log2)


# re module explanation:
# re = Regular Expressions module in Python.
# It is used to search and match patterns in text.
# In cybersecurity it is commonly used to analyse logs,
# detect failed logins, extract IP addresses, and find suspicious patterns.