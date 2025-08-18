#!/bin/bash

# Folder Size checker script for monitoring specific directories and their sizes

THRESHOLD=1000000  # Set threshold in KB (1GB)

read -p "Enter the directory path to check size (default: Current directory): " dir_path
dir_path="${dir_path:-.}"

if [ ! -d "$dir_path" ]; then
    echo "Error: Directory $dir_path does not exist."
    exit 1
elif [ ! -r "$dir_path" ]; then
    echo "Error: Directory $dir_path is not readable."
    exit 1
else
    echo "Checking size of directory: $dir_path"
fi

check_size(){
    SIZE=$(du -sk "$dir_path" | awk '{print $1}') 
    echo "Size of $dir_path: ${SIZE}KB"

    if [ "$SIZE" -ge "$THRESHOLD" ]; then
        echo "Warning: Size of $dir_path is ${SIZE}KB, which exceeds the threshold of ${THRESHOLD}KB."
        echo "Consider cleaning up files in this directory."
    else
        echo "Size of $dir_path is within acceptable limits: ${SIZE}KB."
    fi
}

check_size
