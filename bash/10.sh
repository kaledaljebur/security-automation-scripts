#!/bin/bash

# sed example
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Showing failed login attempts with masked IP addresses..."
echo

journalctl -u ssh | grep "Failed password" | tail -10 | sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/XXX.XXX.XXX.XXX/g'

# You may use the below instead in Ubuntu or Linux Mint
# LOGFILE="/var/log/auth.log"
# grep "Failed password" $LOGFILE 2>/dev/null | tail -10 | sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/XXX.XXX.XXX.XXX/g'

echo
echo "IP addresses have been masked for reporting."

# tail -10 -> show the last 10 lines
# sed -E -> enable extended regular expressions
# s/.../.../g -> substitute text globally
# [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ -> pattern that matches an IPv4 address
# + -> means one or more of the previous character or pattern (e.g., [0-9]+ matches one or more digits)
# \ -> an escape character used to treat the next symbol literally (e.g., \. matches a real dot .), because dot (.) normally represents any single character
# XXX.XXX.XXX.XXX -> replace the IP with a masked value
# g -> global replacement (replace all matches in a line)

# References:
# https://www.gnu.org/software/sed/manual/sed.html
# https://regexone.com/