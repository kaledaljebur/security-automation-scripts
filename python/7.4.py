# Py sample: Add a new Category column to CSV
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import csv

input_file = "alerts.csv"
output_file = "alerts_with_category.csv"

with open(input_file, "r") as infile, open(output_file, "w", newline="") as outfile:
    reader = csv.DictReader(infile)

    fieldnames = reader.fieldnames + ["Category"]
    writer = csv.DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()

    for row in reader:
        row["Category"] = "Suspicious Activity"
        writer.writerow(row)

print("New file created:", output_file)


# Explanation:
# This script reads alerts.csv, adds a new column called Category,
# and saves the updated data into a new file named alerts_with_category.csv.