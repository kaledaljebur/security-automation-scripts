# The below script is tested in Kali & Windows
# https://github.com/kaledaljebur/security-automation-scripts

# Import AES encryption support
from Crypto.Cipher import AES

# Import secure random byte generator
from Crypto.Random import get_random_bytes

# Import padding helpers for CBC mode
from Crypto.Util.Padding import pad, unpad

# Generate a 32-byte key for AES-256
key = get_random_bytes(32)

# Generate a 16-byte IV for CBC mode
iv = get_random_bytes(16)

# Define the plaintext message as bytes
plaintext = b"Hello AES test"
# Or -> plaintext = "Hello AES test".encode()
# b -> means the value is stored as bytes (binary data) instead of a normal text string

# Create AES-CBC cipher object for encryption
cipher = AES.new(key, AES.MODE_CBC, iv=iv)
# iv -> initialization vector used to make encryption unique
# CBC requires a 16-byte IV because AES block size is 16 bytes

# Pad plaintext to a multiple of AES block size
padded_plaintext = pad(plaintext, AES.block_size)
# CBC works on fixed-size blocks, so plaintext must be padded

# Encrypt the padded plaintext
ciphertext = cipher.encrypt(padded_plaintext)

# Print encrypted data as hexadecimal
print("Ciphertext:", ciphertext.hex())

# Print IV as hexadecimal
print("IV:", iv.hex())

# Create AES-CBC cipher object for decryption
decipher = AES.new(key, AES.MODE_CBC, iv=iv)

# Decrypt ciphertext
decrypted_padded = decipher.decrypt(ciphertext)

# Remove padding after decryption
decrypted = unpad(decrypted_padded, AES.block_size)

# Convert decrypted bytes back to text and print
print("Decrypted:", decrypted.decode())
