#!/bin/bash

# Week 7 example: simple bash script automation
# The below script is tested in Kali
# https://github.com/kaledaljebur/security-automation-scripts

echo "Updating system..."
sudo apt update

echo "Downloading VS Code package..."
wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

echo "Installing VS Code..."
sudo apt install -y ./vscode.deb

echo "Fixing dependencies if needed..."
sudo apt --fix-broken install -y

echo "Cleaning up..."
rm vscode.deb

echo "VS Code installation completed."
