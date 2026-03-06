#!/bin/bash

LOGFILE="/var/log/auth.log"

echo "Showing failed login attempts with masked IP addresses..."
echo

grep "Failed password" $LOGFILE 2>/dev/null | tail -10 | sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/XXX.XXX.XXX.XXX/g'

echo
echo "IP addresses have been masked for reporting."
