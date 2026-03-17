# Py sample: Show top 5 source IPs from CSV
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

top_5 = sorted(ip_counts.items(), key=lambda item: item[1], reverse=True)[:5]

print("Top 5 Source IPs:")
for ip, count in top_5:
    print(ip, "=", count)


# Explanation:
# This script reads alerts.csv, counts alert frequency for each source IP,
# sorts them from highest to lowest, and shows the top 5 in the terminal.