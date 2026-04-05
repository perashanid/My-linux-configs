# Complete COSMIC Desktop Setup Guide

**Created**: April 9, 2026  
**System**: CachyOS with COSMIC Desktop  
**Total Setup Time**: ~30 minutes

This guide contains ALL configurations, keybindings, and steps to replicate your entire COSMIC desktop setup from scratch.

---

##  Backup Files in This Workspace

All configuration files needed for restoration:

1. `cosmic_shortcuts.ron` - All custom keybindings
2. `cosmic_keyboard_config` - Keyboard repeat settings (200ms delay, 50 rate)
3. `sddm.conf` - SDDM display manager config (Honkai Star Rail theme)
4. `screenshot` - Screenshot script (grim+slurp+swappy)
5. `copyq.desktop` - CopyQ clipboard manager autostart
6. `qbittorrent-autostart.desktop` - qBittorrent autostart (minimized to tray)
7. `ADDITIONAL_CONFIGS.md` - Battery management (TLP) and qBittorrent port forwarding fixes
8. `LAZYGIT_GUIDE.md` - Complete guide to using lazygit for easy git management

---

##  Fresh Install: Step-by-Step

### Step 1: Install All Required Packages

```bash
# Essential applications
sudo pacman -S docker docker-compose obsidian copyq qbittorrent

# Screenshot tools
sudo pacman -S grim slurp swappy flameshot

# Desktop apps
sudo pacman -S dolphin cosmic-term playerctl

# Qt dependencies for SDDM themes
sudo pacman -S qt5-quickcontrols2 qt5-graphicaleffects qt5-svg
sudo pacman -S qt6-declarative qt6-5compat qt6-svg qt6-multimedia qt6-multimedia-ffmpeg

# GStreamer for video playback
sudo pacman -S gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly

# Utilities
sudo pacman -S fzf wev

# Install Brave browser (Flatpak)
flatpak install flathub com.brave.Browser
```

### Step 2: Configure Docker

```bash
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# IMPORTANT: Log out and back in for group membership to take effect
```

### Step 3: Set System Locale to English

```bash
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

# Log out and back in for changes to take effect
```

### Step 4: Restore COSMIC Keybindings

```bash
mkdir -p ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/
cp cosmic_shortcuts.ron ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
```

### Step 5: Restore Keyboard Settings

```bash
mkdir -p ~/.config/cosmic/com.system76.CosmicComp/v1/
cp cosmic_keyboard_config ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config
```

### Step 6: Install Screenshot Script

```bash
mkdir -p ~/.local/bin
cp screenshot ~/.local/bin/
chmod +x ~/.local/bin/screenshot
```

### Step 7: Setup Autostart Applications

```bash
mkdir -p ~/.config/autostart
cp copyq.desktop ~/.config/autostart/
cp qbittorrent-autostart.desktop ~/.config/autostart/
```

### Step 8: Configure CopyQ (Clipboard Manager)

```bash
# Start CopyQ first
copyq &

# Configure CopyQ settings
copyq config autostart true
copyq config check_clipboard true
copyq config check_selection true
copyq config activate_closes true
copyq config activate_focuses true
```

### Step 9: Configure qBittorrent

**Manual steps required:**
1. Open qBittorrent
2. Go to Tools → Options → Behavior
3. Check "Start qBittorrent minimized"
4. Check "Close qBittorrent to notification area"
5. Go to Tools → Options → Advanced
6. Set "Resume data save interval" to 1 minute
7. Click OK

### Step 10: Install SDDM Theme (Honkai: Star Rail)

```bash
# Clone qylock themes repository
git clone https://github.com/Darkkal44/qylock.git ~/qylock

# Run installation script
chmod +x ~/qylock/sddm.sh
~/qylock/sddm.sh
# When prompted, select: star-rail

# Or manually copy SDDM config
sudo cp sddm.conf /etc/sddm.conf
```

### Step 11: Restart COSMIC

```bash
# Restart compositor to apply all changes
cosmic-comp --replace &

# Or log out and back in for full effect
```

---

##  Complete Keybindings Reference

