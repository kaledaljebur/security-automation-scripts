# Py sample for Functions (def)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

# Define a function
def check_login_attempts(attempts):
    if attempts >= 5:
        print("Possible brute force attack")
    else:
        print("Login attempts within normal range")


# Call the function
check_login_attempts(3)
check_login_attempts(7)