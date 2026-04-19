# Quick Reference Card

Fast lookup for common tasks and keybindings.

---

##  Essential Keybindings

### Applications
| Key | Action |
|-----|--------|
| `Super+T` | Terminal |
| `Super+B` | Browser (Brave) |
| `Super+F` | File Manager (Dolphin) |
| `Super+N` | Text Editor |
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
| `Super+/` | System Monitor |

### Window Management
| Key | Action |
|-----|--------|
| `Super+Arrow Keys` | Tile window |
| `Super+W` | Overview mode |
| `Super+S` | Stack windows |
| `Alt+Tab` | Switch windows |

### Workspaces
| Key | Action |
|-----|--------|
| `Super+1,2,3...` | Switch workspace |
| `Super+Shift+1,2,3...` | Move window to workspace |

---

##  Terminal Quick Reference

### Bash Aliases
| Alias | Command | Description |
|-------|---------|-------------|
| `ll` | `ls -lah` | List all files |
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |
| `gs` | `git status` | Git status |
| `ga` | `git add` | Git add |
| `gc` | `git commit` | Git commit |
| `gp` | `git push` | Git push |
| `gl` | `git log --oneline` | Compact git log |

### Tmux Essentials
| Key | Action |
|-----|--------|
| `Ctrl+b` then `\|` | Split vertically |
| `Ctrl+b` then `-` | Split horizontally |
| `Ctrl+b` then `c` | New window |
| `Ctrl+b` then `d` | Detach session |
| `Ctrl+b` then `[` | Scroll mode |
| `Ctrl+b` then `arrow` | Navigate panes |

### Tmux Sessions
```bash
tmux new -s name    # Create session
tmux ls             # List sessions
tmux attach -t name # Attach to session
```

---

##  Important File Locations

### COSMIC Configs
```
~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
~/.config/cosmic/com.system76.CosmicComp/v1/xkb_config
```

### Terminal Configs
```
~/.config/ghostty/config
~/.bashrc
~/.bash_profile
~/.tmux.conf
```

### Autostart
```
~/.config/autostart/
```

### Scripts
```
~/.local/bin/
```

### System
```
/etc/sddm.conf
```

---

##  Quick Commands

### Restart COSMIC
```bash
cosmic-comp --replace &
killall cosmic-settings-daemon && cosmic-settings-daemon &
```

### Backup Configs
```bash
cd ~/cosmic-config
./sync-configs.sh
```

### Restore Configs
```bash
cd ~/cosmic-config
./restore-configs.sh
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

##  Package Install Commands

### Essential Apps
```bash
sudo pacman -S docker docker-compose obsidian copyq qbittorrent
```

### Screenshot Tools
```bash
sudo pacman -S grim slurp swappy flameshot
```

### Desktop Apps
```bash
sudo pacman -S dolphin cosmic-term playerctl
```

### Terminal Tools
```bash
sudo pacman -S ghostty bash tmux
```

### Brave Browser
```bash
flatpak install flathub com.brave.Browser
```

---

##  Finding Key Names
```bash
sudo pacman -S wev
wev
# Press key and look for "sym" value
```

---

##  Full Documentation

- **Setup Guide**: [COSMIC_SETUP_GUIDE.md](COSMIC_SETUP_GUIDE.md)
- **Terminal Setup**: [TERMINAL_SETUP_GUIDE.md](TERMINAL_SETUP_GUIDE.md)
- **Button Config**: [BUTTON_CONFIG_REFERENCE.md](BUTTON_CONFIG_REFERENCE.md)
- **Additional Configs**: [ADDITIONAL_CONFIGS.md](ADDITIONAL_CONFIGS.md)
- **Git Guide**: [LAZYGIT_GUIDE.md](LAZYGIT_GUIDE.md)
- **Main Index**: [README.md](README.md)

---

**Print this page for quick reference!**
