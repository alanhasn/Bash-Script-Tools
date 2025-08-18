#!/bin/bash

echo "Enter the network (e.g., 192.168.0.0/24): "
read NETWORK

echo "Enter the port number to scan (e.g., 3306): "
read port

echo "Scanning $NETWORK on port $port..."
nmap -sT $NETWORK -p $port -oG Scan > /dev/null

grep "open" Scan > Scan2

if [ -s Scan2 ]; then
    echo "Hosts with port $port open:"
    awk '{print $2}' Scan2
else
    echo "No hosts found with port $port open."
fi

