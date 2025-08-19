#!/bin/bash

# Password Generator script for creating secure passwords

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

read -p "Enter the desired password length (default: 12): " length
length="${length:-12}"
if ! [[ "$length" =~ ^[0-9]+$ ]] || [ "$length" -lt 6 ]; then
    echo -e "${RED}Error: Please enter a valid length (minimum 6).${NC}"
    exit 1
fi

generate_password() {
    # Generate a secure password using openssl
    password=$(openssl rand -base64 48 | cut -c1-"$length")
    echo -e "${GREEN}Generated Password: ${password}${NC}"
}

generate_password