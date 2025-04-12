#!/bin/bash

TARGET=${1:-8.8.8.8} # Default target if none provided
REPORT="/training/reports/network_report_$(date +"%Y-%m-%d_%H-%M-%S").txt"
mkdir -p /training/reports

echo "==== Network Diagnostics for $TARGET ====" | tee "$REPORT"
echo "" | tee -a "$REPORT"

# Check if host is reachable
echo ">>> Checking Internet Connectivity" | tee -a "$REPORT"
ping -c 4 "$TARGET" | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# DNS Resolution
echo ">>> DNS Resolution" | tee -a "$REPORT"
nslookup google.com | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# Traceroute
echo ">>> Traceroute to $TARGET" | tee -a "$REPORT"
traceroute "$TARGET" | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# Port scan (example: check port 80 and 443)
echo ">>> Checking open ports on $TARGET (80, 443)" | tee -a "$REPORT"
nc -zv "$TARGET" 80 443 | tee -a "$REPORT" 2>&1
echo "" | tee -a "$REPORT"

# Show IP routing table
echo ">>> Routing Table" | tee -a "$REPORT"
ip route show | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# Show active interfaces
echo ">>> Network Interfaces" | tee -a "$REPORT"
ip -brief addr | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

echo "==== End of Diagnostics ====" | tee -a "$REPORT"

