# Py sample: Simple Client
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import socket

client = socket.socket()
client.connect(("127.0.0.1", 5000))

client.send("Hello Server".encode())

response = client.recv(1024).decode()
print("Server says:", response)

client.close()