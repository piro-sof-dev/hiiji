#!/bin/bash

# --- Aesthetic: Black-out UI ---
clear
echo -e "\e[30;47m === Anki Media Partners: LXQt Alpine Auto-Setup === \e[0m"
echo -e "\e[36m[INFO]\e[0m Initializing deployment for Alpine Linux..."

# --- 1. Dependencies ---
echo -e "\e[36m[1/4]\e[0m Installing core components via apk..."
sudo apk update
sudo apk add git kvantum picom lxqt-config lxqt-themes

# --- 2. Resources (Cloning with Credits) ---
echo -e "\e[36m[2/4]\e[0m Fetching assets..."

# Catppuccin Icons
mkdir -p "$HOME/.local/share/icons"
if [ ! -d "$HOME/.local/share/icons/catppuccin-icons" ]; then
    git clone https://github.com/catppuccin/papirus-folders "$HOME/.local/share/icons/catppuccin-icons"
fi

# Kvantum Arc Theme
mkdir -p "$HOME/.config/Kvantum"
git clone https://github.com/daniruiz/arc-kde "$HOME/.tmp_arc_theme"
cp -r "$HOME/.tmp_arc_theme/Kvantum/Arc-Dark" "$HOME/.config/Kvantum/"
rm -rf "$HOME/.tmp_arc_theme"

# --- 3. Picom Configuration (Lightweight) ---
echo -e "\e[36m[3/4]\e[0m Configuring lightweight Picom..."
mkdir -p "$HOME/.config/picom"
cat <<EOF > "$HOME/.config/picom/picom.conf"
backend = "xrender";
vsync = true;
glx-no-stencil = true;
use-damage = true;
EOF

# --- 4. Applying Styles ---
echo -e "\e[36m[4/4]\e[0m Applying configurations..."

# Set Kvantum theme
# On Alpine, ensure ~/.config/kdeglobals exists
mkdir -p "$HOME/.config"
kwriteconfig5 --file "$HOME/.config/kdeglobals" --group "KDE" --key "widgetStyle" "Kvantum"

# Set Icon theme
kwriteconfig5 --file "$HOME/.config/lxqt/lxqt.conf" --group "Visual" --key "icon_theme" "catppuccin-icons"

echo -e "\e[30;42m SETUP COMPLETE. Please logout and re-logi
n. \e[0m"
