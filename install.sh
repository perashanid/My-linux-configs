#!/bin/bash
# Complete COSMIC Desktop Setup - Fresh Install Script
# This script installs all packages and restores configurations

set -e  # Exit on error

echo "=========================================="
echo "COSMIC Desktop Complete Setup"
echo "=========================================="
echo ""
echo "This script will:"
echo "  1. Install all required packages"
echo "  2. Configure system settings"
echo "  3. Restore COSMIC configurations"
echo "  4. Setup autostart applications"
echo ""
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 1
fi

echo ""
echo "=========================================="
echo "Step 1: Installing Packages"
echo "=========================================="

# Essential applications
echo "Installing essential applications..."
sudo pacman -S --needed --noconfirm \
    docker docker-compose obsidian copyq qbittorrent code

# Screenshot tools
echo "Installing screenshot tools..."
sudo pacman -S --needed --noconfirm \
    grim slurp swappy flameshot

# Desktop apps
echo "Installing desktop applications..."
sudo pacman -S --needed --noconfirm \
    dolphin cosmic-term playerctl

# Qt dependencies for SDDM themes
echo "Installing Qt dependencies..."
sudo pacman -S --needed --noconfirm \
    qt5-quickcontrols2 qt5-graphicaleffects qt5-svg \
    qt6-declarative qt6-5compat qt6-svg qt6-multimedia qt6-multimedia-ffmpeg

# GStreamer for video playback
echo "Installing GStreamer plugins..."
sudo pacman -S --needed --noconfirm \
    gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly

# Utilities
echo "Installing utilities..."
sudo pacman -S --needed --noconfirm fzf wev

# Install Brave browser (Flatpak)
echo "Installing Brave browser..."
flatpak install -y flathub com.brave.Browser 2>/dev/null || echo "Brave already installed or flatpak not available"

echo ""
echo "=========================================="
echo "Step 2: Configuring System"
echo "=========================================="

# Configure Docker
echo "Configuring Docker..."
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
echo "NOTE: You must log out and back in for Docker group membership to take effect"

# Set system locale to English
echo "Setting system locale to English..."
sudo localectl set-locale \
  LANG=en_US.UTF-8 \
  LC_TIME=en_US.UTF-8 \
  LC_NUMERIC=en_US.UTF-8 \
  LC_MONETARY=en_US.UTF-8 \
  LC_PAPER=en_US.UTF-8 \
  LC_NAME=en_US.UTF-8 \
  LC_ADDRESS=en_US.UTF-8 \
  LC_TELEPHONE=en_US.UTF-8 \
  LC_MEASUREMENT=en_US.UTF-8 \
  LC_IDENTIFICATION=en_US.UTF-8
echo "NOTE: You must log out and back in for locale changes to take effect"

echo ""
echo "=========================================="
echo "Step 3: Restoring COSMIC Configurations"
echo "=========================================="

# Restore COSMIC keybindings
if [ -f config-backups/shortcuts_custom ]; then
    echo "Restoring keybindings..."
    mkdir -p ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/
    cp config-backups/shortcuts_custom \
       ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
    echo "Keybindings restored"
else
    echo "WARNING: Keybindings backup not found"
fi

# Restore keyboard config
if [ -f config-backups/xkb_config ]; then
    echo "Restoring keyboard config..."
    mkdir -p ~/.config/cosmic/com.system76.CosmicComp/v1/
    cp config-backups/xkb_config \
       ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config
    echo "Keyboard config restored"
else
    echo "WARNING: Keyboard config backup not found"
fi

# Restore screenshot script
if [ -f scripts/screenshot ]; then
    echo "Installing screenshot script..."
    mkdir -p ~/.local/bin
    cp scripts/screenshot ~/.local/bin/
    chmod +x ~/.local/bin/screenshot
    echo "Screenshot script installed"
else
    echo "WARNING: Screenshot script not found"
fi

echo ""
echo "=========================================="
echo "Step 4: Setting Up Autostart Applications"
echo "=========================================="

# Restore autostart files
if [ -f autostart/copyq.desktop ]; then
    echo "Setting up CopyQ autostart..."
    mkdir -p ~/.config/autostart
    cp autostart/copyq.desktop ~/.config/autostart/
    echo "CopyQ autostart configured"
else
    echo "WARNING: CopyQ autostart file not found"
fi

if [ -f autostart/qbittorrent-autostart.desktop ]; then
    echo "Setting up qBittorrent autostart..."
    mkdir -p ~/.config/autostart
    cp autostart/qbittorrent-autostart.desktop ~/.config/autostart/
    echo "qBittorrent autostart configured"
else
    echo "WARNING: qBittorrent autostart file not found"
fi

# Configure CopyQ
echo "Configuring CopyQ..."
copyq &
sleep 2
copyq config autostart true 2>/dev/null || echo "CopyQ not running, will configure on first start"
copyq config check_clipboard true 2>/dev/null
copyq config check_selection true 2>/dev/null
copyq config activate_closes true 2>/dev/null
copyq config activate_focuses true 2>/dev/null

echo ""
echo "=========================================="
echo "Step 5: SDDM Theme (Optional)"
echo "=========================================="

read -p "Install SDDM theme (Honkai: Star Rail)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f system/sddm.conf ]; then
        echo "Installing SDDM config..."
        sudo cp system/sddm.conf /etc/sddm.conf
        echo "SDDM config installed"
        echo ""
        echo "NOTE: You need to install the theme separately:"
        echo "  git clone https://github.com/Darkkal44/qylock.git ~/repos/qylock"
        echo "  chmod +x ~/repos/qylock/sddm.sh"
        echo "  ~/repos/qylock/sddm.sh"
        echo "  Select: star-rail"
    else
        echo "WARNING: SDDM config not found"
    fi
fi

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "What was installed:"
echo "  - All required packages (Docker, Obsidian, VS Code, CopyQ, qBittorrent, etc.)"
echo "  - Screenshot tools (Flameshot, grim, slurp, swappy)"
echo "  - COSMIC keybindings and keyboard config"
echo "  - Autostart applications (CopyQ, qBittorrent)"
echo "  - Screenshot script"
echo ""
echo "IMPORTANT - Next Steps:"
echo "  1. LOG OUT AND BACK IN (required for Docker and locale changes)"
echo "  2. After logging back in, restart COSMIC:"
echo "     killall cosmic-settings-daemon && cosmic-settings-daemon &"
echo "     cosmic-comp --replace &"
echo ""
echo "Optional configurations:"
echo "  - Battery management (TLP): See docs/ADDITIONAL_CONFIGS.md"
echo "  - qBittorrent port forwarding: See docs/ADDITIONAL_CONFIGS.md"
echo "  - SDDM theme installation: See above notes"
echo ""
echo "For full documentation, see:"
echo "  - README.md - Main documentation"
echo "  - docs/COSMIC_SETUP_GUIDE.md - Detailed setup guide"
echo "  - docs/BUTTON_CONFIG_REFERENCE.md - Configure buttons"
echo "  - docs/QUICK_REFERENCE.md - Quick reference card"
echo ""
