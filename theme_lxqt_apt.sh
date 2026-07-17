#!/bin/bash

# --- Aesthetic: Black-out UI ---
# Using ANSI escape codes for clean terminal output
clear
echo -e "\e[30;47m === Anki Media Partners: LXQt Automated Setup === \e[0m"
echo -e "\e[34m[INFO]\e[0m Initializing deployment for APT-based system..."

# --- 1. Dependencies ---
echo -e "\e[34m[1/4]\e[0m Updating repositories and installing components..."
sudo apt update
sudo apt install -y git kvantum picom lxqt-config

# --- 2. Resources (Cloning with Credits) ---
echo -e "\e[34m[2/4]\e[0m Fetching theme and icon assets..."

# Catppuccin Icons
# Source: https://github.com/catppuccin/papirus-folders
mkdir -p "$HOME/.local/share/icons"
if [ ! -d "$HOME/.local/share/icons/catppuccin-icons" ]; then
    git clone https://github.com/catppuccin/papirus-folders "$HOME/.local/share/icons/catppuccin-icons"
fi

# Kvantum Arc Theme
# Source: https://github.com/daniruiz/arc-kde
mkdir -p "$HOME/.config/Kvantum"
git clone https://github.com/daniruiz/arc-kde "$HOME/.tmp_arc_theme"
cp -r "$HOME/.tmp_arc_theme/Kvantum/Arc-Dark" "$HOME/.config/Kvantum/"
rm -rf "$HOME/.tmp_arc_theme"

# --- 3. Picom Configuration (Lightweight) ---
echo -e "\e[34m[3/4]\e[0m Applying lightweight compositor settings..."
mkdir -p "$HOME/.config/picom"
cat <<EOF > "$HOME/.config/picom/picom.conf"
backend = "xrender";
vsync = true;
refresh-rate = 0;
use-damage = true;
glx-no-stencil = true;
EOF

# --- 4. Applying Styles ---
echo -e "\e[34m[4/4]\e[0m Finalizing LXQt configuration..."

# Set Kvantum theme
kwriteconfig5 --file "$HOME/.config/kdeglobals" --group "KDE" --key "widgetStyle" "Kvantum"

# Set Icon theme
kwriteconfig5 --file "$HOME/.config/lxqt/lxqt.conf" --group "Visual" --key "icon_theme" "catppuccin-icons"

echo -e "\e[30;42m SETUP COMPLETE. Please logout and log back in to apply changes. \e[0m"
