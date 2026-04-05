# Rclone Google Drive Setup Guide

Complete guide to mounting Google Drive(s) on COSMIC Desktop using rclone.

---

## Quick Setup

### Automated Installation

```bash
cd ~/cosmic-config
chmod +x scripts/setup-rclone.sh
./scripts/setup-rclone.sh
```

The script will:
1. Install rclone
2. Guide you through adding a Google Drive account
3. Mount your Google Drive automatically

---

## Manual Setup

### 1. Install Rclone

```bash
sudo pacman -S rclone
```

### 2. Configure Google Drive

```bash
rclone config
```

Follow these steps:

1. **New remote**: Type `n` and press Enter
2. **Name**: Enter a name (e.g., `personal`, `work`, `gdrive1`)
3. **Storage type**: Type `24` for Google Drive
4. **Client ID**: Press Enter (leave blank)
5. **Client Secret**: Press Enter (leave blank)
6. **Scope**: Type `1` for full access
7. **Root folder ID**: Press Enter (leave blank)
8. **Service account file**: Press Enter (leave blank)
9. **Advanced config**: Type `n`
10. **Auto config**: Type `y` (browser will open)
11. **Sign in**: Authenticate with your Google account in the browser
12. **Shared Drive**: Type `n` (unless using Google Workspace Team Drive)
13. **Confirm**: Type `y` to save

### 3. Mount Google Drive

```bash
# Create mount directory
mkdir -p ~/GoogleDrive

# Mount the drive
rclone mount personal: ~/GoogleDrive --vfs-cache-mode writes --daemon
```

### 4. Access in File Manager

Open Nemo and navigate to:
```
/home/YOUR_USERNAME/GoogleDrive
```

Or from terminal:
```bash
nemo ~/GoogleDrive
```

---

## Multiple Google Drive Accounts

You can add multiple Google Drive accounts, each with its own mount point.

### Add Another Account

```bash
# Run setup script again
./scripts/setup-rclone.sh

# Or manually
rclone config
# Choose 'n' for new remote
# Give it a different name (e.g., 'work', 'gdrive2')
# Follow the same steps as above
```

### Mount Multiple Drives

```bash
# First account
mkdir -p ~/GoogleDrive1
rclone mount personal: ~/GoogleDrive1 --vfs-cache-mode writes --daemon

# Second account
mkdir -p ~/GoogleDrive2
rclone mount work: ~/GoogleDrive2 --vfs-cache-mode writes --daemon

# Third account
mkdir -p ~/GoogleDrive3
rclone mount gdrive3: ~/GoogleDrive3 --vfs-cache-mode writes --daemon
```

---

## Autostart on Login

### Method 1: Systemd User Service (Recommended)

Create a systemd service for each Google Drive:

```bash
# Create service file
mkdir -p ~/.config/systemd/user
nano ~/.config/systemd/user/rclone-personal.service
```

Add this content (replace `personal` and `GoogleDrive` with your values):

```ini
[Unit]
Description=RClone Mount - Personal Google Drive
After=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/rclone mount personal: %h/GoogleDrive \
    --vfs-cache-mode writes \
    --vfs-cache-max-age 72h \
    --vfs-read-chunk-size 128M \
    --vfs-read-chunk-size-limit off \
    --buffer-size 256M
ExecStop=/usr/bin/fusermount -u %h/GoogleDrive
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
```

Enable and start the service:

```bash
# Enable autostart
systemctl --user enable rclone-personal.service

# Start now
systemctl --user start rclone-personal.service

# Check status
systemctl --user status rclone-personal.service
```

### Method 2: Autostart Desktop Entry

Create an autostart file:

```bash
nano ~/.config/autostart/rclone-personal.desktop
```

Add this content:

```ini
[Desktop Entry]
Type=Application
Name=RClone Mount - Personal
Exec=/usr/bin/rclone mount personal: /home/YOUR_USERNAME/GoogleDrive --vfs-cache-mode writes --daemon
Terminal=false
Hidden=false
X-GNOME-Autostart-enabled=true
```

Make it executable:

```bash
chmod +x ~/.config/autostart/rclone-personal.desktop
```

### Method 3: Simple Script

Create a mount script:

```bash
nano ~/.local/bin/mount-gdrives
```

Add this content:

```bash
#!/bin/bash
# Mount all Google Drives

# Wait for network
sleep 5

# Mount drives
rclone mount personal: ~/GoogleDrive1 --vfs-cache-mode writes --daemon
rclone mount work: ~/GoogleDrive2 --vfs-cache-mode writes --daemon

# Add more as needed
```

Make it executable:

```bash
chmod +x ~/.local/bin/mount-gdrives
```

Add to autostart:

```bash
nano ~/.config/autostart/mount-gdrives.desktop
```

