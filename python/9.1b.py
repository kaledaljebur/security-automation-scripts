# Threaded Chat Client with simple base64 encoding & PSK (Pre Shared Key)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# To see the traffic, start Wireshark and select the Loopback interface
# Use the filter: tcp.port == 5000 to show only your application traffic
# and hide other unrelated background connections

import socket
import threading
import base64

KEY = "secret123"   # pre-shared key

def encrypt(data):
    return base64.b64encode(data)

def decrypt(data):
    return base64.b64decode(data)

client = socket.socket()
port = 5000
client.connect(("127.0.0.1", port))

print("Connected to server")

# ---- send PSK ----
client.send(encrypt(KEY.encode()))

# receive thread
def receive_messages():
    while True:
        try:
            data = decrypt(client.recv(1024)).decode()

            if not data or data.lower() == "exit":
                print("Server disconnected")
                client.close()
                break

            print("Server:", data)

        except:
            break

threading.Thread(target=receive_messages, daemon=True).start()

# send loop
while True:
    message = input("")
    client.send(encrypt(message.encode()))

    if message.lower() == "exit":
        client.close()
        break