# Threaded Chat Server with simple base64 encoding & PSK (Pre Shared Key)
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

server = socket.socket()
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
port = 5000
server.bind(("0.0.0.0", port))
server.listen(1)

print(f"Server listening on port {port}...")

conn, addr = server.accept()
print("Connected from:", addr)

# ---- PSK check ----
psk = decrypt(conn.recv(1024)).decode()
if psk != KEY:
    print("Invalid key")
    conn.close()
    server.close()
    exit()
print("PSK verified")

# receive thread
def receive_messages():
    while True:
        try:
            data = decrypt(conn.recv(1024)).decode()

            if not data or data.lower() == "exit":
                print("Client disconnected")
                conn.close()
                server.close()
                break

            print("Client:", data)

        except:
            break

threading.Thread(target=receive_messages, daemon=True).start()

# send loop
while True:
    message = input("")
    conn.send(encrypt(message.encode()))

    if message.lower() == "exit":
        conn.close()
        server.close()
        break

# Notes
# The key is used only to allow or deny the connection (authentication)
# This is encoding (Base64), not encryption
# Anyone can decode it easily
# Linux commands:
#   echo -n "hello" | base64
#   echo "aGVsbG8=" | base64 -d

# In Wireshark:
# Right-click packet -> Follow -> TCP Stream
# You will see the encoded (Base64) data

# Future Improvements:
# Current version uses Base64 (encoding only, not secure)
# This can be upgraded step by step:
#   1. Use hashing without encoding: hash(key + message) -> adds an integrity check
#   2. Use HMAC -> provides secure message authentication
#   3. Use encryption (e.g. AES) -> protects confidentiality
#   4. Use HMAC + encryption (e.g. AES) -> protects confidentiality and integrity
# Each level introduces a stronger security concept
# and can be used as a separate example in future lectures