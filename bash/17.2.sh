#!/bin/bash

# Activity: File Integrity Monitoring with Bash
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

# Skip reading the below three lines
set -e
trap 'echo "Do not run this file, just open it, read, and follow!"; exit 1' ERR
ls /non_existing_directory 2>/dev/null

# Description:
# This activity demonstrates the concept of File Integrity
# Monitoring (FIM) using simple Bash scripts. You will
# create a baseline hash of a file and later verify whether
# the file has been modified by comparing its current hash
# with the stored baseline value.

# Step 1: Go to the project folder
cd ~/Desktop/security-automation-scripts

# Step 2: Create a test file
echo "Integrity Test 1" > ./bash/17.2-integrity-test.txt
cat ./bash/17.2-integrity-test.txt

# Step 3: In both scripts 17.1a.sh and 17.1b.sh,
# change the monitored file from:
FILE="/etc/passwd" 
# to:
FILE="./bash/17.2-integrity-test.txt"

# Step 4: Run the baseline creation script
sudo bash ./bash/17.1a.sh

# Step 5: Run the integrity checking script
sudo bash ./bash/17.1b.sh

# At this point, the integrity check should pass because
# the file has not been changed since the baseline was created.

# Step 6: Modify the file
echo "Integrity Test 2" >> ./bash/17.2-integrity-test.txt
cat ./bash/17.2-integrity-test.txt

# Step 7: Run only the integrity checking script again
sudo bash ./bash/17.1b.sh

# This time, the integrity check should fail because the
# file content has changed and its current hash no longer
# matches the stored baseline hash.


# References for this activity

# 1. Bash sha256sum manual (Linux command used to create file hashes)
# https://man7.org/linux/man-pages/man1/sha256sum.1.html

# 2. GNU Coreutils documentation for checksum utilities
# https://www.gnu.org/software/coreutils/manual/html_node/sha2-utilities.html

# 3. AIDE (Advanced Intrusion Detection Environment)
# Example of a real-world file integrity monitoring tool
# https://aide.github.io/

# 4. Tripwire Open Source
# Another well-known file integrity monitoring system
# https://github.com/Tripwire/tripwire-open-source