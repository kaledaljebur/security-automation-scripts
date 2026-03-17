# Py sample: Threaded Chat Server 
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# To see the traffic, make sure to start Wireshark and select Loopback

import socket          # import socket module for network communication
import threading       # import threading to allow simultaneous send/receive

server = socket.socket()                # create a socket object for the server
server.bind(("0.0.0.0", 5000))          # bind server to all interfaces on port 5000
server.listen(1)                        # listen for incoming connections (max 1 client)

print("Server listening on port 5000...")  # display message that server is ready

conn, addr = server.accept()           # accept a connection from a client
print("Connected from:", addr)         # print client address


# Function to continuously receive messages from the client
def receive_messages():
    while True:                        # loop forever to keep receiving messages
        try:
            data = conn.recv(1024).decode()   # receive data (1024 bytes) and decode to string

            if not data or data.lower() == "exit":  # check if client disconnected or sent "exit"
                print("Client disconnected")        # notify server user
                conn.close()                       # close client connection
                server.close()                     # close server socket
                break                              # exit the loop

            print("\nClient:", data)  # print received message from client

        except:
            break                    # stop loop if error occurs (e.g. connection lost)


# Start receiving messages in a separate thread (runs in background)
threading.Thread(target=receive_messages, daemon=True).start()


# Main loop for sending messages to the client
while True:
    message = input("")      # take input from server user
    conn.send(message.encode())     # send message to client (encode to bytes)

    if message.lower() == "exit":   # check if server wants to exit
        conn.close()                # close connection
        server.close()              # close server socket
        break                       # exit loop


# Explanation:
# The server uses threading to handle receiving and sending at the same time.
# One thread continuously listens for incoming messages.
# The main loop allows the server user to send messages.
# Typing "exit" will close the connection on both sides.