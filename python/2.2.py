# Py sample for Importing modules using import
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import datetime
import platform

current_time = datetime.datetime.now()
system_name = platform.system()

print("Current time:", current_time)
print("Operating system:", system_name)