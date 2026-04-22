#!/bin/bash

# vm-health-check.sh

# Function to check CPU usage
check_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\\([0-9.]*\)%* id.*/\\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage > 60" | bc -l) )); then
        echo "CPU usage is high: $cpu_usage%"
    else
        echo "CPU usage is normal: $cpu_usage%"
    fi
}

# Function to check Memory usage
check_memory() {
    local memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$memory_usage > 60" | bc -l) )); then
        echo "Memory usage is high: $memory_usage%"
    else
        echo "Memory usage is normal: $memory_usage%"
    fi
}

# Function to check Disk usage
check_disk() {
    local disk_usage=$(df -h | grep "/$" | awk '{print $5}' | sed 's/%//')
    if (( disk_usage > 60 )); then
        echo "Disk usage is high: $disk_usage%"
    else
        echo "Disk usage is normal: $disk_usage%"
    fi
}

# Main script execution
check_cpu
check_memory
check_disk