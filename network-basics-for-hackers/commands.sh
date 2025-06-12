#!/bin/bash

########################################################################################
# NETWORK SCANNING & ENUMERATION
########################################################################################

# Full TCP connect scan on Metasploitable-2 (replace <TARGET_IP> with actual IP)
echo "=== TCP Port Scan ==="
sudo nmap -sT TARGET_IP

# UDP port scan (takes longer due to protocol behavior)
echo "=== UDP Port Scan ==="
nmap -sU TARGET_IP

# Ping a domain/IP to check reachability
echo "=== Ping Check ==="
ping hackers-arise.com # Or: ping <IP_ADDRESS>

########################################################################################
# CONNECTION MONITORING TOOLS
########################################################################################

# Netstat - view all connections and listeners
echo "=== Netstat Output ==="
netstat -a             # View all connections
netstat -a | grep http # Filter for HTTP

# Show TCP, UDP connections, listening ports with ss (modern netstat)
echo "=== ss Output ==="
ss

########################################################################################
# TRAFFIC CAPTURE & ANALYSIS (tcpdump)
########################################################################################

# Basic live sniffing with tcpdump
echo "=== Start Packet Capture ==="
# tcpdump

# Capture packets to a file for later analysis in Wireshark
tcpdump -w myoutput.cap

# Verbose capture filtered by destination port 80
tcpdump -vv dst port 80

# Capture only SYN packets (useful for detecting scans)
tcpdump 'tcp[tcpflags] == tcp-syn'

# Filter by host and port
tcpdump host 192.168.0.114 and port 80

# OR multiple ports
tcpdump port 80 or port 443

# NOT from specific host
tcpdump not host 192.168.0.114

########################################################################################
# PAYLOAD FILTERING (Credentials, Cookies, User-Agent)
########################################################################################

# Attempt to filter for plaintext credentials on common ports
# tcpdump port 80 or port 21 or port 25 or port 110 or port 143 or port 23 -lA | \
egrep -i 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|password='

# Capture HTTP headers (User-Agent)
tcpdump -vvAls 0 | grep 'User-Agent'

# Capture Cookie-related headers
tcpdump -vvAls 0 | grep -E 'Set-Cookie|Host|Cookie:'

########################################################################################
# NOTES
# - Replace <TARGET_IP> or <IP_ADDRESS> accordingly.
# - For `tcpdump -vvAls`, use `-s 0` to capture full packet payloads.
# - Make sure you use real hyphens (-) not en-dashes (–) in command-line usage.
# - Run tcpdump and nmap as root or with sudo for best results.
########################################################################################
