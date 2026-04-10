# Btrfs Snapshot Management Guide

Complete guide to managing system snapshots with Snapper on CachyOS.

---

## Overview

Your system uses Btrfs filesystem with Snapper for snapshot management. Snapshots are:
- Instant and space-efficient (copy-on-write)
- Automatic before package updates
- Limited to 10 total snapshots (configurable)
- Can be pinned to prevent auto-deletion

---

## Quick Start

### Create a Snapshot

```bash
./scripts/snapshot-manager.sh create "Snapshot Name"
```

### List All Snapshots

```bash
./scripts/snapshot-manager.sh list
```

### Pin Important Snapshot

```bash
./scripts/snapshot-manager.sh pin <snapshot_id>
```

### Restore from Snapshot

```bash
./scripts/snapshot-manager.sh restore <snapshot_id>
```

---

## Snapshot Manager Script

The `snapshot-manager.sh` script provides easy snapshot management.

### Available Commands

#### Create Snapshot
```bash
./scripts/snapshot-manager.sh create "Description"
```

Creates a new snapshot with your description.

**Example:**
```bash
./scripts/snapshot-manager.sh create "Before system upgrade"
./scripts/snapshot-manager.sh create "Stable"
./scripts/snapshot-manager.sh create "Working config"
```

#### List Snapshots
```bash
./scripts/snapshot-manager.sh list
```

Shows all snapshots with:
- Snapshot ID
- Type (single/pre/post)
- Date created
- Description
- Cleanup policy

#### Pin Snapshot
```bash
./scripts/snapshot-manager.sh pin <snapshot_id>
```

Marks snapshot as important - won't be auto-deleted during cleanup.

**Example:**
```bash
./scripts/snapshot-manager.sh pin 168
```

#### Unpin Snapshot
```bash
./scripts/snapshot-manager.sh unpin <snapshot_id>
```

Removes important flag - snapshot can be auto-deleted.

#### Delete Snapshot
```bash
./scripts/snapshot-manager.sh delete <snapshot_id>
```

Manually delete a specific snapshot.

**Example:**
```bash
./scripts/snapshot-manager.sh delete 120
```

#### Cleanup Old Snapshots
```bash
./scripts/snapshot-manager.sh cleanup
```

Removes old snapshots, keeping only the last 10 (pinned snapshots are preserved).

#### Show Changes
```bash
./scripts/snapshot-manager.sh info <snapshot_id>
```

Shows what files changed between the snapshot and current system.

#### View Configuration
```bash
./scripts/snapshot-manager.sh config
```

Displays current snapper configuration settings.

#### Restore System
```bash
./scripts/snapshot-manager.sh restore <snapshot_id>
```

Restores your system to a previous snapshot state.

**WARNING:** This will undo all changes made after the snapshot. Reboot recommended after restore.

---

## Direct Snapper Commands

### Basic Commands

```bash
# List snapshots
sudo snapper -c root list

# Create snapshot
sudo snapper -c root create --description "My snapshot"

# Delete snapshot
sudo snapper -c root delete <snapshot_id>

# Show changes
sudo snapper -c root status <snapshot_id>..0

# Restore snapshot
sudo snapper -c root undochange <snapshot_id>..0
```

### Configuration

```bash
# View config
sudo snapper -c root get-config

# Set snapshot limit
sudo snapper -c root set-config "NUMBER_LIMIT=10"

# Set important snapshot limit
sudo snapper -c root set-config "NUMBER_LIMIT_IMPORTANT=10"
```

---

## Automatic Snapshots

Snapper automatically creates snapshots before and after package installations/updates.

### How It Works

1. **Pre-snapshot**: Created before `pacman` runs
2. **Post-snapshot**: Created after `pacman` completes
3. **Paired**: Pre/post snapshots are linked together

### View Automatic Snapshots

```bash
./scripts/snapshot-manager.sh list
```

Look for:
- `pre` type: Before package operation
- `post` type: After package operation
- `Pre #` column: Links post to its pre snapshot

### Disable Automatic Snapshots

```bash
sudo systemctl disable snapper-timeline.timer
sudo systemctl disable snapper-cleanup.timer
```

### Enable Automatic Snapshots

```bash
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
```

---

## Snapshot Workflow

### Before Major Changes

```bash
# Create snapshot before making changes
./scripts/snapshot-manager.sh create "Before major change"

# Note the snapshot ID from output
./scripts/snapshot-manager.sh list

# Pin it if important
./scripts/snapshot-manager.sh pin <snapshot_id>
```

### After Confirming Stability

```bash
# Create stable snapshot
./scripts/snapshot-manager.sh create "Stable"

# Pin it
./scripts/snapshot-manager.sh pin <snapshot_id>

# Clean up old snapshots
./scripts/snapshot-manager.sh cleanup
```

### If Something Breaks

```bash
# List snapshots to find good one
./scripts/snapshot-manager.sh list

# Check what changed
./scripts/snapshot-manager.sh info <snapshot_id>

# Restore if needed
./scripts/snapshot-manager.sh restore <snapshot_id>

# Reboot
sudo reboot
```

---

## Snapshot Limits

### Current Configuration

- **Total snapshots**: 10 maximum
- **Important snapshots**: 10 maximum (pinned snapshots)
- **Cleanup**: Automatic when limit exceeded

### Change Limits

