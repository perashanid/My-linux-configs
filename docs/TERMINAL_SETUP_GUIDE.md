# Terminal Setup Guide: Ghostty + Bash + Tmux

**Created**: April 19, 2026  
**Terminal**: Ghostty  
**Shell**: Bash  
**Multiplexer**: Tmux  

Complete documentation for terminal configuration including Ghostty terminal emulator, Bash shell customization, and Tmux session management.

---

## Overview

### What's Included

- **Ghostty**: Modern, fast GPU-accelerated terminal emulator
- **Bash**: Customized shell with developer-friendly aliases and history
- **Tmux**: Terminal multiplexer for managing multiple sessions and panes

### Configuration Files

1. `ghostty-config` - Ghostty terminal settings (theme, font, clipboard)
2. `bashrc` - Bash aliases, history, and environment variables
3. `bash_profile` - Bash profile loader
4. `tmux.conf` - Tmux keybindings, mouse support, and appearance

---

## Installation

### Install Packages

```bash
# Install Ghostty, Bash, and Tmux
sudo pacman -S ghostty bash tmux
```

### Restore Configurations

```bash
# Ghostty config
mkdir -p ~/.config/ghostty
cp config-backups/ghostty-config ~/.config/ghostty/config

# Bash configs
cp config-backups/bashrc ~/.bashrc
cp config-backups/bash_profile ~/.bash_profile

# Tmux config
cp config-backups/tmux.conf ~/.tmux.conf

# Reload Bash
source ~/.bashrc
```

---

## Ghostty Configuration

### Theme & Appearance

```
# Dark blue theme with transparency
background = #0a1628
foreground = #c5d4eb
background-opacity = 0.92

# Font
font-size = 13

# Window padding
window-padding-x = 12
window-padding-y = 12
```

### Clipboard Settings

Bracketed paste is disabled for better compatibility with terminal applications:

```
clipboard-read = allow
clipboard-write = allow
clipboard-paste-protection = false
clipboard-paste-bracketed-safe = false
```

### Performance

```
scrollback-limit = 100000
```

### Features

- GPU-accelerated rendering for smooth performance
- Transparent background (92% opacity)
- Large scrollback buffer (100,000 lines)
- Seamless clipboard integration
- No bracketed paste issues

---

## Bash Configuration

### Developer Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `ll` | `ls -lah` | List all files with details |
| `la` | `ls -A` | List all files (no . and ..) |
| `l` | `ls -CF` | List files in columns |
| `..` | `cd ..` | Go up one directory |
| `...` | `cd ../..` | Go up two directories |

### Git Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `gs` | `git status` | Show git status |
| `ga` | `git add` | Stage files |
| `gc` | `git commit` | Commit changes |
| `gp` | `git push` | Push to remote |
| `gl` | `git log --oneline` | Compact git log |

### History Configuration

```bash
export HISTSIZE=10000           # Commands in memory
export HISTFILESIZE=20000       # Commands in history file
export HISTCONTROL=ignoredups:erasedups  # No duplicates
```

### Colored Output

```bash
alias grep='grep --color=auto'
alias ls='ls --color=auto'
```

### Path Configuration

```bash
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"
```

Adds:
- `~/.local/bin` - User scripts and binaries
- `~/.npm-global/bin` - Global npm packages

### Bracketed Paste

Disabled for better terminal compatibility:
```bash
bind 'set enable-bracketed-paste off'
```

---

## Tmux Configuration

### Prefix Key

```
Ctrl+b (default, most compatible)
```

### Essential Keybindings

| Keybinding | Action |
|------------|--------|
| `Ctrl+b` then `\|` | Split pane vertically |
| `Ctrl+b` then `-` | Split pane horizontally |
| `Ctrl+b` then `h` | Split pane horizontally (alt) |
| `Ctrl+b` then `v` | Split pane vertically (alt) |
| `Ctrl+b` then `r` | Reload tmux config |
| `Ctrl+b` then `arrow keys` | Navigate between panes |
| `Ctrl+b` then `c` | Create new window |
| `Ctrl+b` then `n` | Next window |
| `Ctrl+b` then `p` | Previous window |
| `Ctrl+b` then `d` | Detach from session |
| `Ctrl+b` then `[` | Enter scroll mode (Vi keys) |

