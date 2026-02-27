#!/bin/bash

# Server performance stats analyzer

echo "=== Server Performance Stats ==="

# CPU usage (%)
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "CPU Usage: ${cpu}%"

# Memory usage: Total, Free, Used (%)
mem_total=$(free -m | awk 'NR==2{print $2}')
mem_free=$(free -m | awk 'NR==2{print $4}')
mem_used_perc=$(free | awk 'NR==2{printf "%.1f", $3*100/$2 }')
echo "Memory Total: ${mem_total} MB"
echo "Memory Free: ${mem_free} MB"
echo "Memory Used: ${mem_used_perc}%"

# Disk usage: Total, Free, Used (%)
disk_total=$(df -h / | awk 'NR==2{print $2}')
disk_free=$(df -h / | awk 'NR==2{print $4}')
disk_used_perc=$(df -h / | awk 'NR==2{print $5}' | sed 's/%//')
echo "Disk Total: ${disk_total}"
echo "Disk Free: ${disk_free}"
echo "Disk Used: ${disk_used_perc}%"

# Top 5 processes by CPU usage
echo "=== Top 5 Processes by CPU ==="
ps aux --sort=-%cpu | head -6 | awk '{print $11, $1, $2, "%cpu:" $3, "%mem:" $4}'
