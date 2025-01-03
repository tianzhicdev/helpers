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
    # --delete: remove files in dest that don't exist in source
    rsync -au --delete "$from_dir/" "$to_dir/"

    echo "Directory sync completed from $from_dir to $to_dir"
}