#!/bin/bash

# ==============================================================================
# Theme Installer for LXQt/Kvantum
# Attribution: 
# - Scripting structure based on LearnLinuxTV Bash series
# - Concept for package management in Void Linux inspired by standard xbps workflows
# License: MIT License (See https://choosealicense.com/licenses/mit/)
# ==============================================================================

echo "--------------------------------------------------------"
echo " Welcome to your Custom Theme Installer!"
echo "--------------------------------------------------------"

read -p "Would you like to install the Modern Dark Theme? (y/n) " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo "[+] Preparing directories..."
    mkdir -p ~/.local/share/lxqt/themes
    mkdir -p ~/.config/Kvantum

    # Adjust these paths to where your theme files are located
    SOURCE_DIR="./win-eleven-dark"

    if [ -d "$SOURCE_DIR" ]; then
        echo "[+] Installing LXQt theme components..."
        cp -r "$SOURCE_DIR/lxqt" ~/.local/share/lxqt/themes/
        
        echo "[+] Installing Kvantum theme components..."
        cp -r "$SOURCE_DIR/Kvantum" ~/.config/Kvantum/
        
        echo "[!] Success! Open 'Appearance' settings to apply the theme."
    else
        echo "[!] Error: Folder '$SOURCE_DIR' not found. Check your file path."
        exit 1
    fi
else
    echo "[!] Installation cancelled."
    exit 0
fi