### Applications (Super + Key)
| Keybinding | Action | Application |
|------------|--------|-------------|
| **Super+T** | Terminal | cosmic-term |
| **Super+B** | Browser | Brave (Flatpak) |
| **Super+F** | File Manager | Dolphin |
| **Super+N** | Notebook/Editor | cosmic-edit |
| **Super+K** | IDE | VS Code |
| **Super+Space** | Launcher | cosmic-launcher |
| **Super+C** | Clipboard Manager | CopyQ |

### System Actions
| Keybinding | Action | Command |
|------------|--------|---------|
| **Super+Escape** | Logout | pkill -9 cosmic-session |
| **Super+Delete** | Shutdown | systemctl poweroff |
| **End** | Lock Screen | loginctl lock-sessions |
| **Print Screen** | Screenshot | Flameshot (Wayland) |

### Media Controls
| Keybinding | Action | Command |
|------------|--------|---------|
| **Pause** | Play/Pause | playerctl play-pause |
| **Super+P** | Play/Pause (backup) | playerctl play-pause |

**Note**: Media keys work with all players (Brave, Spotify, VLC, etc.)

### Built-in COSMIC Shortcuts

#### Window Management
- **Super+Arrow Keys** - Tile window to edges (Up/Down/Left/Right)
- **Super+Shift+Arrow Keys** - Move window between tiles
- **Super+S** - Stack windows as tabs
- **Super+W** - Overview mode (see all windows and workspaces)
- **Double-click title bar** - Toggle maximize
- **F11** - Fullscreen (in most apps)

#### Workspace Navigation
- **Super+1, 2, 3, 4...** - Switch to workspace 1, 2, 3, 4...
- **Super+Shift+1, 2, 3...** - Move window to workspace 1, 2, 3...
- **Super+Ctrl+Left/Right** - Previous/Next workspace

#### Window Switching
- **Alt+Tab** - Switch between windows
- **Alt+Shift+Tab** - Switch windows in reverse
- **Super+Tab** - Switch between apps

---

##  Installed Applications

### Development Tools
- **Docker** (with docker-compose) - Container platform
- **Obsidian** - Note-taking and knowledge management
- **VS Code** - Code editor
- **lazygit** - Terminal UI for git (makes git easy and visual)

### System Tools
- **CopyQ** - Clipboard manager with persistent history (text & images)
- **qBittorrent** - Torrent client (auto-starts minimized to tray)
- **Flameshot** - Screenshot tool with annotation
- **playerctl** - Media player controller

### Desktop Applications
- **cosmic-term** - Terminal emulator
- **Dolphin** - File manager
- **Brave** - Privacy-focused browser (Flatpak)
- **cosmic-edit** - Text editor

---

## ⚙ System Configuration Details

### Keyboard Settings
- **Repeat delay**: 200ms (default was 600ms)
- **Repeat rate**: 50 keys/sec (default was 25)
- **Result**: Much faster and more responsive typing
- **Location**: `~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config`

### Locale Settings
- **Changed from**: Bengali (bn_BD)
- **Changed to**: English (en_US.UTF-8)
- **Affects**: System text, time, dates, numbers, measurements
- **Command**: `sudo localectl set-locale LANG=en_US.UTF-8`

### Screenshot Configuration
- **Tool**: Flameshot with Wayland support
- **Command**: `QT_QPA_PLATFORM=wayland flameshot gui`
- **Features**: Area selection, annotation, editing
- **Keybinding**: Print Screen
- **Backup script**: `~/.local/bin/screenshot` (grim+slurp+swappy)

### Docker Configuration
- **Service**: Enabled and running (`systemctl enable --now docker`)
- **User access**: Added to docker group (no sudo needed)
- **Requires**: Logout/login after group addition

### CopyQ Configuration
- **Autostart**: Enabled with 2-second delay
- **Monitors**: Clipboard and selection
- **Toggle behavior**: Super+C shows/hides window
- **History**: Persistent across reboots
- **Supports**: Text and images

### qBittorrent Configuration
- **Autostart**: Enabled, starts minimized to system tray
- **Resume data**: Saved every 1 minute
- **Behavior**: Closes to tray instead of exiting
- **Result**: Downloads resume after logout/restart

### SDDM Theme
- **Theme**: Honkai: Star Rail (from qylock repository)
- **Location**: `/usr/share/sddm/themes/star-rail/`
- **Shows on**: Logout, restart, boot
- **Lock screen**: Uses COSMIC's built-in lock (not SDDM)

---

## 🗑 Removed Applications

