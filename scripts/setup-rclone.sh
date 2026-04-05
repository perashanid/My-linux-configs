#!/bin/bash
# Rclone Google Drive Setup Script
# Installs rclone and guides through adding Google Drive accounts

set -e

echo "=========================================="
echo "  Rclone Google Drive Setup"
echo "=========================================="
echo ""

# Check if running on Arch-based system
if ! command -v pacman &> /dev/null; then
    echo "Error: This script is for Arch-based systems (CachyOS, Manjaro, etc.)"
    exit 1
fi

# Install rclone if not already installed
if ! command -v rclone &> /dev/null; then
    echo "Installing rclone..."
    sudo pacman -S --noconfirm rclone
    echo "✓ rclone installed"
else
    echo "✓ rclone already installed"
fi

echo ""
echo "=========================================="
echo "  Add Google Drive Account"
echo "=========================================="
echo ""
echo "You'll be guided through adding a Google Drive account."
echo "You can run this script multiple times to add more accounts."
echo ""

# Prompt for remote name
read -p "Enter a name for this Google Drive (e.g., personal, work, gdrive1): " REMOTE_NAME

if [ -z "$REMOTE_NAME" ]; then
    echo "Error: Remote name cannot be empty"
    exit 1
fi

# Check if remote already exists
if rclone listremotes | grep -q "^${REMOTE_NAME}:$"; then
    echo "Error: Remote '$REMOTE_NAME' already exists"
    echo "Existing remotes:"
    rclone listremotes
    exit 1
fi

echo ""
echo "Starting rclone configuration..."
echo "Follow these steps:"
echo ""
echo "1. Storage type: Enter '24' for Google Drive"
echo "2. Client ID: Press Enter (leave blank)"
echo "3. Client Secret: Press Enter (leave blank)"
echo "4. Scope: Enter '1' for full access"
echo "5. Root folder ID: Press Enter (leave blank)"
echo "6. Service account file: Press Enter (leave blank)"
echo "7. Advanced config: Enter 'n'"
echo "8. Auto config: Enter 'y' (browser will open)"
echo "9. Sign in with your Google account in the browser"
echo "10. Shared Drive: Enter 'n' (unless using Google Workspace)"
echo "11. Confirm: Enter 'y'"
echo ""
read -p "Press Enter to continue..."

# Run rclone config with automated input up to browser auth
expect -c "
set timeout -1
spawn rclone config
expect \"e/n/d/r/c/s/q>\"
send \"n\r\"
expect \"name>\"
send \"$REMOTE_NAME\r\"
expect \"Storage>\"
send \"24\r\"
expect \"client_id>\"
send \"\r\"
expect \"client_secret>\"
send \"\r\"
expect \"scope>\"
send \"1\r\"
expect \"root_folder_id>\"
send \"\r\"
expect \"service_account_file>\"
send \"\r\"
expect \"y/n>\"
send \"n\r\"
expect \"y/n>\"
send \"y\r\"
expect \"y/n>\"
interact
" || {
    # If expect is not installed, fall back to manual config
    if ! command -v expect &> /dev/null; then
        echo ""
        echo "Note: 'expect' not installed. Running manual configuration..."
        echo ""
        rclone config
    fi
}

echo ""
echo "=========================================="
echo "  Mount Google Drive"
echo "=========================================="
echo ""

# Prompt for mount point
read -p "Enter folder name to mount to (e.g., GoogleDrive, $REMOTE_NAME): " MOUNT_NAME

if [ -z "$MOUNT_NAME" ]; then
    MOUNT_NAME="$REMOTE_NAME"
fi

MOUNT_PATH="$HOME/$MOUNT_NAME"

# Create mount directory
mkdir -p "$MOUNT_PATH"

# Mount the drive
echo "Mounting $REMOTE_NAME to $MOUNT_PATH..."
rclone mount "$REMOTE_NAME:" "$MOUNT_PATH" --vfs-cache-mode writes --daemon

if [ $? -eq 0 ]; then
    echo "✓ Google Drive mounted successfully!"
    echo ""
    echo "Access your files at: $MOUNT_PATH"
    echo "Open in file manager: nemo $MOUNT_PATH"
else
    echo "✗ Failed to mount Google Drive"
    exit 1
fi

echo ""
echo "=========================================="
echo "  Setup Complete!"
echo "=========================================="
echo ""
echo "Remote name: $REMOTE_NAME"
echo "Mount path: $MOUNT_PATH"
echo ""
echo "To mount manually:"
echo "  rclone mount $REMOTE_NAME: $MOUNT_PATH --vfs-cache-mode writes --daemon"
echo ""
echo "To unmount:"
echo "  fusermount -u $MOUNT_PATH"
echo ""
echo "To add another Google Drive account:"
echo "  ./setup-rclone.sh"
echo ""
echo "To setup autostart, see: docs/RCLONE_GUIDE.md"
echo ""
