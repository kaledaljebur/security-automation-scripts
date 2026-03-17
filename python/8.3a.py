# Py sample: Simple Server
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# To see the traffic, make sure to start Wireshark and select Loopback

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