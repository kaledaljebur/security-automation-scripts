# Py sample: Convert Suricata eve.json alerts to CSV
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import json
import csv

input_file = "eve3.json"
output_file = "alerts.csv"

with open(output_file, "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["Timestamp", "Source IP", "Destination IP", "Alert"])

    with open(input_file, "r") as file:
        for line in file:
            data = json.loads(line)

            if data.get("event_type") == "alert":
                timestamp = data.get("timestamp")
                src_ip = data.get("src_ip")
                dest_ip = data.get("dest_ip")
                alert = data.get("alert", {}).get("signature")

                writer.writerow([timestamp, src_ip, dest_ip, alert])


# Explanation:
# The script reads Suricata eve.json line by line (JSON format).
# It extracts only alert events and selected fields.
# The results are saved into a CSV file (alerts.csv).
# This allows easy viewing in Excel or other tools.