### Mouse Support

```
set -g mouse on
```

Features:
- Click to select panes
- Drag to resize panes
- Scroll to navigate history
- Right-click for context menu

### Window & Pane Numbering

```
set -g base-index 1
setw -g pane-base-index 1
```

Windows and panes start at 1 (not 0) for easier keyboard access.

### Vi Mode

```
setw -g mode-keys vi
```

Use Vi keybindings in copy mode:
- `h, j, k, l` - Navigate
- `v` - Start selection
- `y` - Copy selection
- `q` - Exit copy mode

### Theme

```
set -g default-terminal "screen-256color"
set -g status-style bg=#0a1628,fg=#c5d4eb
```

Matches Ghostty's dark blue theme.

---

## Tmux Quick Start

### Basic Session Management

```bash
# Start new session
tmux

# Start named session
tmux new -s mysession

# List sessions
tmux ls

# Attach to session
tmux attach -t mysession

# Detach from session
Ctrl+b then d

# Kill session
tmux kill-session -t mysession
```

### Window Management

```bash
# Create new window
Ctrl+b then c

# Rename window
Ctrl+b then ,

# Switch to window by number
Ctrl+b then 0-9

# Next/previous window
Ctrl+b then n/p

# Close window
Ctrl+b then &
```

### Pane Management

```bash
# Split vertically
Ctrl+b then |

# Split horizontally
Ctrl+b then -

# Navigate panes
Ctrl+b then arrow keys

# Resize panes
Ctrl+b then Ctrl+arrow keys

# Close pane
Ctrl+b then x
```

### Copy Mode (Scrollback)

```bash
# Enter copy mode
Ctrl+b then [

# Navigate with Vi keys
h, j, k, l

# Search
/ (forward) or ? (backward)

# Start selection
v

# Copy selection
y

# Exit copy mode
q

# Paste
Ctrl+b then ]
```

---

## Workflow Examples

### Development Workflow

```bash
# Start tmux session
tmux new -s dev

# Split into 3 panes
Ctrl+b then |  # Split vertically
Ctrl+b then -  # Split horizontally

# Pane 1: Editor (vim/code)
# Pane 2: Server/logs
# Pane 3: Git commands

# Detach when done
Ctrl+b then d

# Reattach later
tmux attach -t dev
```

### Multi-Project Workflow

```bash
# Create sessions for different projects
tmux new -s frontend
tmux new -s backend
tmux new -s database

# List all sessions
tmux ls

# Switch between sessions
tmux attach -t frontend
tmux attach -t backend
```

### Remote Server Workflow

```bash
# SSH into server
ssh user@server

# Start tmux
tmux new -s work

# Do work...

# Detach (connection can drop safely)
Ctrl+b then d

# Exit SSH
exit

# Later: reconnect and reattach
ssh user@server
tmux attach -t work
```

---

## Bash Tips & Tricks

### History Search

```bash
# Search history with Ctrl+r
Ctrl+r
# Type to search, Ctrl+r again for next match

# View recent commands
history | tail -20

# Execute previous command
!!

# Execute command from history
!123  # Run command #123
```

### Quick Navigation

```bash
# Go to home directory
cd ~

# Go to previous directory
cd -

# Go up multiple levels
...  # cd ../..
```

### Git Workflow

```bash
# Quick status check
gs

# Stage all changes
ga .

# Commit with message
gc -m "Update feature"

# Push to remote
gp

# View compact log
gl
```

---

## Troubleshooting

### Ghostty Not Starting

```bash
# Check if installed
which ghostty

# Install if missing
sudo pacman -S ghostty

# Check config syntax
cat ~/.config/ghostty/config
```

