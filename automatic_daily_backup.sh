#!/bin/bash

# Automatic Daily Backup Script for creating backups of specified directories

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color


read -p "Enter the directory to backup (default: Current directory): " backup_dir
backup_dir="${backup_dir:-.}"

if [ ! -d "$backup_dir" ]; then
    echo -e "${RED}Error: Directory $backup_dir does not exist.${NC}"
    exit 1
elif [ ! -r "$backup_dir" ]; then
    echo -e "${RED}Error: Directory $backup_dir is not readable.${NC}"
    exit 1
else
    echo -e "${GREEN}Starting backup for directory: $backup_dir${NC}"
fi

backup_date=$(date +"%Y%m%d_%H%M%S")
backup_file="backup_${backup_date}.tar.gz"

backup_path="$HOME/backups/$backup_file"
mkdir -p "$HOME/backups"
tar -czf "$backup_path" -C "$backup_dir" .
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Backup successful! File created at: $backup_path${NC}"
else
    echo -e "${RED}Error: Backup failed.${NC}"
    exit 1
fi
echo -e "${BLUE}Backup process completed.${NC}"
echo -e "${YELLOW}Remember to regularly check your backups and ensure they are stored securely.${NC}"
echo -e "${YELLOW}Consider automating this script to run daily using cron jobs.${NC}"
echo -e "${BLUE}Automatic Daily Backup Script finished.${NC}"
exit 0