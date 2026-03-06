# Bash Shell Scripts

## [Bash Scripts](./)

## Running the Bash Scripts

1. First navigate to the `bash` folder inside the repository.

    Make sure you move to the repository folder where you cloned or downloaded the project.  
    For example, if the repository is on your Desktop:

    `cd ~/Desktop/security-automation-scripts/bash`

2. Most scripts in this repository require access to system logs or network information, so they may need to be executed with elevated privileges.

    - **Option 1 (Recommended)**

        Make the scripts executable first:

        `chmod +x *.sh`

        Then run a script using:

        `sudo ./script.sh`

        The scripts include a shebang line:

        `#!/bin/bash`

        This allows Linux to use the correct interpreter automatically.

    - **Option 2 (No chmod required)**

        You can also run a script directly with Bash:

        `sudo bash script.sh`

        In this case, the script does **not need executable permission**, because Bash reads the file directly.