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

# Sync screenshot script
if [ -f ~/.local/bin/screenshot ]; then
    cp ~/.local/bin/screenshot scripts/
    echo " Synced screenshot script"
else
    echo "  Screenshot script not found"
fi

# Sync SDDM config (requires sudo)
if [ -f /etc/sddm.conf ]; then
    sudo cp /etc/sddm.conf system/
    sudo chown $USER:$USER system/sddm.conf
    echo " Synced SDDM config"
else
    echo "  SDDM config file not found"
fi

echo ""
echo " Sync complete!"
echo ""
echo "Next steps:"
echo "  git add ."
echo "  git commit -m 'Update configs'"
echo "  git push"
