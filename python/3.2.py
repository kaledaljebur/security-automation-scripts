# Py sample for Loops (for, while)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

# Example of a for loop
ip_list = ["192.168.1.10", "192.168.1.20", "10.0.0.5"]

for ip in ip_list:
    print("Checking IP:", ip)


# Example of a while loop
attempts = 1

while attempts <= 3:
    print("Login attempt", attempts)
    attempts += 1