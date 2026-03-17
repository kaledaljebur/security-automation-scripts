# Py sample for File Input and Output (File I/O)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

# log_file = "/var/log/auth.log"
log_file = "./5-auth.log"

# Read the log file line by line
with open(log_file, "r") as file:
    for line in file:
        if "Failed password" in line:
            print("Suspicious login detected:", line.strip())

# Write results to a report file
with open("security_report.txt", "w") as report:
    report.write("Security Report\n")
    report.write("Failed login attempts detected in auth.log\n")

# Append additional information
with open("security_report.txt", "a") as report:
    report.write("Further investigation recommended\n")

# Explanation:
# The script reads the Kali authentication log (/var/log/auth.log)
# and searches for failed SSH login attempts.
# It then writes a simple security report and appends extra notes.

# File modes:
# 'r' = read file
# 'w' = write (creates new file or overwrites existing content)
# 'a' = append (adds new data to existing file without deleting old content)

# line.strip() removes extra whitespace (spaces, tabs, and newline \n)