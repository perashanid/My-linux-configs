 beautifull wallpaer #!/bin/bash
# Btrfs Snapshot Manager for Snapper
# Manages manual snapshots with limit of 10

set -e

ACTION="${1:-list}"
SNAPSHOT_NAME="${2:-}"

case "$ACTION" in
    create)
        if [ -z "$SNAPSHOT_NAME" ]; then
            echo "Usage: $0 create <name>"
            exit 1
        fi
        echo "Creating snapshot: $SNAPSHOT_NAME"
        sudo snapper -c root create --description "$SNAPSHOT_NAME"
        echo "✓ Snapshot created"
        ;;
    
    list)
        echo "Current snapshots:"
        sudo snapper -c root list
        ;;
    
    delete)
        if [ -z "$SNAPSHOT_NAME" ]; then
            echo "Usage: $0 delete <snapshot_id>"
            exit 1
        fi
        echo "Deleting snapshot ID: $SNAPSHOT_NAME"
        sudo snapper -c root delete "$SNAPSHOT_NAME"
        echo "✓ Snapshot deleted"
        ;;
    
    cleanup)
        echo "Running cleanup (keeps last 10 snapshots)..."
        sudo snapper -c root cleanup number
        echo "✓ Cleanup complete"
        ;;
    
    pin)
        if [ -z "$SNAPSHOT_NAME" ]; then
            echo "Usage: $0 pin <snapshot_id>"
            exit 1
        fi
        echo "Pinning snapshot ID: $SNAPSHOT_NAME (marking as important)"
        sudo snapper -c root modify --userdata "important=yes" "$SNAPSHOT_NAME"
        echo "✓ Snapshot pinned (won't be auto-deleted)"
        ;;
    
    unpin)
        if [ -z "$SNAPSHOT_NAME" ]; then
            echo "Usage: $0 unpin <snapshot_id>"
            exit 1
        fi
        echo "Unpinning snapshot ID: $SNAPSHOT_NAME"
        sudo snapper -c root modify --userdata "important=no" "$SNAPSHOT_NAME"
        echo "✓ Snapshot unpinned"
        ;;
    
    restore)
        if [ -z "$SNAPSHOT_NAME" ]; then
            echo "Usage: $0 restore <snapshot_id>"
            exit 1
        fi
        echo "WARNING: This will restore your system to snapshot ID: $SNAPSHOT_NAME"
        read -p "Are you sure? (yes/no): " CONFIRM
        if [ "$CONFIRM" = "yes" ]; then
            sudo snapper -c root undochange "$SNAPSHOT_NAME"..0
            echo "✓ System restored. Reboot recommended."
        else
            echo "Restore cancelled"
        fi
        ;;
    
    info)
        if [ -z "$SNAPSHOT_NAME" ]; then
            echo "Usage: $0 info <snapshot_id>"
            exit 1
        fi
        sudo snapper -c root status "$SNAPSHOT_NAME"..0
        ;;
    
    config)
        echo "Current snapper configuration:"
        sudo snapper -c root get-config | grep -E "NUMBER_LIMIT|TIMELINE"
        ;;
    
    *)
        echo "Btrfs Snapshot Manager"
        echo ""
        echo "Usage: $0 <command> [args]"
        echo ""
        echo "Commands:"
        echo "  create <name>       Create a new snapshot with description"
        echo "  list                List all snapshots"
        echo "  delete <id>         Delete a snapshot by ID"
        echo "  cleanup             Run cleanup (keeps last 10 snapshots)"
        echo "  pin <id>            Pin snapshot (mark as important, won't auto-delete)"
        echo "  unpin <id>          Unpin snapshot"
        echo "  restore <id>        Restore system to snapshot"
        echo "  info <id>           Show what changed since snapshot"
        echo "  config              Show current configuration"
        echo ""
        echo "Examples:"
        echo "  $0 create Stable"
        echo "  $0 list"
        echo "  $0 pin 168"
        echo "  $0 cleanup"
        echo "  $0 restore 168"
        ;;
esac
