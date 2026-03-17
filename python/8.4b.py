# Py sample: Continuous Client
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import socket

client = socket.socket()
client.connect(("127.0.0.1", 5000))

while True:
    message = input("Client: ")
    client.send(message.encode())

    if message.lower() == "exit":
        break

    data = client.recv(1024).decode()
    print("Server:", data)

    if data.lower() == "exit":
        break

client.close()