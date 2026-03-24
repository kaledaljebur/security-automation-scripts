# Threaded Chat Server with AES-GCM and PSK (Pre Shared Key)
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# To see the traffic, start Wireshark and select the Loopback interface
# Use the filter: tcp.port == 5000 to show only your application traffic

# In Kali apply the bellow to install Crypto package
# python3 -m pip install pycryptodome --break-system-packages

# Import socket support for TCP networking.
import socket
# Import threading so receiving and sending can happen at the same time.
import threading
# Import SHA-256 so the shared text key can be turned into a 32-byte AES key.
import hashlib
# Import AES support from PyCryptodome.
from Crypto.Cipher import AES
# Import a secure random generator for the AES-GCM nonce.
from Crypto.Random import get_random_bytes

# Define the pre-shared key as normal text.
KEY = "secret123"
# Convert the text key into a fixed 32-byte value for AES-256.
AES_KEY = hashlib.sha256(KEY.encode()).digest()
# Define the TCP port used by the chat server.
PORT = 5000
# Define the nonce size commonly used with AES-GCM.
NONCE_SIZE = 12
# Define the authentication tag size used by AES-GCM.
TAG_SIZE = 16


# Encrypt one message using AES-GCM.
def encrypt_message(data):
    # Create a fresh random nonce for this message.
    nonce = get_random_bytes(NONCE_SIZE)
    # Create an AES-GCM cipher object using the shared AES key.
    cipher = AES.new(AES_KEY, AES.MODE_GCM, nonce=nonce)
    # Encrypt the plaintext and create the integrity/authentication tag.
    ciphertext, tag = cipher.encrypt_and_digest(data)
    # Return nonce + tag + ciphertext in one packet.
    return nonce + tag + ciphertext


# Decrypt one AES-GCM message.
def decrypt_message(packet):
    # Read the nonce from the beginning of the packet.
    nonce = packet[:NONCE_SIZE]
    # Read the authentication tag after the nonce.
    tag = packet[NONCE_SIZE:NONCE_SIZE + TAG_SIZE]
    # Read the ciphertext from the rest of the packet.
    ciphertext = packet[NONCE_SIZE + TAG_SIZE:]
    # Create a matching AES-GCM cipher object for decryption.
    cipher = AES.new(AES_KEY, AES.MODE_GCM, nonce=nonce)
    # Decrypt the ciphertext and verify the tag at the same time.
    return cipher.decrypt_and_verify(ciphertext, tag)


# Send exactly one framed packet over TCP.
def send_packet(sock, payload):
    # Add a 4-byte length prefix before the encrypted payload.
    sock.sendall(len(payload).to_bytes(4, "big") + payload)


# Read an exact number of bytes from a socket.
def recv_exact(sock, size):
    # Start with an empty bytes buffer.
    data = b""
    # Keep reading until the full amount is received.
    while len(data) < size:
        # Read the remaining bytes still needed.
        chunk = sock.recv(size - len(data))
        # Stop if the connection is closed.
        if not chunk:
            # Return None to signal disconnect.
            return None
        # Append the new bytes to the buffer.
        data += chunk
    # Return the completed byte string.
    return data


# Receive one framed packet over TCP.
def recv_packet(sock):
    # Read the 4-byte length prefix first.
    header = recv_exact(sock, 4)
    # Stop if the connection closed before the header arrived.
    if header is None:
        # Return None to signal disconnect.
        return None
    # Convert the 4-byte header to an integer packet size.
    size = int.from_bytes(header, "big")
    # Read exactly that many payload bytes.
    return recv_exact(sock, size)


# Create the server socket.
server = socket.socket()
# Allow quick restart on the same port.
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# Bind the server to all local interfaces on the chosen port.
server.bind(("0.0.0.0", PORT))
# Wait for one client connection.
server.listen(1)

# Show that the server is ready.
print(f"Server listening on port {PORT}...")

# Accept one incoming client connection.
conn, addr = server.accept()
# Show the connected client address.
print("Connected from:", addr)

# Receive the encrypted authentication message from the client.
auth_packet = recv_packet(conn)
# Stop if no authentication packet was received.
if auth_packet is None:
    # Inform the user that the client disconnected early.
    print("Client disconnected before authentication")
    # Close the connection socket.
    conn.close()
    # Close the listening socket.
    server.close()
    # Exit the program.
    raise SystemExit

try:
    # Decrypt the authentication message and convert it to text.
    psk = decrypt_message(auth_packet).decode()
except Exception:
    # Inform the user that decryption or verification failed.
    print("Authentication failed")
    # Close the connection socket.
    conn.close()
    # Close the listening socket.
    server.close()
    # Exit the program.
    raise SystemExit

# Compare the received shared key to the expected shared key.
if psk != KEY:
    # Inform the user that the client used the wrong key.
    print("Invalid key")
    # Close the connection socket.
    conn.close()
    # Close the listening socket.
    server.close()
    # Exit the program.
    raise SystemExit

# Show that the shared key check passed.
print("PSK verified")
# Send an encrypted confirmation back to the client.
send_packet(conn, encrypt_message(b"OK"))

# Create an event used to stop both threads cleanly.
stop_event = threading.Event()


# Receive and display incoming chat messages.
def receive_messages():
    # Keep receiving until the chat ends.
    while not stop_event.is_set():
        try:
            # Receive one framed encrypted packet.
            packet = recv_packet(conn)
            # Stop if the connection was closed.
            if packet is None:
                # Inform the user that the client disconnected.
                print("Client disconnected")
                # Tell the main loop to stop.
                stop_event.set()
                # Exit the receive loop.
                break
            # Decrypt the packet and convert it to text.
            data = decrypt_message(packet).decode()
            # Check whether the peer wants to end the chat.
            if data.lower() == "exit":
                # Inform the user that the client ended the session.
                print("Client disconnected")
                # Tell the main loop to stop.
                stop_event.set()
                # Exit the receive loop.
                break
            # Show the received plaintext message.
            print("Client:", data)
        except Exception as error:
            # Show the error so the behavior is visible during teaching.
            print("Receive error:", error)
            # Tell the main loop to stop.
            stop_event.set()
            # Exit the receive loop.
            break


# Start the background thread that receives messages.
threading.Thread(target=receive_messages, daemon=True).start()

# Keep reading local input and sending it to the client.
while not stop_event.is_set():
    try:
        # Read one line from the keyboard.
        message = input("")
        # Encrypt and send the message as one framed packet.
        send_packet(conn, encrypt_message(message.encode()))
        # Stop if the local user typed exit.
        if message.lower() == "exit":
            # Tell the receive thread to stop too.
            stop_event.set()
            # Leave the send loop.
            break
    except (EOFError, KeyboardInterrupt):
        # Stop cleanly if the program is interrupted locally.
        stop_event.set()
        # Leave the send loop.
        break
    except Exception as error:
        # Show send-side errors for visibility.
        print("Send error:", error)
        # Stop the chat after the error.
        stop_event.set()
        # Leave the send loop.
        break

# Close the connected client socket.
conn.close()
# Close the listening server socket.
server.close()