```ini
[Desktop Entry]
Type=Application
Name=Mount Google Drives
Exec=/home/YOUR_USERNAME/.local/bin/mount-gdrives
Terminal=false
Hidden=false
X-GNOME-Autostart-enabled=true
```

---

## Useful Commands

### List Configured Remotes

```bash
rclone listremotes
```

### Test Connection

```bash
rclone ls personal:
```

### Check Mount Status

```bash
mount | grep GoogleDrive
```

### Unmount Drive

```bash
fusermount -u ~/GoogleDrive
```

### Unmount All rclone Mounts

```bash
pkill -9 rclone
```

### Rename Remote

```bash
rclone config
# Type 'r' for rename
# Select the remote
# Enter new name
```

### Delete Remote

```bash
rclone config delete REMOTE_NAME
```

### Copy Files

```bash
# Copy from local to Google Drive
rclone copy ~/Documents personal:Documents

# Copy from Google Drive to local
rclone copy personal:Documents ~/Documents

# Sync (mirror)
rclone sync ~/Documents personal:Documents
```

---

## Mount Options Explained

### Basic Mount

```bash
rclone mount personal: ~/GoogleDrive --daemon
```

### Recommended Mount (Better Performance)

```bash
rclone mount personal: ~/GoogleDrive \
    --vfs-cache-mode writes \
    --vfs-cache-max-age 72h \
    --daemon
```

### High Performance Mount (More Cache)

```bash
rclone mount personal: ~/GoogleDrive \
    --vfs-cache-mode full \
    --vfs-cache-max-age 72h \
    --vfs-read-chunk-size 128M \
    --buffer-size 256M \
    --daemon
```

### Options Breakdown

- `--vfs-cache-mode writes`: Cache file writes (recommended)
- `--vfs-cache-mode full`: Cache everything (faster but uses more disk)
- `--vfs-cache-max-age 72h`: Keep cache for 3 days
- `--vfs-read-chunk-size 128M`: Read 128MB chunks (faster for large files)
- `--buffer-size 256M`: Use 256MB buffer
- `--daemon`: Run in background

---

## Troubleshooting

### Mount Not Showing in File Manager

Navigate directly to the mount path:
```bash
nemo ~/GoogleDrive
```

Or add a bookmark in Nemo.

### "Transport endpoint is not connected" Error

Unmount and remount:
```bash
fusermount -u ~/GoogleDrive
rclone mount personal: ~/GoogleDrive --vfs-cache-mode writes --daemon
```

### Mount Fails on Boot

Add a delay in your autostart script:
```bash
sleep 10 && rclone mount personal: ~/GoogleDrive --vfs-cache-mode writes --daemon
```

### Slow Performance

Use better cache settings:
```bash
rclone mount personal: ~/GoogleDrive \
    --vfs-cache-mode full \
    --vfs-cache-max-age 72h \
    --daemon
```

### Check rclone Logs

```bash
rclone mount personal: ~/GoogleDrive --vfs-cache-mode writes --log-file ~/rclone.log --log-level DEBUG
```

### Permission Denied

Make sure the mount directory exists and you own it:
```bash
mkdir -p ~/GoogleDrive
chown $USER:$USER ~/GoogleDrive
```

---

## Advanced Usage

### Mount Specific Folder

```bash
rclone mount personal:Documents ~/GoogleDocs --vfs-cache-mode writes --daemon
```

### Read-Only Mount

```bash
rclone mount personal: ~/GoogleDrive --read-only --daemon
```

### Mount with Specific Permissions

```bash
rclone mount personal: ~/GoogleDrive \
    --vfs-cache-mode writes \
    --dir-perms 0755 \
    --file-perms 0644 \
    --daemon
```

### Bandwidth Limiting

```bash
rclone mount personal: ~/GoogleDrive \
    --vfs-cache-mode writes \
    --bwlimit 10M \
    --daemon
```

---

## Security Notes

- Your Google Drive credentials are stored in `~/.config/rclone/rclone.conf`
- This file contains access tokens - keep it secure
- Don't share your rclone config file
- You can encrypt the config with: `rclone config`  → `s` (set password)

---

## Backup rclone Config

```bash
# Backup
cp ~/.config/rclone/rclone.conf ~/cosmic-config/config-backups/

# Restore
cp ~/cosmic-config/config-backups/rclone.conf ~/.config/rclone/
```

---

## Summary

**Quick Commands**:
```bash
# Setup
./scripts/setup-rclone.sh

# Mount
rclone mount personal: ~/GoogleDrive --vfs-cache-mode writes --daemon

# Unmount
fusermount -u ~/GoogleDrive

# List remotes
rclone listremotes

# Check status
mount | grep GoogleDrive
```

**Autostart**: Use systemd user service (Method 1) for best reliability.

**Multiple Accounts**: Run setup script multiple times with different names.

---

For more information, see: https://rclone.org/drive/
