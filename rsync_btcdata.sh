#!/bin/bash

# Function to sync directories, only copying updated files
sync_directories() {
    local from_dir="$1"
    local to_dir="$2"

    # Check if directories exist
    if [ ! -d "$from_dir" ]; then
        echo "Error: Source directory $from_dir does not exist"
        return 1
    fi

    if [ ! -d "$to_dir" ]; then
        mkdir -p "$to_dir"
    fi

    # Use rsync to efficiently copy only updated files
    # -a: archive mode (preserves permissions etc)
    # -u: only copy newer files
    rsync -au "$from_dir/" "$to_dir/"
    # Log the sync operation with timestamp
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Synced $from_dir to $to_dir" >> "/var/log/btc_sync.log"
    echo "Directory sync completed from $from_dir to $to_dir"
}

sync_directories "$BTCDIR" "/Volumes/databank/bitcoin_data"
