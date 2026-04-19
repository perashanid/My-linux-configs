#!/bin/bash
# Restore COSMIC configs from repository to system

echo " Restoring COSMIC configs from repository..."
echo ""

# Function to ask for confirmation
confirm() {
    read -p "$1 [y/N] " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Restore COSMIC keybindings
if [ -f config-backups/shortcuts_custom ]; then
    if confirm "Restore keybindings?"; then
        mkdir -p ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/
        cp config-backups/shortcuts_custom \
           ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
        echo " Restored keybindings"
    fi
else
    echo "  Keybindings backup not found"
fi

# Restore keyboard config
if [ -f config-backups/xkb_config ]; then
    if confirm "Restore keyboard config?"; then
        mkdir -p ~/.config/cosmic/com.system76.CosmicComp/v1/
        cp config-backups/xkb_config \
           ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config
        echo " Restored keyboard config"
    fi
else
    echo "  Keyboard config backup not found"
fi

# Restore autostart files
if [ -f autostart/copyq.desktop ]; then
    if confirm "Restore CopyQ autostart?"; then
        mkdir -p ~/.config/autostart
        cp autostart/copyq.desktop ~/.config/autostart/
        echo " Restored CopyQ autostart"
    fi
else
    echo "  CopyQ autostart backup not found"
fi

if [ -f autostart/qbittorrent-autostart.desktop ]; then
    if confirm "Restore qBittorrent autostart?"; then
        mkdir -p ~/.config/autostart
        cp autostart/qbittorrent-autostart.desktop ~/.config/autostart/
        echo " Restored qBittorrent autostart"
    fi
else
    echo "  qBittorrent autostart backup not found"
fi

if [ -f autostart/waybar.desktop ]; then
    if confirm "Restore Waybar autostart?"; then
        mkdir -p ~/.config/autostart
        cp autostart/waybar.desktop ~/.config/autostart/
        echo " Restored Waybar autostart"
    fi
else
    echo "  Waybar autostart backup not found"
fi

# Restore Waybar config
if [ -f config-backups/waybar-config.json ] && [ -f config-backups/waybar-style.css ]; then
    if confirm "Restore Waybar configuration?"; then
        mkdir -p ~/.config/waybar
        cp config-backups/waybar-config.json ~/.config/waybar/config
        cp config-backups/waybar-style.css ~/.config/waybar/style.css
        echo " Restored Waybar configuration"
    fi
else
    echo "  Waybar config backup not found"
fi

# Restore screenshot script
if [ -f scripts/screenshot ]; then
    if confirm "Restore screenshot script?"; then
        mkdir -p ~/.local/bin
        cp scripts/screenshot ~/.local/bin/
        chmod +x ~/.local/bin/screenshot
        echo " Restored screenshot script"
    fi
else
    echo "  Screenshot script backup not found"
fi

# Restore SDDM config (requires sudo)
if [ -f system/sddm.conf ]; then
    if confirm "Restore SDDM config? (requires sudo)"; then
        sudo cp system/sddm.conf /etc/sddm.conf
        echo " Restored SDDM config"
    fi
else
    echo "  SDDM config backup not found"
fi

# Restore terminal configs
echo ""
echo " Restoring terminal configurations..."

if [ -f config-backups/ghostty-config ]; then
    if confirm "Restore Ghostty config?"; then
        mkdir -p ~/.config/ghostty
        cp config-backups/ghostty-config ~/.config/ghostty/config
        echo " Restored Ghostty config"
    fi
else
    echo "  Ghostty config backup not found"
fi

if [ -f config-backups/bashrc ]; then
    if confirm "Restore Bash config?"; then
        cp config-backups/bashrc ~/.bashrc
        echo " Restored Bash config"
    fi
else
    echo "  Bash config backup not found"
fi

if [ -f config-backups/bash_profile ]; then
    if confirm "Restore Bash profile?"; then
        cp config-backups/bash_profile ~/.bash_profile
        echo " Restored Bash profile"
    fi
else
    echo "  Bash profile backup not found"
fi

if [ -f config-backups/tmux.conf ]; then
    if confirm "Restore Tmux config?"; then
        cp config-backups/tmux.conf ~/.tmux.conf
        echo " Restored Tmux config"
    fi
else
    echo "  Tmux config backup not found"
fi

echo ""
echo " Restore complete!"
echo ""
echo "Next steps:"
echo "  1. Reload Bash config:"
echo "     source ~/.bashrc"
echo ""
echo "  2. Restart COSMIC settings daemon:"
echo "     killall cosmic-settings-daemon && cosmic-settings-daemon &"
echo ""
echo "  3. Or restart compositor:"
echo "     cosmic-comp --replace &"
echo ""
echo "  4. Or log out and back in for full effect"