```bash
# Keep 20 snapshots instead of 10
sudo snapper -c root set-config "NUMBER_LIMIT=20"

# Keep 15 important snapshots
sudo snapper -c root set-config "NUMBER_LIMIT_IMPORTANT=15"
```

---

## Pinning Strategy

### What to Pin

Pin snapshots that represent:
- Known stable states
- Before major system changes
- Working configurations
- Clean installs

### Example Strategy

```bash
# Pin your stable baseline
./scripts/snapshot-manager.sh pin 168

# Create and pin before major upgrade
./scripts/snapshot-manager.sh create "Before KDE upgrade"
./scripts/snapshot-manager.sh pin <new_id>

# After upgrade works, unpin old one
./scripts/snapshot-manager.sh unpin 168
```

---

## Disk Space Management

### Check Snapshot Space Usage

```bash
# Show Btrfs usage
sudo btrfs filesystem usage /

# Show snapshot sizes
sudo btrfs subvolume list / | grep snapshot
```

### Free Up Space

```bash
# Delete old snapshots
./scripts/snapshot-manager.sh cleanup

# Or delete specific ones
./scripts/snapshot-manager.sh delete <snapshot_id>

# Balance filesystem (reclaim space)
sudo btrfs balance start -dusage=50 /
```

---

## Restoring from Snapshots

### Method 1: Using Script (Recommended)

```bash
./scripts/snapshot-manager.sh restore <snapshot_id>
sudo reboot
```

### Method 2: Manual Restore

```bash
# Restore changes
sudo snapper -c root undochange <snapshot_id>..0

# Reboot
sudo reboot
```

### Method 3: Boot into Snapshot (GRUB only)

If you were using GRUB instead of Limine, snapshots would appear in boot menu. With Limine, use restore methods above.

---

## Troubleshooting

### Snapshot Creation Fails

```bash
# Check Btrfs health
sudo btrfs filesystem show /
sudo btrfs device stats /

# Check available space
df -h /
```

### Too Many Snapshots

```bash
# Run cleanup
./scripts/snapshot-manager.sh cleanup

# Or increase limit
sudo snapper -c root set-config "NUMBER_LIMIT=20"
```

### Restore Doesn't Work

```bash
# Check snapshot exists
./scripts/snapshot-manager.sh list

# Check what would change
./scripts/snapshot-manager.sh info <snapshot_id>

# Try manual restore
sudo snapper -c root undochange <snapshot_id>..0
```

### Disk Full

```bash
# Delete old snapshots
./scripts/snapshot-manager.sh cleanup

# Check space
df -h /

# Balance filesystem
sudo btrfs balance start -dusage=50 /
```

---

## Advanced Usage

### Compare Two Snapshots

```bash
sudo snapper -c root status <snapshot_id1>..<snapshot_id2>
```

### Rollback to Snapshot

```bash
# Set snapshot as default subvolume (advanced)
sudo btrfs subvolume set-default <subvol_id> /
sudo reboot
```

### Create Config for Other Subvolumes

```bash
# Create config for /home
sudo snapper -c home create-config /home

# List configs
sudo snapper list-configs
```

### Exclude Directories from Snapshots

Edit `/etc/snapper/configs/root`:
```bash
# Add to SNAPPER_CONFIGS
SNAPPER_CONFIGS="root"

# Exclude paths
SNAPPER_EXCLUDE="/var/cache /var/tmp /var/log"
```

---

## Backup Snapper Config

```bash
# Backup config
sudo cp /etc/snapper/configs/root ~/cosmic-config/config-backups/snapper-root.conf

# Restore config
sudo cp ~/cosmic-config/config-backups/snapper-root.conf /etc/snapper/configs/root
```

---

## Integration with Package Manager

Snapper automatically creates snapshots during package operations via `snap-pac`.

### Check Integration

```bash
# Verify snap-pac is installed
pacman -Q snap-pac

# Check hooks
ls /usr/share/libalpm/hooks/
```

### Disable for Single Operation

```bash
# Skip snapshot for this install
sudo pacman -S package --hookdir /dev/null
```

---

## Best Practices

1. **Pin stable states**: Always pin snapshots you might need later
2. **Regular cleanup**: Run cleanup monthly to free space
3. **Before major changes**: Create and pin snapshot before system upgrades
4. **Test restores**: Occasionally test restore process to ensure it works
5. **Monitor space**: Keep an eye on disk usage with `df -h`
6. **Descriptive names**: Use clear descriptions when creating snapshots
7. **Limit snapshots**: Keep only what you need (10 is usually enough)

---

## Quick Reference

```bash
# Create and pin stable snapshot
./scripts/snapshot-manager.sh create "Stable"
./scripts/snapshot-manager.sh pin <id>

# List all
./scripts/snapshot-manager.sh list

# Cleanup old
./scripts/snapshot-manager.sh cleanup

# Restore system
./scripts/snapshot-manager.sh restore <id>

# Check changes
./scripts/snapshot-manager.sh info <id>

# Delete specific
./scripts/snapshot-manager.sh delete <id>
```

---

## Summary

- Snapshots are automatic before package updates
- Manual snapshots via `snapshot-manager.sh create`
- Pin important snapshots to prevent deletion
- Limit of 10 snapshots (configurable)
- Restore anytime with `snapshot-manager.sh restore`
- Cleanup with `snapshot-manager.sh cleanup`

---

For more information: https://wiki.archlinux.org/title/Snapper
