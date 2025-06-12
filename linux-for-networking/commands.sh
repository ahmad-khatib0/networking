#!/bin/bash

########################################################################################
# NETWORK & SYSTEM DIAGNOSTIC COMMANDS
########################################################################################

# Display IP address information (IPv4 only)
echo "=== IP Address Info ==="
ip -4 ad

# Show all interfaces (legacy)
echo "=== ifconfig Info ==="
ifconfig

# Show current routing table (legacy)
echo "=== Routing Table ==="
netstat -rn # or use: route -n

# Display NetworkManager connections
echo "=== NetworkManager Connections ==="
sudo nmcli connection show

# Display ARP table timeout settings
echo "=== ARP Timeout Defaults ==="
cat /proc/sys/net/ipv4/neigh/default/gc_stale_time
cat /proc/sys/net/ipv4/neigh/docker0/gc_stale_time # Replace interface as needed

# Show memory usage info
echo "=== Memory Info ==="
cat /proc/meminfo | grep Mem

########################################################################################
# MANAGE ARP ENTRIES
########################################################################################

# Add static ARP entry
sudo arp -s 192.168.122.200 00:11:22:22:33:33
# View ARP entry
arp -a | grep 192.168.122.200

# Delete ARP entry (with or without interface)
sudo arp -i ens33 -d 192.168.122.200

# Answer ARP requests for another IP (ARP spoofing/masquerading)
sudo arp -i eth0 -Ds 10.0.0.2 eth1 pub

########################################################################################
# MAC ADDRESS OPERATIONS
########################################################################################

# Show MAC address
ip link show INTERFACE_NAME | grep link

# Change MAC address (temporary)
sudo ip link set dev ens33 down
sudo ip link set dev ens33 address 00:88:77:66:55:44
sudo ip link set dev ens33 up

# To make the change persistent (example netplan config)
# File: /etc/netplan/01-network-manager-all.yaml
: '
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: true
      match:
        macaddress: b6:22:eb:7b:92:44
      macaddress: xx:xx:xx:xx:xx:xx
'

########################################################################################
# CHECKING OPEN PORTS
########################################################################################

# Check open ports: TCP, UDP, don't resolve names
echo "=== Open Ports (netstat) ==="
netstat -tuan

# Include listening ports and programs (netstat)
echo "=== Listening Ports with Programs (netstat) ==="
sudo netstat -tulpn

# Same as above with `ss` (modern)
echo "=== Listening Ports with Programs (ss) ==="
sudo ss -tuap

# Format `ss` output using tr + cut
echo "=== Formatted ss Output ==="
sudo ss -t -u -a -p | tr -s ' ' | cut -d ' ' -f 1,2,4,5,6 --output-delimiter=$'\t'

# Save `ss` output as TSV
echo "=== Saving Output to ports.tsv ==="
sudo ss -tuap | tr -s ' ' | cut -d ' ' -f 1,2,5,6 --output-delimiter=$'\t' >ports.tsv

# Log established connections to file and STDOUT
echo "=== Logging EST connections ==="
sudo ss -tuap | tr -s ' ' | cut -d ' ' -f 1,2,5,6 --output-delimiter=$'\t' | grep "EST" | tee ports.out
