#!/bin/sh


printf "Total CPU usage: "
ps -e -o pcpu= | awk '{sum += $1} END {print sum}' 
echo ""

echo "Total Memory Usage"
echo "------------------------------------------"
free -h 
echo "------------------------------------------"
echo ""

echo "Total Disk Usage"
echo "------------------------------------------"
df -h 
echo "------------------------------------------"
echo ""

echo "Top Five Processes by CPU usage"
echo "------------------------------------------"
echo "USER    PID    %CPU   COMMAND"
ps -e -o user= -o pid= -o pcpu= -o comm= | sort -k3 -rn | head -5
echo "------------------------------------------"
echo ""

echo "Top Five Processes by Memory usage"
echo "------------------------------------------"
echo "USER    PID    %MEM   COMMAND"
ps -e -o user= -o pid= -o pmem= -o comm= | sort -k3 -rn | head -5
echo "------------------------------------------"
echo ""

