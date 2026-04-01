import hashlib
import socket
import threading

from Crypto.Cipher import AES

DEFAULT_HOST = "192.168.8.138" # Server IP or its NAT router IP
DEFAULT_PORT = 5000
DEFAULT_STUDENT_ID = "12345678" # You have to change this to your student ID
DEFAULT_PASSPHRASE = "CanBeAnySecret" # You can leave it
DEFAULT_MODE = "encrypted"
PBKDF2_ITERATIONS = 200_000
NONCE_PREFIX_SIZE = 4
NONCE_SIZE = 12
TAG_SIZE = 16
HEADER_SIZE = 4


def recv_exact(sock, size):
    data = bytearray()
    while len(data) < size:
        chunk = sock.recv(size - len(data))
        if not chunk:
            return None
        data.extend(chunk)
    return bytes(data)


def send_frame(sock, payload):
    sock.sendall(len(payload).to_bytes(HEADER_SIZE, "big") + payload)


def recv_frame(sock):
    header = recv_exact(sock, HEADER_SIZE)
    if header is None:
        return None
    size = int.from_bytes(header, "big")
    return recv_exact(sock, size)


def derive_key(student_id, passphrase):
    salt = f"AT3-Part1|{student_id}".encode("utf-8")
    return hashlib.pbkdf2_hmac(
        "sha256",
        passphrase.encode("utf-8"),
        salt,
        PBKDF2_ITERATIONS,
        dklen=32,
    )


def derive_nonce_prefix(student_id, role):
    return hashlib.sha256(
        f"AT3-Part1|{student_id}|{role}".encode("utf-8")
    ).digest()[:NONCE_PREFIX_SIZE]


def encode_text(mode, key, nonce_prefix, counter, text):
    payload = text.encode("utf-8")
    if mode == "plaintext":
        return payload, counter
    nonce = nonce_prefix + counter.to_bytes(NONCE_SIZE - NONCE_PREFIX_SIZE, "big")
    cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
    ciphertext, tag = cipher.encrypt_and_digest(payload)
    return nonce + tag + ciphertext, counter + 1


def decode_text(mode, key, packet):
    if mode == "plaintext":
        payload = packet
    else:
        nonce = packet[:NONCE_SIZE]
        tag = packet[NONCE_SIZE:NONCE_SIZE + TAG_SIZE]
        ciphertext = packet[NONCE_SIZE + TAG_SIZE:]
        cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
        payload = cipher.decrypt_and_verify(ciphertext, tag)
    return payload.decode("utf-8")


def receive_loop(sock, mode, key):
    while True:
        packet = recv_frame(sock)
        if packet is None:
            print("\nServer disconnected")
            return
        print(f"\nServer: {decode_text(mode, key, packet)}")


def main():
    key = None
    nonce_prefix = None
    send_counter = 0

    if DEFAULT_MODE == "encrypted":
        key = derive_key(DEFAULT_STUDENT_ID, DEFAULT_PASSPHRASE)
        nonce_prefix = derive_nonce_prefix(DEFAULT_STUDENT_ID, "client")

    print(f"Student ID: {DEFAULT_STUDENT_ID}")
    if DEFAULT_MODE == "encrypted":
        print(f"Derived key preview: {key.hex()[:16]}")
        print(f"Nonce seed preview: {nonce_prefix.hex()}")

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((DEFAULT_HOST, DEFAULT_PORT))
    print(f"Connected to {DEFAULT_HOST}:{DEFAULT_PORT}")

    receiver = threading.Thread(
        target=receive_loop,
        args=(sock, DEFAULT_MODE, key),
        daemon=True,
    )
    receiver.start()

    while True:
        user_input = input("")
        if not user_input.strip():
            continue
        payload, send_counter = encode_text(
            DEFAULT_MODE,
            key,
            nonce_prefix,
            send_counter,
            user_input,
        )
        send_frame(sock, payload)


if __name__ == "__main__":
    main()
