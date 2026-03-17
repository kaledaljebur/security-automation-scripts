# Py sample: Port Checker (Multiple List of Ports)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# Make sure any webserver is running like IIS in Win or `sudo service apache2 start` in kali

import socket

target = "127.0.0.1"  # target IP
ports = [21, 22, 23, 80, 443]  # list of ports to check

for port in ports:
    sock = socket.socket()

    result = sock.connect_ex((target, port))

    if result == 0:
        print("Port", port, "is OPEN")
    else:
        print("Port", port, "is CLOSED")

    sock.close()


# Explanation:
# The script loops through a list of ports.
# Each port is tested one by one.
# This is a basic version of how port scanners work.