# Py sample: Count alerts per source IP from CSV
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import csv

input_file = "alerts.csv"
ip_counts = {}

with open(input_file, "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        src_ip = row["Source IP"]

        if src_ip in ip_counts:
            ip_counts[src_ip] += 1
        else:
            ip_counts[src_ip] = 1

print("Alert Count per Source IP:")
for ip, count in ip_counts.items():
    print(ip, "=", count)


# Explanation:
# This script reads alerts.csv and counts how many times each source IP appears.
# The results are displayed in the terminal.