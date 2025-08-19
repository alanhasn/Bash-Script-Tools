#!/bin/bash

# This script monitors CPU and memory usage, alerting if thresholds are exceeded.

CPU_THRESHOLD=80
MEMORY_THERESHOLD=80
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

if [ $(echo "$CPU_USAGE" > "$CPU_THRESHOLD")]; then
    echo "Warning: CPU usage is high at ${CPU_USAGE}%."
    echo "Consider optimizing processes or checking for resource-intensive applications."
else
    echo "CPU usage is within acceptable limits: ${CPU_USAGE}%."
fi

if [ $(echo "$MEMORY_USAGE" > "$MEMORY_THERESHOLD") ]; then
    echo "Warning: Memory usage is high at ${MEMORY_USAGE}%."
    echo "Consider closing applications or checking for memory leaks."
else
    echo "Memory usage is within acceptable limits: ${MEMORY_USAGE}%."
fi
