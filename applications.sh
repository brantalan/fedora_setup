#!/bin/bash

# Update system packages
sudo dnf update -y

# Install additional packages
sudo dnf install -y gnome-tweaks gnome-console fastfetch libappindicator-gtk3

# Remove RPM-based Firefox
sudo dnf remove -y firefox

# Add the Flathub repository to Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak applications from Flathub
sudo flatpak install -y flathub org.mozilla.firefox
sudo flatpak install -y flathub org.mozilla.Thunderbird
sudo flatpak install -y flathub com.github.neithern.g4music
sudo flatpak install -y flathub de.haeckerfelix.Fragments
sudo flatpak install -y flathub io.ente.auth
sudo flatpak install -y flathub com.mattjakeman.ExtensionManager

# Install Proton VPN and related components
# Download and add Proton VPN repository
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.2-1.noarch.rpm"
sudo dnf install -y ./protonvpn-stable-release-1.0.2-1.noarch.rpm && sudo dnf check-update --refresh

# Install Proton VPN GNOME Desktop app
sudo dnf install -y proton-vpn-gnome-desktop

# Install Proton Bridge
wget "https://proton.me/download/bridge/protonmail-bridge-3.13.0-1.x86_64.rpm"
sudo dnf install -y ./protonmail-bridge-3.13.0-1.x86_64.rpm

# Install Proton Pass
wget "https://proton.me/download/PassDesktop/linux/x64/ProtonPass.rpm"
sudo dnf install -y ./ProtonPass.rpm

