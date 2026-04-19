# COSMIC Desktop Configuration

Complete backup and documentation for COSMIC Desktop Environment on CachyOS.

**System**: CachyOS + COSMIC Desktop (Wayland)  
**Last Updated**: April 10, 2026

---

##  Repository Structure

```
cosmic-config/
├── README.md                    # This file
├── install.sh                   # Complete fresh install (packages + configs)
├── restore-configs.sh           # Restore configs only
├── sync-configs.sh              # Sync configs from system to repo
│
├── docs/                        # All documentation
│   ├── COSMIC_SETUP_GUIDE.md   # Complete setup guide (30 min install)
│   ├── TERMINAL_SETUP_GUIDE.md # Terminal setup (Ghostty, Bash, Tmux)
│   ├── BUTTON_CONFIG_REFERENCE.md  # Configure buttons (screenshot, pause, lock, etc.)
│   ├── ADDITIONAL_CONFIGS.md   # Battery management, qBittorrent fixes
│   ├── LAZYGIT_GUIDE.md        # Git made easy with lazygit
│   ├── RCLONE_GUIDE.md         # Mount Google Drive with rclone
│   ├── SNAPSHOT_GUIDE.md       # Btrfs snapshot management with Snapper
│   ├── SDDM_THEME_GUIDE.md     # Change SDDM login screen themes
│   └── QUICK_REFERENCE.md      # Quick lookup card
│
├── config-backups/              # COSMIC configuration backups
│   ├── cosmic_shortcuts.ron    # Custom keybindings
│   ├── cosmic_keyboard_config  # Keyboard repeat settings
│   ├── shortcuts_custom        # (copy for restoration)
│   ├── xkb_config             # (copy for restoration)
│   ├── ghostty-config         # Ghostty terminal config
│   ├── bashrc                 # Bash shell config
│   ├── bash_profile           # Bash profile
│   └── tmux.conf              # Tmux multiplexer config
│
├── scripts/                     # Utility scripts
│   ├── screenshot              # Screenshot tool (grim+slurp+swappy)
│   ├── setup-rclone.sh         # Automated Google Drive setup with rclone
│   └── snapshot-manager.sh     # Btrfs snapshot management with Snapper
│
├── autostart/                   # Autostart applications
│   ├── copyq.desktop           # Clipboard manager
│   └── qbittorrent-autostart.desktop  # Torrent client
│
└── system/                      # System-level configs
    └── sddm.conf               # Display manager (Honkai Star Rail theme)
```

---

##  Quick Start

### Fresh Install (Complete Setup)

```bash
# 1. Clone repository
git clone <your-repo-url> ~/cosmic-config
cd ~/cosmic-config

# 2. Run complete installation script
./install.sh

# 3. Log out and back in
# 4. Done! Your COSMIC desktop is fully configured
```

### Restore Configs Only (Packages Already Installed)

```bash
cd ~/cosmic-config
./restore-configs.sh
```

### Backup Current Configs

```bash
cd ~/cosmic-config
./sync-configs.sh
git add .
git commit -m "Update configs"
git push
```

---

##  Documentation

### [COSMIC Setup Guide](docs/COSMIC_SETUP_GUIDE.md)
Complete guide from fresh install to fully configured system in ~30 minutes.

**Includes**:
- Step-by-step installation
- All keybindings reference
- Installed applications
- Troubleshooting

### [Terminal Setup Guide](docs/TERMINAL_SETUP_GUIDE.md)
Complete terminal configuration with Ghostty, Bash, and Tmux.

**Includes**:
- Ghostty terminal emulator setup
- Bash aliases and customization
- Tmux session management
- Integration with COSMIC Desktop
- Workflow examples

### [Button Configuration Reference](docs/BUTTON_CONFIG_REFERENCE.md)
How to configure special buttons in COSMIC Desktop.

**Covers**:
- Screenshot (Print Screen)
- Media controls (Pause, Play, Next, Previous)
- Lock screen (End key)
- Volume & brightness controls
- Finding key names with `wev`
- Complete working examples

### [Additional Configurations](docs/ADDITIONAL_CONFIGS.md)
System optimizations and fixes.

**Includes**:
- Battery management (TLP - limit charging to 80%)
- qBittorrent port forwarding fix
- Git repository organization

### [Lazygit Guide](docs/LAZYGIT_GUIDE.md)
Complete guide to using lazygit - git made easy with a terminal UI.

### [Rclone Guide](docs/RCLONE_GUIDE.md)
Mount Google Drive(s) on your desktop with rclone.

**Includes**:
- Automated setup script
- Multiple Google Drive accounts
- Autostart configuration
- Performance optimization
- Troubleshooting

### [Snapshot Guide](docs/SNAPSHOT_GUIDE.md)
Manage system snapshots with Snapper on Btrfs.

**Includes**:
- Snapshot creation and management
- Pin important snapshots
- Restore system to previous state
- Automatic snapshots before updates
- Disk space management
- Snapshot limit configuration (10 max)

