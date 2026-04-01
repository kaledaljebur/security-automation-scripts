# Case Study: Deterministic AES-GCM Messaging

This case study shows a simple client-server chat application that protects each message with AES-GCM.

Unlike the earlier random-nonce example, this version derives:

- the AES key from `STUDENT_ID` and `PASSPHRASE`
- a different nonce prefix for the `client` and `server`
- the full nonce from `prefix + counter`

Because the same inputs produce the same derived values, the design is described as deterministic.

## Learning Goals

- understand how a shared AES key can be derived from agreed inputs
- see how AES-GCM provides confidentiality and integrity
- understand why nonce uniqueness matters
- observe framed TCP messaging with a 4-byte length header
- verify recorded encrypted traffic offline using the verifier script

## Files

- `server.py`: listens for one client and sends/receives framed messages
- `clinet.py`: connects to the server and sends/receives framed messages
- `verifier.py`: reads `stream.bin`, decrypts each frame, and prints the plaintext

Note: the filename `clinet.py` is kept to match the naming already used in this repo.

## How It Works

### 1. Key derivation

Both sides derive the same 32-byte AES key using:

- `STUDENT_ID`
- `PASSPHRASE`
- `PBKDF2-HMAC-SHA256`

This means the key does not need to be sent over the network.

### 2. Role-based nonce prefixes

The client and server each derive a different 4-byte nonce prefix from:

- `STUDENT_ID`
- a role label: `client` or `server`

This helps keep nonce spaces separate for each sender.

### 3. Deterministic nonce construction

For encrypted mode, each message nonce is built as:

`nonce = derived_prefix + counter`

The counter increases for every message sent by that side.

This is deterministic because the nonce sequence is predictable from the same starting inputs. It is still valid for AES-GCM as long as a nonce is never reused with the same key.

### 4. AES-GCM protection

Each message is protected with AES-GCM, which gives:

- confidentiality: the message content is encrypted
- integrity: tampering is detected
- authenticity: decryption fails if the tag is wrong

Each transmitted encrypted payload contains:

- `nonce`
- `tag`
- `ciphertext`

### 5. TCP framing

Each message is sent with a 4-byte big-endian length header before the payload.

This avoids problems caused by TCP being a stream rather than a message-based protocol.

## Plaintext and Encrypted Modes

Both `server.py` and `clinet.py` support:

- `DEFAULT_MODE = "encrypted"`
- `DEFAULT_MODE = "plaintext"`

Use `plaintext` only for comparison or teaching. Use `encrypted` for the actual case study behavior.

## How to Run

### Requirements

- Python 3
- PyCryptodome

Install PyCryptodome if needed:

```bash
python3 -m pip install pycryptodome
```

On Kali, you may use:

```bash
python3 -m pip install pycryptodome --break-system-packages
```

### Step 1. Update the values

In both `server.py` and `clinet.py`, set the same:

- `DEFAULT_STUDENT_ID`
- `DEFAULT_PASSPHRASE`
- `DEFAULT_MODE`

In `clinet.py`, also set:

- `DEFAULT_HOST`

### Step 2. Start the server

From this folder, run:

```bash
python server.py
```

### Step 3. Start the client

From this folder, run:

```bash
python clinet.py
```

### Step 4. Exchange messages

Type messages on either side and observe:

- the connection details
- the derived key preview
- the nonce seed preview
- the received plaintext after decryption

## Verifying a Recorded Stream

The verifier is used to decrypt a recorded framed stream from `stream.bin`.

To use it:

1. place `stream.bin` in this folder
2. update `STUDENT_ID` in `verifier.py`
3. update `PASSPHRASE` if needed
4. run:

```bash
python verifier.py
```

The verifier will:

- derive the expected AES key
- print expected client and server nonce prefixes
- read each frame
- decrypt and verify each message
- print the plaintext of each recovered message

## Why This Is a Useful Case Study

This example brings together several important security concepts in one small lab:

- key derivation
- nonce management
- authenticated encryption
- framed socket communication
- offline verification of encrypted traffic

It is also a good teaching bridge between:

- simple encoding examples
- random-nonce AES-GCM examples
- more structured secure messaging designs

## Security Notes

- AES-GCM is secure only if a nonce is never reused with the same key.
- The counter must therefore keep increasing correctly for each sender.
- Client and server use different derived nonce prefixes to reduce collision risk.
- `plaintext` mode is for demonstration only and does not protect messages.
- In a production system, you would also think about replay protection, error handling, persistence, and stronger session design.
