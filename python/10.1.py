# Py sample: Using Requests to interact with a web API (GET request)
# This example uses httpbin.org, a public API for testing HTTP requests
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import requests   # import requests module to send HTTP requests

# URL of the test API endpoint
url = "https://httpbin.org/get"

# Send a GET request to the server
response = requests.get(url)

# Print HTTP status code (e.g., 200 = OK)
print("Status Code:", response.status_code)

# Print response headers returned by the server
print("Headers:", response.headers)

# Print response body (JSON data)
print("Response Body:", response.text)

# Explanation:
# The requests module allows Python to communicate with web servers using HTTP.
# A GET request is used to retrieve data from a server.
# httpbin.org returns information about the request, which is useful for testing.
# The status code indicates whether the request was successful.
# The response body contains the data returned by the server.