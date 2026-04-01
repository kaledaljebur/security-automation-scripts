# Stream verifier for deterministic AES-GCM messages using Student ID + passphrase
# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts
# This script reads stream.bin and decrypts each framed message for checking
#
# In Kali apply the bellow to install Crypto package
# python3 -m pip install pycryptodome --break-system-packages
# Use sudo with the above command if sudo used to run this script
#
# Change STUDENT_ID before verifying the captured encrypted stream

import hashlib
from pathlib import Path
from Crypto.Cipher import AES

STREAM_FILE = "stream.bin"
STUDENT_ID = "12345678" # You have to change this to your student ID
PASSPHRASE = "CanBeAnySecret" # You can leave it

PBKDF2_ITERATIONS = 200_000
HEADER_SIZE = 4
NONCE_SIZE = 12
TAG_SIZE = 16
NONCE_PREFIX_SIZE = 4

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

data = Path(STREAM_FILE).read_bytes()
key = derive_key(STUDENT_ID, PASSPHRASE)

print("Key preview:", key.hex()[:16])
print("Expected client nonce prefix:", derive_nonce_prefix(STUDENT_ID, "client").hex())
print("Expected server nonce prefix:", derive_nonce_prefix(STUDENT_ID, "server").hex())
print()

offset = 0
message_number = 1

while offset + HEADER_SIZE <= len(data):
    frame_length = int.from_bytes(data[offset:offset + HEADER_SIZE], "big")
    offset += HEADER_SIZE

    payload = data[offset:offset + frame_length]
    if len(payload) < frame_length:
        print("Truncated frame")
        break
    offset += frame_length

    nonce = payload[:NONCE_SIZE]
    tag = payload[NONCE_SIZE:NONCE_SIZE + TAG_SIZE]
    ciphertext = payload[NONCE_SIZE + TAG_SIZE:]

    cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
    plaintext = cipher.decrypt_and_verify(ciphertext, tag)

    print(f"Message {message_number}")
    print("Nonce:", nonce.hex())
    print("Text :", plaintext.decode("utf-8"))
    print()

    message_number += 1
