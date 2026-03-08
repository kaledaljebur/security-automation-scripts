#!/bin/bash

# Activity: File Integrity Monitoring with Bash
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Do not run this file, just open it, read, and follow!"

# Step 1: Go to the project folder
# cd ~/Desktop/security-automation-scripts

# Step 2: Create a test file
# echo "Integrity Test 1" > ./bash/17.2-integrity-test.txt

# Step 3: In both scripts 17.1a.sh and 17.1b.sh,
# change the monitored file from /etc/passwd to:
# FILE="./17.2-integrity-test.txt"

# Step 4: Run the baseline creation script
# ./bash/17.1a.sh

# Step 5: Run the integrity checking script
# ./bash/17.1b.sh

# At this point, the integrity check should pass because
# the file has not been changed since the baseline was created.

# Step 6: Modify the file
# echo "Integrity Test 2" >> ./bash/17.2-integrity-test.txt

# Step 7: Run only the integrity checking script again
# ./bash/17.1b.sh

# This time, the integrity check should fail because the
# file content has changed and its current hash no longer
# matches the stored baseline hash.