#!/bin/bash

REPORT="/training/reports/connectivity_$(date +"%Y-%m-%d_%H-%M-%S").txt"
mkdir -p /training/reports

echo "===== Network Connectivity Test =====" | tee "$REPORT"
echo "" | tee -a "$REPORT"

# 1. Default gateway test
echo ">>> Default Gateway Test" | tee -a "$REPORT"
GATEWAY=$(ip route | grep default | awk '{print $3}')
ping -c 2 "$GATEWAY" | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# 2. Internet connectivity test
echo ">>> Internet Connectivity Test (to 8.8.8.8)" | tee -a "$REPORT"
ping -c 2 8.8.8.8 | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# 3. DNS resolution test
echo ">>> DNS Resolution Test (google.com)" | tee -a "$REPORT"
dig +short google.com | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# 4. HTTP/HTTPS port check on google.com
echo ">>> Port Check (google.com:80 and 443)" | tee -a "$REPORT"
nc -zv google.com 80 443 | tee -a "$REPORT" 2>&1
echo "" | tee -a "$REPORT"

# 5. Check local IP addresses
echo ">>> Network Interface Status" | tee -a "$REPORT"
ip addr show | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

echo "===== End of Connectivity Test =====" | tee -a "$REPORT"

