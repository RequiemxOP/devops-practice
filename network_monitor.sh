#!/bin/bash

HOSTS=("8.8.8.8" "1.1.1.1" "github.com" "google.com")
REPORT="/training/reports/network_monitor_$(date +%Y-%m-%d_%H-%M-%S).txt"
mkdir -p /training/reports

echo "===== Network Monitor Report =====" | tee "$REPORT"
echo "" | tee -a "$REPORT"

# 1. Ping multiple hosts
echo ">>> Ping Multiple Hosts" | tee -a "$REPORT"
for host in "${HOSTS[@]}"; do
    echo "Pinging $host..." | tee -a "$REPORT"
    ping -c 3 "$host" | tee -a "$REPORT"
    echo "" | tee -a "$REPORT"
done

# 2. Traceroute for each host
echo ">>> Traceroute to Hosts" | tee -a "$REPORT"
for host in "${HOSTS[@]}"; do
    echo "Tracerouting $host..." | tee -a "$REPORT"
    traceroute "$host" | tee -a "$REPORT"
    echo "" | tee -a "$REPORT"
done

# 3. Connection status (network routes)
echo ">>> Connection Status" | tee -a "$REPORT"
ip route show | tee -a "$REPORT"
echo "" | tee -a "$REPORT"

# 4. List active sockets
echo ">>> Active Sockets (TCP/UDP)" | tee -a "$REPORT"
ss -tunapl | tee -a "$REPORT"

echo "" | tee -a "$REPORT"
echo "===== End of Report =====" | tee -a "$REPORT"

