# This script demonstrates three different ways to run a Linux command (nmap)
# from Python and how to handle the output.
# Tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

import subprocess   # modern and recommended way to run external commands
import os           # provides older/simple ways to run system commands

# Method 1: subprocess.run
# Runs nmap and captures the output so we can process it in Python
print("\nMethod 1: subprocess.run...\n")
result = subprocess.run(
    ["nmap", "-p", "1-100", "127.0.0.1"],  # command and arguments
    capture_output=True,                   # capture stdout/stderr
    text=True                             # return output as string (not bytes)
)
print(result.stdout)  # print the captured output

# Method 2: os.system
# Runs nmap and prints output directly to terminal
# Cannot capture or process the output easily
print("\nMethod 2: os.system...\n")
os.system("nmap -p 1-100 127.0.0.1")

# Method 3: os.popen
# Runs nmap and allows reading the output as a string
# Older method (less recommended than subprocess)
print("\nMethod 3: os.popen...\n")
output = os.popen("nmap -p 1-100 127.0.0.1").read()
print(output)  # print captured output