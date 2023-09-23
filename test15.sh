#!/usr/bin/env bash
#
# Post-installation script for a debian 12 bookworm minimal install
# Must have :
# - user with sudo rights
# - system installed on a btrfs partition

################################################################################
# CHECK OS ENVIRONMENT
################################################################################

lsb_release_path=$(which lsb_release 2> /dev/null)
dist_name=$(lsb_release -si)
dist_version=$(lsb_release -sr)
dist_codename=$(lsb_release -sc)

if [[ "$dist_name" != "Debian" ]] || [[ "$dist_version" != "12" ]]; then
    echo "Sorry. This script is only for Debian 12 Bookworm"
    exit 1
fi

# Check if the user has sudo privileges
if ! sudo -v; then
    echo "This script requires sudo privileges. Exiting."
    exit 1
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run as root. Please run it as a regular user with sudo."
    exit 1
fi

################################################################################
# GNOME - INSTALL GNOME-SHELL EXTENSIONS
################################################################################

# gnome-shell-extension URLs
extension_urls=(
  "https://extensions.gnome.org/extension-data/tiling-assistantleleat-on-github.v43.shell-extension.zip"
  "https://extensions.gnome.org/extension-data/onedrivediegomerida.com.v11.shell-extension.zip"
  "https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v84.shell-extension.zip"
  "https://extensions.gnome.org/extension-data/BingWallpaperineffable-gmail.com.v45.shell-extension.zip"
  "https://extensions.gnome.org/extension-data/caffeinepatapon.info.v51.shell-extension.zip"
  "https://extensions.gnome.org/extension-data/appindicatorsupportrgcjonas.gmail.com.v53.shell-extension.zip"
)

# Install each extension
for url in "${extension_urls[@]}"; do
  gnome-extensions install "$url"
done

