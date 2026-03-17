# Py sample: Simple Client
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# To see the traffic, start Wireshark and select the Loopback interface
# Use the filter: tcp.port == 5000 to show only your application traffic
# and hide other unrelated background connections

import socket

client = socket.socket()
client.connect(("127.0.0.1", 5000))

client.send("Hello Server".encode())

response = client.recv(1024).decode()
print("Server says:", response)

client.close()