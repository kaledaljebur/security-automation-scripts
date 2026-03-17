# Py sample: Continuous Server
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

while True:
    data = conn.recv(1024).decode()

    if data.lower() == "exit":
        print("Client disconnected")
        break

    print("Client:", data)

    message = input("Server: ")
    conn.send(message.encode())

    if message.lower() == "exit":
        break

conn.close()
server.close()