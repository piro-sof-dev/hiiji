#!/bin/bash

# --- Setup: Black-out Terminal Aesthetic ---
clear
echo -e "\e[30;47m Starting Anki Media Partners - LXQt Auto-Theming \e[0m"
echo -e "\e[32m[INFO]\e[0m Preparing automated configuration..."

# --- Configuration Variables ---
THEME_DIR="$HOME/.local/share/lxqt/themes"
ICON_DIR="$HOME/.local/share/icons"
KVANTUM_DIR="$HOME/.config/Kvantum"
PICOM_CONF="$HOME/.config/picom/picom.conf"

mkdir -p "$THEME_DIR" "$ICON_DIR" "$KVANTUM_DIR" "$(dirname "$PICOM_CONF")"

# --- 1. Install Dependencies ---
echo -e "\e[32m[1/4]\e[0m Checking dependencies (git, kvantum, picom)..."
sudo pacman -S --noconfirm git kvantum picom || sudo apt install -y git kvantum picom

# --- 2. Clone Theme/Icons (Credits to Contributors) ---
echo -e "\e[32m[2/4]\e[0m Fetching Catppuccin Icons and Kvantum Arc..."

# Catppuccin Icons
if [ ! -d "$ICON_DIR/catppuccin-icons" ]; then
    git clone https://github.com/catppuccin/papirus-folders "$ICON_DIR/catppuccin-icons"
fi

# Kvantum Arc (Repo reference)
# Using a common source for Arc-Dark Kvantum
git clone https://github.com/daniruiz/arc-kde "$HOME/.tmp_arc"
cp -r "$HOME/.tmp_arc/Kvantum/Arc-Dark" "$KVANTUM_DIR/"
rm -rf "$HOME/.tmp_arc"

# --- 3. Setup Picom (Lightweight) ---
echo -e "\e[32m[3/4]\e[0m Configuring lightweight Picom..."
cat <<EOF > "$PICOM_CONF"
backend = "glx";
vsync = true;
glx-no-stencil = true;
use-damage = true;
EOF

# --- 4. Apply Configuration ---
echo -e "\e[32m[4/4]\e[0m Applying themes to LXQt..."
# Set Kvantum theme
kwriteconfig5 --file "$HOME/.config/kdeglobals" --group "KDE" --key "widgetStyle" "Kvantum"
# Set Icon theme (replace 'catppuccin-icons' with specific folder name if needed)
kwriteconfig5 --file "$HOME/.config/lxqt/lxqt.conf" --group "Visual" --key "icon_theme" "catppuccin-icons"

echo -e "\e[30;42m DONE: Please restart your LXQt session to apply all changes. \e[0m"
