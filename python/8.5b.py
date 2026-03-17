# Py sample: Threaded Chat Client
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# To see the traffic, make sure to start Wireshark and select Loopback

import socket          # import socket module for networking
import threading       # import threading for simultaneous operations

client = socket.socket()                  # create a socket object for the client
client.connect(("127.0.0.1", 5000))      # connect to server at localhost on port 5000

print("Connected to server")             # confirm connection


# Function to continuously receive messages from the server
def receive_messages():
    while True:                          # loop forever to keep receiving messages
        try:
            data = client.recv(1024).decode()   # receive data and convert to string

            if not data or data.lower() == "exit":  # check if server disconnected or sent exit
                print("Server disconnected")        # notify user
                client.close()                     # close client socket
                break                              # exit loop

            print("\nServer:", data)  # print message received from server

        except:
            break                    # exit loop if error occurs


# Start receiving messages in a separate thread (background)
threading.Thread(target=receive_messages, daemon=True).start()


# Main loop for sending messages to the server
while True:
    message = input("")      # get input from user
    client.send(message.encode())   # send message to server

    if message.lower() == "exit":   # if user types exit
        client.close()              # close connection
        break                       # exit loop


# Explanation:
# The client uses threading to send and receive messages at the same time.
# One thread listens for incoming messages from the server.
# The main loop allows the user to send messages.
# Typing "exit" will terminate the chat session.