#!/bin/bash

REPORT_DIR="/training/reports"
mkdir -p "$REPORT_DIR"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_FILE="$REPORT_DIR/health_report_$DATE.txt"

echo "===== System Health Report - $DATE =====" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# CPU and memory usage
echo "--- CPU & Memory ---" >> "$REPORT_FILE"
sar -u 1 3 >> "$REPORT_FILE"
sar -r 1 3 >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Disk usage
echo "--- Disk Usage ---" >> "$REPORT_FILE"
df -h >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Network stats
echo "--- Network Interfaces ---" >> "$REPORT_FILE"
ip -brief a >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Running processes
echo "--- Top 10 Processes by Memory ---" >> "$REPORT_FILE"
ps aux --sort=-%mem | head -n 11 >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# System logs (last 1 hour)
echo "--- Journal Logs (Last 1 Hour) ---" >> "$REPORT_FILE"
journalctl --since "1 hour ago" -p warning --no-pager >> "$REPORT_FILE"

echo "===== End of Report =====" >> "$REPORT_FILE"

