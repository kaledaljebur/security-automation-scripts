# Py sample for Reading Suricata eve.json
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import json

log_file = "eve3.json"
count = 0

with open(log_file, "r") as file:
    for line in file:
        data = json.loads(line)

        if data.get("event_type") == "alert":
            src_ip = data.get("src_ip")
            dest_ip = data.get("dest_ip")
            alert = data.get("alert", {}).get("signature")

            print("Alert:", alert)
            print("Source IP:", src_ip)
            print("Destination IP:", dest_ip)
            print("-" * 30)

            # Break after 5 loop because eve3.json is a big file
            count += 1
            if count == 5:
                break


# Explanation:
# The script reads Suricata eve.json line by line.
# Each line is a JSON object.
# It filters only "alert" events and prints key fields.