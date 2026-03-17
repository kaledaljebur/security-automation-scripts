# Py sample: Simple Server
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# To see the traffic, start Wireshark and select the Loopback interface
# Use the filter: tcp.port == 5000 to show only your application traffic
# and hide other unrelated background connections

import socket

server = socket.socket()
server.bind(("0.0.0.0", 5000))
server.listen(1)

print("Server listening...")

conn, addr = server.accept()
print("Connected from:", addr)

data = conn.recv(1024).decode()
print("Received:", data)

conn.send("Message received".encode())

conn.close()