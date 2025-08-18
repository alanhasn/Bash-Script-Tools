#!/bin/bash

# File Duplicate Finder Script for finding and deleting duplicate files
# This script finds duplicate files in a specified directory and allows the user to delete them.


# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

read -p "Enter the directory to find duplicate files (default: current directory): " c_dir
c_dir=${c_dir:-.}

# Check if the directory exists and is a directory
if [ ! -e "$c_dir" ]; then
    echo -e "${RED}Error:${NC} Directory does not exist: $c_dir"
    exit 1
elif [ ! -d "$c_dir" ]; then
    echo -e "${RED}Error:${NC} The $c_dir is not a directory"
    exit 1
fi

echo -e "${BLUE}Finding duplicate files in:${NC} $(realpath "$c_dir")"
echo "--------------------------------"

find_duplicates() {
    declare -A duplicate_files
    duplicates=()

    for file in "$c_dir"/*; do
        if [ -f "$file" ]; then
            # Skip unreadable files
            if [ ! -r "$file" ]; then
                echo -e "${YELLOW}Cannot read${NC} $file, skipping..."
                continue
            fi

            checksum=$(sha256sum "$file" 2>/dev/null | awk '{print $1}')

            # If checksum failed, skip
            if [ -z "$checksum" ]; then
                echo -e "${YELLOW}Could not calculate checksum${NC} for $file, skipping..."
                continue
            fi

            if [[ -n "${duplicate_files[$checksum]}" ]]; then
                duplicates+=("$file")
                duplicate_files[$checksum]="${duplicate_files[$checksum]} $file"
            else
                duplicate_files[$checksum]="$file"
            fi

        elif [ -d "$file" ]; then
            echo -e "${YELLOW}$file is a directory, skipping...${NC}"
            continue
        elif [ -L "$file" ]; then
            echo -e "${YELLOW}$file is a symbolic link, skipping...${NC}"
            continue
        elif [ ! -s "$file" ]; then
            echo -e "${YELLOW}$file is empty, skipping...${NC}"
            continue
        elif [ -b "$file" ] || [ -c "$file" ]; then
            echo -e "${YELLOW}$file is a block/character device, skipping...${NC}"
            continue
        elif [ -p "$file" ]; then
            echo -e "${YELLOW}$file is a named pipe, skipping...${NC}"
            continue
        elif [ -S "$file" ]; then
            echo -e "${YELLOW}$file is a socket, skipping...${NC}"
            continue
        else
            echo -e "${YELLOW}$file is not a regular file, skipping...${NC}"
            continue
        fi
    done

    # Show results
    if [ ${#duplicates[@]} -eq 0 ]; then
        echo -e "${GREEN}No duplicate files found.${NC}"
        exit 0
    fi

    echo -e "${RED}Duplicate files found:${NC}"
    for dup in "${duplicates[@]}"; do
        echo -e " - ${RED}$dup${NC}"
    done

    # Ask once to delete all
    read -p "Do you want to delete All duplicate files? (y/n): " answer
    if [[ "$answer" == "y" ]]; then
        for dup in "${duplicates[@]}"; do
            rm "$dup"
            echo -e "${RED}Deleted:${NC} $dup"
        done
        echo -e "${GREEN}All duplicate files deleted.${NC}"
    else
        echo -e "${BLUE}No files were deleted.${NC}"
    fi
}

find_duplicates
