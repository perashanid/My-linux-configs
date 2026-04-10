#!/bin/bash
# Create and pin a snapshot in one command

set -e

SNAPSHOT_NAME="${1:-Stable}"

if [ -z "$SNAPSHOT_NAME" ]; then
    echo "Usage: $0 <snapshot_name>"
    echo "Example: $0 Stable"
    exit 1
fi

echo "=========================================="
echo "  Creating Pinned Snapshot"
echo "=========================================="
echo ""
echo "Name: $SNAPSHOT_NAME"
echo ""

# Create snapshot
echo "Creating snapshot..."
SNAPSHOT_OUTPUT=$(sudo snapper -c root create --description "$SNAPSHOT_NAME" --print-number)
SNAPSHOT_ID=$SNAPSHOT_OUTPUT

if [ -z "$SNAPSHOT_ID" ]; then
    echo "✗ Failed to create snapshot"
    exit 1
fi

echo "✓ Snapshot created with ID: $SNAPSHOT_ID"
echo ""

# Pin snapshot
echo "Pinning snapshot..."
sudo snapper -c root modify --userdata "important=yes" "$SNAPSHOT_ID"
echo "✓ Snapshot pinned (won't be auto-deleted)"
echo ""

echo "=========================================="
echo "  Snapshot Created Successfully"
echo "=========================================="
echo ""
echo "Snapshot ID: $SNAPSHOT_ID"
echo "Description: $SNAPSHOT_NAME"
echo "Status: Pinned"
echo ""
echo "This snapshot will appear in Limine boot menu under 'Snapshots'"
echo ""
echo "To restore this snapshot later:"
echo "  ./scripts/snapshot-manager.sh restore $SNAPSHOT_ID"
echo ""
echo "To list all snapshots:"
echo "  ./scripts/snapshot-manager.sh list"
echo ""
