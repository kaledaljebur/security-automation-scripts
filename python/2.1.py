# Py sample for variables and basic data types (strings, integers, lists, dictionaries)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

# String
username = "admin"

# Integer
failed_attempts = 3

# List
ip_addresses = ["192.168.1.10", "192.168.1.20"]

# Dictionary
login_log = {
    "user": "admin",
    "status": "failed",
    "ip": "192.168.1.10"
}

print(username)
print(failed_attempts)
print(ip_addresses)
print(login_log)