#!/bin/bash

echo "System Statistics"
echo "-----------------"

# Hostname Information
echo "Hostname: $(hostname)"
echo

# File System Disk Space Usage
echo "File System Disk Space Usage:"
df -h
echo

# Free and Used Memory
echo "Free and Used Memory:"
free -h
echo

# System Uptime and Load
echo "System Uptime and Load:"
uptime
echo

# Users Currently Logged In
echo "Users Currently Logged In:"
who
echo

# Top 5 Processes as far as Memory Usage is concerned
echo "Top 5 Memory-Consuming Processes:"
ps -eo pid,ppid,%mem,%cpu,cmd --sort=-%mem | head -n 6
echo
