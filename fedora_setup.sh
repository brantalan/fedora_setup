#!/bin/bash

# Update system packages
sudo dnf update -y

# Install additional packages
sudo dnf install -y gnome-tweaks gnome-console yaru-theme fastfetch

# Remove RPM-based Firefox
sudo dnf remove -y firefox ptyxis

# Add the Flathub repository to Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak applications from Flathub
sudo flatpak install -y flathub org.mozilla.firefox
sudo flatpak install -y flathub org.mozilla.Thunderbird
sudo flatpak install -y flathub com.github.neithern.g4music
sudo flatpak install -y flathub de.haeckerfelix.Fragments
sudo flatpak install -y flathub io.ente.auth
sudo flatpak install -y flathub com.mattjakeman.ExtensionManager

# Install Ubuntu Sans and Ubuntu Sans Mono fonts
FONT_DIR="/usr/share/fonts/google-fonts"

# Create the font directory if it doesn't exist
sudo mkdir -p "$FONT_DIR"

# Download Ubuntu Sans and Ubuntu Sans Mono fonts from GitHub
sudo wget -P "$FONT_DIR" \
    https://github.com/google/fonts/raw/main/ufl/ubuntusans/UbuntuSans-Italic%5Bwdth%2Cwght%5D.ttf \
    https://github.com/google/fonts/raw/main/ufl/ubuntusans/UbuntuSans%5Bwdth%2Cwght%5D.ttf \
    https://github.com/google/fonts/raw/main/ufl/ubuntusansmono/UbuntuSansMono-Italic%5Bwght%5D.ttf \
    https://github.com/google/fonts/raw/main/ufl/ubuntusansmono/UbuntuSansMono%5Bwght%5D.ttf

# Refresh the font cache
sudo fc-cache -fv

# Enable minimize and maximize buttons in GNOME
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Configure mouse and window behavior
gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'lower'
gsettings set org.gnome.desktop.wm.preferences action-right-click-titlebar 'menu'

# Set GNOME shortcut for Ctrl+Alt+T to launch gnome-console
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Console'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-console'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control><Alt>T'

# Copy wallpaper to ~/Pictures/Wallpapers and set it
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPER_DIR"
cp "$(dirname "$0")/wallpaper.png" "$WALLPAPER_DIR/wallpaper.png"

# Set the desktop wallpaper
gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPER_DIR/wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///$WALLPAPER_DIR/wallpaper.png"
gsettings set org.gnome.desktop.background picture-options 'zoom'

# Set GNOME fonts
gsettings set org.gnome.desktop.interface font-name 'Ubuntu Sans 11'
gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13'

# Set GNOME styles to Yaru
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.sound theme-name 'Yaru'
gsettings set org.gnome.desktop.wm.preferences theme 'Yaru'

# Install Proton VPN and related components
# Download and add Proton VPN repository
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.2-1.noarch.rpm"
sudo rpm --import https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/public_key.asc
sudo dnf install -y ./protonvpn-stable-release-1.0.2-1.noarch.rpm && sudo dnf check-update --refresh

# Install Proton VPN GNOME Desktop app
sudo dnf install -y proton-vpn-gnome-desktop

# Install system tray icon support (optional for Proton VPN)
sudo dnf install -y libappindicator-gtk3

# Install Proton Bridge
wget "https://proton.me/download/bridge/protonmail-bridge-3.13.0-1.x86_64.rpm"
sudo dnf install -y ./protonmail-bridge-3.13.0-1.x86_64.rpm

# Install Proton Pass
wget "https://proton.me/download/PassDesktop/linux/x64/ProtonPass.rpm"
sudo dnf install -y ./ProtonPass.rpm

