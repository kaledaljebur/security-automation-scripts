#!/bin/bash

OUTPUT="/tmp/incident_report.txt"

echo "Collecting incident response data..."
echo

echo "Incident Report - $(date)" > $OUTPUT
echo >> $OUTPUT

echo "=== Logged-in Users ===" >> $OUTPUT
who >> $OUTPUT
echo >> $OUTPUT

echo "=== Running Processes ===" >> $OUTPUT
ps aux | head -10 >> $OUTPUT
echo >> $OUTPUT

echo "=== Open Network Connections ===" >> $OUTPUT
ss -tuln >> $OUTPUT
echo >> $OUTPUT

echo "Incident report saved to $OUTPUT"
