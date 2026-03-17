# Py sample: Show unique alerts only from CSV
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import csv

input_file = "alerts.csv"
unique_alerts = set()

with open(input_file, "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        record = (row["Source IP"], row["Destination IP"], row["Alert"])
        unique_alerts.add(record)

print("Unique Alerts:")
for item in unique_alerts:
    print(item)


# Explanation:
# This script reads alerts.csv and removes duplicate alert records.
# Only unique Source IP, Destination IP, and Alert combinations are shown.