### [SDDM Theme Guide](docs/SDDM_THEME_GUIDE.md)
Change SDDM login screen themes.

**Includes**:
- Install new themes with qylock
- Switch between installed themes
- Customize theme settings
- Troubleshooting theme issues
- SDDM vs lockscreen differences

### [Quick Reference](docs/QUICK_REFERENCE.md)
One-page quick lookup for keybindings and commands. Print this!

---

##  Essential Keybindings

### Applications
| Key | Action |
|-----|--------|
| `Super+T` | Terminal |
| `Super+B` | Browser (Brave) |
| `Super+F` | File Manager (Dolphin) |
| `Super+K` | VS Code |
| `Super+Space` | Launcher |
| `Super+C` | Clipboard Manager |

### System
| Key | Action |
|-----|--------|
| `Print Screen` | Screenshot |
| `End` | Lock Screen |
| `Pause` | Play/Pause Media |
| `Super+Escape` | Logout |
| `Super+Delete` | Shutdown |

### Window Management
- `Super+Arrow Keys` - Tile window to edges
- `Super+W` - Overview mode (all windows/workspaces)
- `Super+S` - Stack windows as tabs
- `Alt+Tab` - Switch windows

### Workspaces
- `Super+1,2,3...` - Switch to workspace
- `Super+Shift+1,2,3...` - Move window to workspace

---

##  Configuration Files

### COSMIC Keybindings
**Location**: `~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom`  
**Backup**: `config-backups/shortcuts_custom`

Custom keyboard shortcuts for applications and system actions.

### Keyboard Settings
**Location**: `~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config`  
**Backup**: `config-backups/xkb_config`

Optimized keyboard repeat rate (200ms delay, 50 rate).

### Screenshot Script
**Location**: `~/.local/bin/screenshot`  
**Backup**: `scripts/screenshot`

Backup screenshot tool using grim, slurp, and swappy.

### Autostart Applications
**Location**: `~/.config/autostart/`  
**Backup**: `autostart/`

- CopyQ: Clipboard manager with persistent history
- qBittorrent: Starts minimized to tray

### SDDM Theme
**Location**: `/etc/sddm.conf`  
**Backup**: `system/sddm.conf`

Display manager with Honkai: Star Rail theme.

---

##  Quick Commands

### Restart COSMIC
```bash
cosmic-comp --replace &
killall cosmic-settings-daemon && cosmic-settings-daemon &
```

### Test Screenshot
```bash
QT_QPA_PLATFORM=wayland flameshot gui
```

### Test Media Control
```bash
playerctl play-pause
```

### Check Clipboard
```bash
copyq toggle
```

---

##  Installed Applications

### Development
- Docker & docker-compose
- VS Code
- Obsidian
- lazygit

### Terminal
- Ghostty (GPU-accelerated terminal)
- Bash (customized shell)
- Tmux (session multiplexer)

### System Tools
- CopyQ (clipboard manager)
- qBittorrent (torrent client)
- Flameshot (screenshots)
- playerctl (media control)

### Desktop
- cosmic-term (terminal)
- Ghostty (alternative terminal)
- Dolphin (file manager)
- Brave (browser - Flatpak)
- cosmic-edit (text editor)

---

##  Quick Troubleshooting

### Keybindings Not Working
```bash
killall cosmic-settings-daemon && cosmic-settings-daemon &
```

### Screenshot Not Working
```bash
QT_QPA_PLATFORM=wayland flameshot gui
```

### CopyQ Not Starting
```bash
copyq &
copyq config autostart true
```

### Docker Permission Denied
```bash
sudo usermod -aG docker $USER
# Log out and back in
```

---

##  Backup & Restore

### Create Backup Archive
```bash
cd ~/cosmic-config
tar -czf cosmic-backup-$(date +%Y%m%d-%H%M%S).tar.gz \
  config-backups/ scripts/ autostart/ system/ docs/ *.md *.sh
```

### Restore from Archive
```bash
tar -xzf cosmic-backup-YYYYMMDD-HHMMSS.tar.gz
cd cosmic-config
./restore-configs.sh
```

---

##  System Summary

**OS**: CachyOS  
**DE**: COSMIC (Wayland)  
**DM**: SDDM (Honkai: Star Rail theme)  
**Terminal**: Ghostty + cosmic-term  
**Shell**: Bash (customized)  
**Multiplexer**: Tmux  
**File Manager**: Dolphin  
**Browser**: Brave (Flatpak)  
**Clipboard**: CopyQ  
**Screenshots**: Flameshot + grim/slurp/swappy  

**Setup Time**: ~30 minutes  
**Custom Keybindings**: 14 shortcuts  
**Keyboard Response**: Optimized (200ms delay, 50 rate)  

---

##  Useful Links

- [COSMIC Desktop](https://github.com/pop-os/cosmic-epoch)
- [CachyOS](https://cachyos.org/)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [Flameshot](https://flameshot.org/)
- [CopyQ](https://hluk.github.io/CopyQ/)

---

**For detailed documentation, see the [docs/](docs/) folder.**