Cleaned up to save space (~551 MB total):

### Terminals
- alacritty, foot, konsole, kitty
- **Kept**: cosmic-term

### File Managers
- nautilus, thunar (with plugins)
- **Kept**: Dolphin

### Browsers
- firefox
- **Kept**: Brave (Flatpak)

### Screenshot Tools
- spectacle, scrot
- **Kept**: Flameshot, grim+slurp+swappy

### Other
- rofi (using COSMIC's built-in launcher)
- cliphist (replaced with CopyQ)
- Sway and Hyprland configs (only using COSMIC, Niri, Plasma)

---

##  Troubleshooting

### Keybindings Not Working

```bash
# Method 1: Restart settings daemon
killall cosmic-settings-daemon
cosmic-settings-daemon &

# Method 2: Restart compositor
cosmic-comp --replace &

# Method 3: Log out and back in
```

### CopyQ Not Starting or Working

```bash
# Check if running
ps aux | grep copyq

# Start manually
copyq &

# Enable autostart
copyq config autostart true

# Test toggle
copyq toggle

# If still not working, reconfigure
copyq config check_clipboard true
copyq config check_selection true
copyq config activate_closes true
copyq config activate_focuses true
```

### Screenshot Not Working

```bash
# Test Flameshot manually
QT_QPA_PLATFORM=wayland flameshot gui

# Test backup script
~/.local/bin/screenshot

# Check if tools are installed
which grim slurp swappy flameshot

# Install if missing
sudo pacman -S grim slurp swappy flameshot
```

### SDDM Theme Not Showing

```bash
# Verify theme is installed
ls /usr/share/sddm/themes/star-rail

# Check SDDM config
cat /etc/sddm.conf
# Should show: Current=star-rail

# If wrong, fix it
sudo sed -i 's/Current=.*/Current=star-rail/' /etc/sddm.conf

# Restart to see changes (theme shows on logout/boot)
```

### Media Keys Not Working

```bash
# Test playerctl
playerctl play-pause

# Check if any players are detected
playerctl --list-all

# If no players, start one (e.g., Brave with media)

# Install if missing
sudo pacman -S playerctl
```

### Docker Permission Denied

```bash
# Check if user is in docker group
groups | grep docker

# If not, add user
sudo usermod -aG docker $USER

# MUST log out and back in for this to take effect
```

### qBittorrent Not Resuming Downloads

1. Open qBittorrent
2. Go to Tools → Options → Advanced
3. Set "Resume data save interval" to 1 minute
4. Click OK
5. Downloads will now resume after logout (may lose up to 1 minute of progress)

---

##  Configuration File Locations

### COSMIC Settings
- **Keybindings**: `~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom`
- **Keyboard config**: `~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config`
- **Panel settings**: `~/.config/cosmic/com.system76.CosmicPanel.Panel/v1/`
- **Dock settings**: `~/.config/cosmic/com.system76.CosmicPanel.Dock/v1/`

### Autostart Applications
- **Location**: `~/.config/autostart/`
- **Files**: `copyq.desktop`, `qbittorrent-autostart.desktop`

### User Scripts
- **Screenshot**: `~/.local/bin/screenshot`

### System Configuration
- **SDDM**: `/etc/sddm.conf`
- **Locale**: System-wide (managed by `localectl`)

---

##  Backup and Restore

### Create Backup Archive

```bash
# From the workspace directory
cd ~/others/chat/
tar -czf cosmic-setup-backup-$(date +%Y%m%d).tar.gz \
  cosmic_shortcuts.ron \
  cosmic_keyboard_config \
  sddm.conf \
  screenshot \
  copyq.desktop \
  qbittorrent-autostart.desktop \
  COSMIC_SETUP_GUIDE.md

# Backup is created: cosmic-setup-backup-YYYYMMDD.tar.gz
```

### Restore from Backup

```bash
# Extract backup
tar -xzf cosmic-setup-backup-YYYYMMDD.tar.gz
cd cosmic-setup-backup/

# Follow Steps 1-11 in the "Fresh Install" section above
```

---

##  Customization Tips

### Change SDDM Theme Wallpaper

```bash
sudo cp your-wallpaper.jpg /usr/share/sddm/themes/star-rail/assets/images/background.jpg
```

### Change SDDM Theme Avatar

```bash
sudo cp your-avatar.jpg /usr/share/sddm/themes/star-rail/assets/images/avatar.jpg
```

### Add Custom Keybindings

1. Edit `cosmic_shortcuts.ron`
2. Add new entry following the existing format:
```ron
(
    modifiers: [Super],
    key: "x",
    description: Some("my custom app"),
): Spawn("command-to-run"),
```
3. Apply changes:
```bash
cp cosmic_shortcuts.ron ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
killall cosmic-settings-daemon; cosmic-settings-daemon &
```

### Adjust Keyboard Speed

Edit `~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config`:
- `repeat_delay`: Lower = faster initial repeat (default: 600, current: 200)
- `repeat_rate`: Higher = faster repeat (default: 25, current: 50)

---

##  Tips & Tricks

### Window Management
- Use **Super+S** to stack multiple windows as tabs
- Use **Super+W** to see all windows across all workspaces
- Double-click title bar to maximize/restore
- Drag window to screen edges to auto-tile

### Workspace Workflow
- Organize by task: Workspace 1 for coding, 2 for browsing, 3 for communication
- Use **Super+Shift+Number** to move windows between workspaces
- Workspaces are created automatically when you switch to them
- No limit on number of workspaces

### Clipboard Manager (CopyQ)
- Press **Super+C** to toggle clipboard history
- Search through history with **Ctrl+F**
- Pin frequently used items (right-click → Pin)
- Clear history: Right-click → Remove All
- Supports text and images
- History persists across reboots

### Screenshot Workflow
- Press **Print Screen** for Flameshot GUI
- Select area, annotate, save or copy
- Backup: Run `~/.local/bin/screenshot` for grim+slurp+swappy

### Performance Optimizations
- Keyboard repeat settings optimized for fast response
- Removed ~551 MB of unused applications
- Docker runs as a service (always available)
- qBittorrent starts minimized to save resources
- CopyQ runs in background (minimal resource usage)

---

##  Emergency Recovery

### Reset COSMIC Keybindings to Defaults

```bash
rm ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
# COSMIC will use default keybindings
# Restart compositor: cosmic-comp --replace &
```

### Reset Keyboard Settings to Defaults

```bash
rm ~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config
# COSMIC will recreate with default settings
```

### Reset SDDM Theme to Default

```bash
sudo sed -i 's/Current=.*/Current=breeze/' /etc/sddm.conf
# Default theme will show on next logout/boot
```

### Reset Locale to System Default

```bash
sudo localectl set-locale LANG=C
# Log out and back in
```

---

##  Important Notes

- **All keybindings use Super key** (Windows/Command key) as primary modifier
- **COSMIC uses dynamic workspaces** - created automatically when needed
- **No traditional minimize** - use workspaces or window stacking instead
- **Window tiling is automatic** - keyboard-driven, no manual resizing needed
- **Clipboard history is persistent** - saved by CopyQ across reboots
- **Flatpak apps** (like Brave) may take longer to start than native packages
- **Docker requires logout** after adding user to docker group
- **SDDM theme requires Qt6** dependencies to display properly
- **Media keys work globally** via playerctl (all players supported)
- **Lock screen is COSMIC's** - SDDM theme only shows on logout/boot
- **qBittorrent saves state** every 1 minute to handle instant logout

---

##  System Summary

**Operating System**: CachyOS  
**Desktop Environment**: COSMIC (Wayland)  
**Display Manager**: SDDM (with Honkai: Star Rail theme)  
**Terminal**: cosmic-term  
**File Manager**: Dolphin  
**Browser**: Brave (Flatpak)  
**Editor**: cosmic-edit  
**IDE**: VS Code  
**Clipboard Manager**: CopyQ  
**Screenshot Tool**: Flameshot + grim/slurp/swappy  
**Media Control**: playerctl  

**Total Configuration Time**: ~30 minutes  
**Space Saved**: ~551 MB (removed unused apps)  
**Keyboard Response**: Optimized (200ms delay, 50 rate)  
**Locale**: English (en_US.UTF-8)  

---

**End of Guide**

For additional configurations (battery management, qBittorrent fixes, etc.), see `ADDITIONAL_CONFIGS.md`.

For a complete guide to using lazygit (easy git management), see `LAZYGIT_GUIDE.md`.

For questions or issues, refer to the Troubleshooting section above.