### Tmux Config Not Loading

```bash
# Check config file exists
ls -la ~/.tmux.conf

# Reload config manually
tmux source-file ~/.tmux.conf

# Or inside tmux
Ctrl+b then r
```

### Bash Aliases Not Working

```bash
# Reload bashrc
source ~/.bashrc

# Check if aliases are defined
alias

# Verify bashrc is sourced
echo $BASH_VERSION
```

### Clipboard Issues in Ghostty

```bash
# Verify clipboard settings in config
cat ~/.config/ghostty/config | grep clipboard

# Should show:
# clipboard-paste-protection = false
# clipboard-paste-bracketed-safe = false
```

### Tmux Mouse Not Working

```bash
# Check mouse setting
tmux show-options -g | grep mouse

# Should show: mouse on

# If not, add to ~/.tmux.conf:
# set -g mouse on

# Reload config
tmux source-file ~/.tmux.conf
```

### Colors Not Working in Tmux

```bash
# Check TERM variable
echo $TERM

# Should be: screen-256color

# If not, add to ~/.tmux.conf:
# set -g default-terminal "screen-256color"
```

---

## Advanced Configuration

### Custom Tmux Status Bar

Add to `~/.tmux.conf`:

```bash
# Status bar position
set -g status-position bottom

# Status bar content
set -g status-left '[#S] '
set -g status-right '%H:%M %d-%b-%y'

# Window status format
setw -g window-status-current-format ' #I:#W '
setw -g window-status-format ' #I:#W '
```

### Bash Prompt Customization

Add to `~/.bashrc`:

```bash
# Colorful prompt with git branch
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
```

### Tmux Plugin Manager (TPM)

```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add to ~/.tmux.conf:
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TPM (keep at bottom)
run '~/.tmux/plugins/tpm/tpm'

# Install plugins: Ctrl+b then I
```

---

## Configuration File Locations

### Ghostty
- **Config**: `~/.config/ghostty/config`
- **Backup**: `config-backups/ghostty-config`

### Bash
- **Profile**: `~/.bash_profile`
- **RC**: `~/.bashrc`
- **Backups**: `config-backups/bash_profile`, `config-backups/bashrc`

### Tmux
- **Config**: `~/.tmux.conf`
- **Backup**: `config-backups/tmux.conf`

---

## Quick Reference Card

### Bash Aliases
```
ll, la, l          - List files
.., ...            - Navigate up
gs, ga, gc, gp, gl - Git shortcuts
```

### Tmux Essentials
```
Ctrl+b then |/-    - Split panes
Ctrl+b then c      - New window
Ctrl+b then d      - Detach
Ctrl+b then [      - Scroll mode
```

### Ghostty Features
```
Transparent background
GPU acceleration
100k scrollback
No bracketed paste issues
```

---

## Integration with COSMIC Desktop

### Set Ghostty as Default Terminal

```bash
# Update COSMIC keybinding
# Edit: ~/.config/cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom
# Change terminal command from cosmic-term to ghostty
```

### Autostart Tmux in Ghostty

Add to `~/.bashrc`:

```bash
# Auto-start tmux if not already in tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
```

---

## Summary

**Terminal**: Ghostty (GPU-accelerated, transparent, fast)  
**Shell**: Bash (customized aliases, history, colors)  
**Multiplexer**: Tmux (mouse support, Vi mode, custom theme)  

**Key Features**:
- Seamless clipboard integration
- No bracketed paste issues
- Developer-friendly aliases
- Persistent terminal sessions
- Mouse and keyboard navigation
- Matching dark blue theme across all tools

**Configuration Time**: ~5 minutes  
**Files Backed Up**: 4 config files  

---

**For main system documentation, see [README.md](../README.md)**  
**For COSMIC setup, see [COSMIC_SETUP_GUIDE.md](COSMIC_SETUP_GUIDE.md)**

