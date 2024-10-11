#!/bin/bash

# Get CPU usage
function get_cpu_stats {
    echo "=== CPU Stats ==="
    # Get the CPU usage (User + System)
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | \
                sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
                awk '{print 100 - $1"%"}')
    echo "CPU Usage: $CPU_USAGE"
    # Get the number of CPU cores
    CPU_CORES=$(nproc)
    echo "CPU Cores: $CPU_CORES"
    echo
}

# Get Memory usage
function get_memory_stats {
    echo "=== Memory Stats ==="
    # Get memory usage using 'free' command
    MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
    MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
    MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
    echo "Total Memory: $((MEM_TOTAL / 1024)) GB"
    echo "Used Memory: $((MEM_USED / 1024)) GB"
    echo "Free Memory: $((MEM_FREE / 1024)) GB"
    echo "Memory Usage: $(free | grep Mem | awk '{print $3/$2 * 100.0}')%"
    echo
}

# Get Disk usage
function get_disk_stats {
    echo "=== Disk Stats ==="
    # Get the disk usage using 'df' command
    DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
    DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
    DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
    echo "Total Disk Space: $DISK_TOTAL"
    echo "Used Disk Space: $DISK_USED"
    echo "Free Disk Space: $DISK_FREE"
    echo
}

# Get Network stats
function get_network_stats {
    echo "=== Network Stats ==="
    # Get network stats using 'netstat' command
    echo "Network connections: "
    netstat -tuln
    echo
}

# Get Top 5 processes by CPU usage
function top_processes_by_cpu {
    echo "=== Top 5 Processes by CPU Usage ==="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo
}

# Get Top 5 processes by Memory usage
function top_processes_by_memory {
    echo "=== Top 5 Processes by Memory Usage ==="
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
    echo
}

# Run all the functions
get_cpu_stats
get_memory_stats
get_disk_stats
get_network_stats
top_processes_by_cpu
top_processes_by_memory