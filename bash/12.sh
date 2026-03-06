#!/bin/bash

LOGFILE="/var/log/auth.log"
OUTPUT="/tmp/failed_logins_report.txt"

echo "Generating failed login report..."
echo "Report generated at: $(date)" > $OUTPUT
echo >> $OUTPUT

grep "Failed password" $LOGFILE 2>/dev/null | awk '{print $11}' | sort | uniq -c | sort -nr >> $OUTPUT

echo "Report saved to $OUTPUT"
