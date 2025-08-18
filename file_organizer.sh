#!/bin/bash

# File Organizer Script for organizing files based on extensions

read -p "Enter the directory to organize files (default: current directory): " c_dir
c_dir=${c_dir:-.} # Default to current directory if no input is given

if [ ! -e "$c_dir" ]; then
    echo "Directory does not exist: $c_dir"
    exit 1
elif [ ! -d "$c_dir" ]; then
    echo "The $c_dir is not a directory"
    exit 1
fi

if [ "$c_dir" == "." ]; then
    c_dir=$(pwd) # If current directory is specified, use the absolute path
    echo "Organizing files in directory: $c_dir"
elif [ "$c_dir" == ".." ]; then
    c_dir=$(dirname "$(pwd)") # If parent directory is specified, use the absolute path
    echo "Organizing files in parent directory: $c_dir"
else
    echo "Organizing files in directory: $c_dir"
fi


organize_files() {
    for file in "$c_dir"/*; do
        if [ -f "$file" ]; then
            # Extract extension
            ext="${file##*.}"

            # Handle files without extension
            if [ "$file" = "$ext" ]; then
                ext="others"
            fi

            ext_dir="$c_dir/$ext"

            # Create directory if not exists
            if [ ! -d "$ext_dir" ]; then
                mkdir "$ext_dir"
                echo "Created directory: $ext_dir"
            fi

            # Move the file
            mv "$file" "$ext_dir/"
            echo "Moved $file to $ext_dir/"

        elif [ -L "$file" ]; then
            echo "Skipping symbolic link: $file"
        elif [ -d "$file" ]; then
            echo "Skipping directory: $file"
        else
            echo "Skipping non-regular file: $file"
        fi
    done
}

# Call the function
organize_files

