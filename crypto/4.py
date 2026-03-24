# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

# Import AES encryption support
from Crypto.Cipher import AES

# Import secure random byte generator
from Crypto.Random import get_random_bytes

# Generate a 32-byte key for AES-256
key = get_random_bytes(32)

# Generate a 12-byte nonce for GCM mode
nonce = get_random_bytes(12)

# Define the plaintext message as bytes
plaintext = b"Hello AES test"
# Or -> plaintext = "Hello AES test".encode()
# b -> means the value is stored as bytes (binary data) instead of a normal text string
# Use b in Python when a function needs raw bytes data, such as encryption, 
# hashing, networking, or file processing
# You may print using: print(plaintext)

# Create AES-GCM cipher object for encryption
cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)
# nonce is a one-time random value used by AES-GCM to make each encryption unique, 
# even when the same key and plaintext are used (like salt in hashes),
# nonce helps stop identical plaintext producing identical ciphertext with the same key 

# Encrypt plaintext and generate authentication tag
ciphertext, tag = cipher.encrypt_and_digest(plaintext)
# tag -> like HMAC for integrity
# It is much closer to HMAC than to a digital signature, 
# because it provides integrity/authentication with a shared secret key

# Print encrypted data as hexadecimal
print("Ciphertext:", ciphertext.hex())
# Because ciphertext is raw bytes, 
# and .hex() converts those bytes into a readable hexadecimal string for display

# Print authentication tag as hexadecimal
print("Tag:", tag.hex())

# Create AES-GCM cipher object for decryption
decipher = AES.new(key, AES.MODE_GCM, nonce=nonce)

# Decrypt ciphertext and verify integrity/authenticity
decrypted = decipher.decrypt_and_verify(ciphertext, tag)

# Convert decrypted bytes back to text and print
print("Decrypted:", decrypted.decode())


