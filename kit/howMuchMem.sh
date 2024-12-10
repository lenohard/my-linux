#!/usr/bin/env bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <process_name>"
    exit 1
fi

process_name="$1"

# Find all PIDs for the given process name
pids=($(pgrep -f -x "$process_name"))

# Check if any processes were found
if [ ${#pids[@]} -eq 0 ]; then
    echo "No processes found matching '$process_name'"
    exit 0
fi

total_mem=0

# Function to get memory usage for a PID and its children
get_mem_usage() {
    local pid=$1
    local mem
    mem=$(ps -o rss= -p "$pid")
    total_mem=$((total_mem + mem))

    # Get child processes
    local children
    children=($(pgrep -P "$pid"))
    for child in "${children[@]}"; do
        get_mem_usage "$child"
    done
}

# Process each instance of the given process
for pid in "${pids[@]}"; do
    get_mem_usage "$pid"
done

# Convert total memory from KB to MB
total_mem_mb=$(bc <<< "scale=2; $total_mem / 1024")

echo "Total memory usage of '$process_name' and its subprocesses: ${total_mem_mb} MB"

# Display detailed breakdown
echo "Detailed memory usage breakdown:"
echo "PID | PPID | Memory (MB) | Command"
echo "------------------------------------"
ps -o pid=,ppid=,rss=,command= -p "${pids[@]}" 2>/dev/null | \
    sort -n -k3 | \
    awk '{printf "%-6s %-6s %-12.2f %s\n", $1, $2, $3/1024, $4}'
