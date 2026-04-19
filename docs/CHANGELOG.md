# Configuration Changelog

## April 19, 2026 - Terminal Setup Added

### New Configurations

Added complete terminal setup with Ghostty, Bash, and Tmux:

#### Configuration Files
- `config-backups/ghostty-config` - Ghostty terminal emulator settings
- `config-backups/bashrc` - Bash shell configuration with aliases
- `config-backups/bash_profile` - Bash profile loader
- `config-backups/tmux.conf` - Tmux multiplexer configuration

#### Documentation
- `docs/TERMINAL_SETUP_GUIDE.md` - Complete terminal setup guide
  - Ghostty configuration (theme, clipboard, performance)
  - Bash aliases and customization
  - Tmux keybindings and workflow examples
  - Integration with COSMIC Desktop
  - Troubleshooting guide

#### Updated Files
- `install.sh` - Added Ghostty, Bash, Tmux installation and config restoration
- `sync-configs.sh` - Added terminal config syncing
- `restore-configs.sh` - Added terminal config restoration
- `README.md` - Added terminal setup documentation links
- `docs/QUICK_REFERENCE.md` - Added terminal quick reference section

### Features

#### Ghostty Terminal
- GPU-accelerated rendering
- Dark blue theme matching COSMIC
- Transparent background (92% opacity)
- 100,000 line scrollback buffer
- Disabled bracketed paste for compatibility

#### Bash Configuration
- Developer aliases (ll, la, gs, ga, gc, gp, gl)
- Enhanced history (10,000 commands, no duplicates)
- Colored output for ls and grep
- Custom PATH with ~/.local/bin and npm global

#### Tmux Configuration
- Mouse support enabled
- Vi mode for copy/paste
- Custom split keybindings (|, -, h, v)
- Matching dark blue theme
- Windows/panes start at 1

### Installation

```bash
# Fresh install (includes terminal setup)
./install.sh

# Restore only terminal configs
./restore-configs.sh

# Sync terminal configs to repo
./sync-configs.sh
```

### Documentation

See [TERMINAL_SETUP_GUIDE.md](TERMINAL_SETUP_GUIDE.md) for complete documentation.

---

## Previous Updates

### April 10, 2026 - Initial Setup
- COSMIC Desktop configuration
- Custom keybindings
- Autostart applications
- Screenshot tools
- SDDM theme
- Complete documentation

