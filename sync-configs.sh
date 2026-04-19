#!/bin/bash
# Sync COSMIC configs from system to repository

echo " Syncing COSMIC configs to repository..."

# Create directories if they don't exist
mkdir -p config-backups scripts autostart system

# Sync COSMIC keybindings
if [ -f ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom ]; then
    cp ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom \
       config-backups/shortcuts_custom
    cp ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom \
       config-backups/cosmic_shortcuts.ron
    echo " Synced keybindings"
else
    echo "  Keybindings file not found"
fi

# Sync keyboard config
if [ -f ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config ]; then
    cp ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config \
       config-backups/xkb_config
    cp ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config \
       config-backups/cosmic_keyboard_config
    echo " Synced keyboard config"
else
    echo "  Keyboard config file not found"
fi

# Sync autostart files
if [ -f ~/.config/autostart/copyq.desktop ]; then
    cp ~/.config/autostart/copyq.desktop autostart/
    echo " Synced CopyQ autostart"
else
    echo "  CopyQ autostart file not found"
fi

if [ -f ~/.config/autostart/qbittorrent-autostart.desktop ]; then
    cp ~/.config/autostart/qbittorrent-autostart.desktop autostart/
    echo " Synced qBittorrent autostart"
else
    echo "  qBittorrent autostart file not found"
fi

if [ -f ~/.config/autostart/waybar.desktop ]; then
    cp ~/.config/autostart/waybar.desktop autostart/
    echo " Synced Waybar autostart"
else
    echo "  Waybar autostart file not found"
fi

# Sync screenshot script
if [ -f ~/.local/bin/screenshot ]; then
    cp ~/.local/bin/screenshot scripts/
    echo " Synced screenshot script"
else
    echo "  Screenshot script not found"
fi

# Sync Waybar config
if [ -f ~/.config/waybar/config ] && [ -f ~/.config/waybar/style.css ]; then
    cp ~/.config/waybar/config config-backups/waybar-config.json
    cp ~/.config/waybar/style.css config-backups/waybar-style.css
    echo " Synced Waybar config"
else
    echo "  Waybar config not found"
fi

# Sync SDDM config (requires sudo)
if [ -f /etc/sddm.conf ]; then
    sudo cp /etc/sddm.conf system/
    sudo chown $USER:$USER system/sddm.conf
    echo " Synced SDDM config"
else
    echo "  SDDM config file not found"
fi

# Sync terminal configs
echo ""
echo " Syncing terminal configs..."

if [ -f ~/.config/ghostty/config ]; then
    cp ~/.config/ghostty/config config-backups/ghostty-config
    echo " Synced Ghostty config"
else
    echo "  Ghostty config not found"
fi

if [ -f ~/.bashrc ]; then
    cp ~/.bashrc config-backups/bashrc
    echo " Synced Bash config"
else
    echo "  Bash config not found"
fi

if [ -f ~/.bash_profile ]; then
    cp ~/.bash_profile config-backups/bash_profile
    echo " Synced Bash profile"
else
    echo "  Bash profile not found"
fi

if [ -f ~/.tmux.conf ]; then
    cp ~/.tmux.conf config-backups/tmux.conf
    echo " Synced Tmux config"
else
    echo "  Tmux config not found"
fi

echo ""
echo " Sync complete!"
echo ""
echo "Next steps:"
echo "  git add ."
echo "  git commit -m 'Update configs'"
echo "  git push"
