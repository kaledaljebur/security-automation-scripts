# Py sample Conditional statements (if, elif, else)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

failed_attempts = 4

if failed_attempts == 0:
    print("No failed login attempts")
elif failed_attempts < 5:
    print("Some failed login attempts detected")
else:
    print("Possible brute force attack")