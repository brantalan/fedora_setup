#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Update system packages
sudo dnf update -y

# Install additional packages
sudo dnf install -y gnome-tweaks yaru-theme fastfetch

# Remove RPM-based Firefox
sudo dnf remove -y firefox

# Add the Flathub repository to Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Prioritize Flathub over Fedora's Flatpak repository
sudo flatpak remote-modify --set-priority=1 flathub

# Install Flatpak applications from Flathub
sudo flatpak install -y flathub org.mozilla.firefox
sudo flatpak install -y flathub org.mozilla.Thunderbird
sudo flatpak install -y flathub com.belmoussaoui.Gapless
sudo flatpak install -y flathub de.haeckerfelix.Fragments
sudo flatpak install -y flathub io.ente.Auth
sudo flatpak install -y flathub com.mattjakeman.ExtensionManager

# Install Proton VPN
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.2-1.noarch.rpm"
sudo dnf install -y ./protonvpn-stable-release-1.0.2-1.noarch.rpm && sudo dnf check-update --refresh
sudo dnf install -y proton-vpn-gnome-desktop

# Install system tray icon support (optional for Proton VPN)
sudo dnf install -y libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app

# Install Proton Bridge
wget "https://proton.me/download/bridge/protonmail-bridge-3.13.0-1.x86_64.rpm"
sudo dnf install -y ./protonmail-bridge-3.13.0-1.x86_64.rpm

# Install Proton Pass
wget "https://proton.me/download/PassDesktop/linux/x64/ProtonPass.rpm"
sudo dnf install -y ./ProtonPass.rpm

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
sudo gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# Configure mouse and window behavior
sudo gsettings set org.gnome.desktop.wm.preferences action-double-click-titlebar 'toggle-maximize'
sudo gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'lower'
sudo gsettings set org.gnome.desktop.wm.preferences action-right-click-titlebar 'menu'

# Set GNOME shortcut for Ctrl+Alt+T to launch ptyxis
#sudo gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
#sudo gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 name 'Terminal'
#sudo gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 command 'ptyxis'
#sudo gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0 binding '<Control><Alt>T'

