# Py sample for Using Modules
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import json

data = {
    "user": "admin",
    "status": "failed"
}

json_data = json.dumps(data)

print(json_data)