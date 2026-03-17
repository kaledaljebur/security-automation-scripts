# Py sample: Banner Grabber
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# Make sure any webserver is running like IIS in Win or `sudo service apache2 start` in kali

import socket  # import socket module for network communication

target = "127.0.0.1"  # target server
port = 80               # HTTP port

sock = socket.socket()  # create a socket object
sock.connect((target, port))  # connect to the server

# send a simple HTTP request to the server
sock.send("GET / HTTP/1.1\r\nHost: localhost\r\n\r\n".encode())

# receive response (banner) from the server
banner = sock.recv(1024).decode()
print("Banner:\n", banner)

sock.close()  # close the connection


# Explanation:
# This script connects to a web server and sends an HTTP request.
# The server responds with data (banner), which may include server information.
# This technique is used in security to identify services and gather information.