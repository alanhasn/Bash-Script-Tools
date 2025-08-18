#!/bin/bash


# Disk Usage Monitor Script


THRESHOLD=80

USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//') #awk: get the usage percentage of the root filesystem


if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "Warning: Disk usage is ${USAGE}% on /"
    echo "Disk usage is high. Consider cleaning up files."
else
  echo "Disk usage is OK: ${USAGE}%"
  echo "Disk usage is within acceptable limits."
fi