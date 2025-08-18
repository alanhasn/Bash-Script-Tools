#!/bin/bash

"""
Simple File and Folder Automation Tool
"""

# Define color codes
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"
BOLD="\e[1m"


while true; do
    echo -e "${BOLD}${BLUE}-------- Simple File & Folder Automation Tool ---------${RESET}"
    echo -e "${GREEN}1)${RESET} Create File"
    echo -e "${GREEN}2)${RESET} Create Folder"
    echo -e "${CYAN}3)${RESET} List Files/Folders"
    echo -e "${CYAN}4)${RESET} Show Hidden files/folders"
    echo -e "${RED}5)${RESET} Delete File/Folder"
    echo -e "${YELLOW}6)${RESET} Rename File/Folder"
    echo -e "${MAGENTA}7)${RESET} Copy File/Folder"
    echo -e "${GREEN}8)${RESET} Move File/Folder"
    echo -e "${MAGENTA}9)${RESET} Search File/Folder by name and type"
    echo -e "${CYAN}10)${RESET} View File content"
    echo -e "${YELLOW}11)${RESET} Edit File Content"
    echo -e "${CYAN}12)${RESET} Help"
    echo -e "${CYAN}13)${RESET} Exit"

    read -p "$(echo -e ${BOLD}${CYAN}Select an option: ${RESET})" option

    case $option in
        1)
            read -p "Enter file name to create: " filename
            if [ ! -e "$filename" ]; then
                touch "$filename"
                echo -e "${GREEN}File '$filename' created.${RESET}"
            else
                echo -e "${YELLOW}File '$filename' already exists.${RESET}"
            fi
            ;;
        2)
            read -p "Enter folder name to create: " foldername
            if [ ! -e "$foldername" ]; then
                mkdir "$foldername"
                echo -e "${GREEN}Folder '$foldername' created.${RESET}"
            else
                echo -e "${YELLOW}Folder '$foldername' already exists.${RESET}"
            fi
            ;;
        3)
            echo -e "${CYAN}Listing Files and Folders:${RESET}"
            ls -lh
            ;;
        4)
            echo -e "${CYAN}Listing Hidden Files and Folders:${RESET}"
            ls -lha
            ;;
        5)
            read -p "Enter file/folder name to delete: " name
            if [ -e "$name" ]; then
                read -p "Are you sure you want to delete $name? (y/n): " confirm
                if [ "$confirm" == "y" ]; then
                    rm -rf "$name"
                    echo -e "${RED}'$name' deleted.${RESET}"
                else
                    echo -e "${YELLOW}Deletion of '$name' canceled.${RESET}"
                fi
            else
                echo -e "${YELLOW}'$name' does not exist.${RESET}"
            fi
            ;;
        6)
            read -p "Enter file/folder name to rename: " oldname
            read -p "Enter new name: " newname
            if [ -e "$oldname" ]; then
                mv "$oldname" "$newname"
                echo -e "${GREEN}$oldname renamed to $newname.${RESET}"
            else
                echo -e "${YELLOW}'$oldname' does not exist.${RESET}"
            fi
            ;;
        7)
            read -p "Enter file/folder name to copy: " source
            read -p "Enter destination name: " destination
            if [ -e "$source" ]; then
                cp -r "$source" "$destination"
                echo -e "${GREEN}'$source' copied to '$destination'.${RESET}"
            else
                echo -e "${YELLOW}'$source' does not exist.${RESET}"
            fi
            ;;
        8)
            read -p "Enter file/folder name to move: " source
            read -p "Enter destination name: " destination
            if [ -e "$source" ]; then
                mv "$source" "$destination"
                echo -e "${GREEN}'$source' moved to '$destination'.${RESET}"
            else
                echo -e "${YELLOW}'$source' does not exist.${RESET}"
            fi
            ;;
        9)
            read -p "What do you want to search about (File or Folder): " choice
            read -p "Enter name to search: " name

            if [ "$choice" == "File" ]; then
                echo -e "${CYAN}Searching for files matching '$name'...${RESET}"
                results=$(find . -type f -name "*$name*")
                if [ -z "$results" ]; then
                    echo -e "${YELLOW}No files found matching '$name'.${RESET}"
                else
                    echo -e "${GREEN}Files found:${RESET}"
                    echo "$results"
                fi
            elif [ "$choice" == "Folder" ]; then
                echo -e "${CYAN}Searching for folders matching '$name'...${RESET}"
                results=$(find . -type d -name "*$name*")
                if [ -z "$results" ]; then
                    echo -e "${YELLOW}No folders found matching '$name'.${RESET}"
                else
                    echo -e "${GREEN}Folders found:${RESET}"
                    echo "$results"
                fi
            else
                echo -e "${RED}Invalid choice. Please specify 'File' or 'Folder'.${RESET}"
            fi
            ;;
        10)
            read -p "Enter file name to view: " filename
            if [ -e "$filename" ]; then
                cat "$filename"
            else
                echo -e "${YELLOW}'$filename' does not exist.${RESET}"
            fi
            ;;
        11) 
        
            read -p "Enter file name to edit: " filename
            if [ -e "$filename" ]; then
                nano "$filename"
            else
                echo -e "${YELLOW}'$filename' does not exist.${RESET}"
            fi
            ;;
        12)
            echo -e "${CYAN}Help Menu:${RESET}"
            echo -e "${CYAN}1)${RESET} Create File"
            echo -e "${CYAN}2)${RESET} Create Folder"
            echo -e "${CYAN}3)${RESET} List Files and Folders"
            echo -e "${CYAN}4)${RESET} List Hidden Files and Folders"
            echo -e "${CYAN}5)${RESET} Delete File/Folder"
            echo -e "${CYAN}6)${RESET} Rename File/Folder"
            echo -e "${CYAN}7)${RESET} Copy File/Folder"
            echo -e "${CYAN}8)${RESET} Move File/Folder"
            echo -e "${CYAN}9)${RESET} Search for File/Folder"
            echo -e "${CYAN}10)${RESET} View File content"
            echo -e "${CYAN}11)${RESET} Edit File Content"
            echo -e "${CYAN}12)${RESET} Help"
            echo -e "${CYAN}13)${RESET} Exit"
            ;;
        13)
            echo -e "${RED}Exiting...${RESET}"
            exit 0
            ;;

        *)
            echo -e "${RED}Invalid option. Please try again.${RESET}"
            ;;
    esac
done
