# Py sample: Port Checker (Single Port)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

import socket  # import socket module for network communication

target = "127.0.0.1"  # target IP address
port = 80             # port to check

sock = socket.socket()  # create socket

result = sock.connect_ex((target, port))  # try to connect (returns 0 if successful)

if result == 0:
    print("Port", port, "is OPEN")
else:
    print("Port", port, "is CLOSED")

sock.close()  # close socket


# Explanation:
# connect_ex() tries to connect to the target and port.
# If the connection succeeds (0), the port is open.
# If it fails (non-zero), the port is closed.