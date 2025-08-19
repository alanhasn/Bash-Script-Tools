#!/bin/bash


# Ping Sweep tool for scanning a range of IP addresses to check their availability

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m" # No Color

read -p "Enter the starting host number (e.g. 1): " start_host
read -p "Enter the last host number (e.g. 254): " last_host
read -p "Enter the network IP (e.g. 192.168.1): " network_ip

ping_sweep() {
    inactive_count=0

    for i in $(seq "$start_host" "$last_host"); do
        ip="$network_ip.$i"
        ping -c 1 -W 1 "$ip" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Host $ip is UP.${NC}"
        else
            ((inactive_count++))
        fi
    done

    echo -e "${BLUE}------------------------------------${NC}"
    echo -e "${YELLOW}Number of inactive hosts: $inactive_count${NC}"
}

ping_sweep
echo -e "${BLUE}Ping Sweep completed.${NC}"