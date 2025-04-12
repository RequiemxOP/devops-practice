#!/bin/bash

echo "===== SYSTEM REPORT ====="
echo

echo "---- CPU DETAILS ----"
lscpu
echo

echo "---- MEMORY USAGE ----"
free -h
echo

echo "---- DISK SPACE ----"
df -h
echo

echo "---- RUNNING PROCESSES ----"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -15
echo

echo "---- NETWORK INTERFACES ----"
ip addr show

