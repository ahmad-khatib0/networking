Here’s a **compact cheat sheet** of essential Linux networking tools, categorized by purpose:

---

### **1. Interface & IP Management**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `ip`               | Modern replacement for `ifconfig`/`route` | `ip addr show`                         |
| `ifconfig`         | Legacy interface config (deprecated)     | `ifconfig eth0 192.168.1.2`            |
| `ethtool`          | Interface stats/settings                 | `ethtool eth0`                         |
| `nmcli`            | NetworkManager CLI (for GUI distros)     | `nmcli device status`                  |

---

### **2. Routing & Connectivity**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `ping`             | Check host reachability                  | `ping google.com`                      |
| `traceroute`       | Trace packet path                        | `traceroute google.com`                |
| `mtr`              | Real-time traceroute                     | `mtr google.com`                       |
| `ip route`         | Manage routing tables                    | `ip route add default via 192.168.1.1` |
| `ss` / `netstat`   | Socket statistics                        | `ss -tuln` (show open ports)           |

---

### **3. Packet Analysis**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `tcpdump`          | Capture network traffic                  | `tcpdump -i eth0 port 80`              |
| `wireshark`        | GUI packet analyzer                      | `wireshark` (launch GUI)               |
| `tshark`           | CLI version of Wireshark                 | `tshark -i eth0`                       |

---

### **4. Port & Service Testing**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `nc` (netcat)      | Read/write network connections           | `nc -zv 192.168.1.1 80` (port scan)    |
| `nmap`             | Network discovery/security scanner       | `nmap -sV 192.168.1.1`                 |
| `telnet`           | Test TCP connectivity                    | `telnet 192.168.1.1 22`                |
| `socat`            | Advanced socket relay                    | `socat TCP-LISTEN:8080,fork TCP:google.com:80` |

---

### **5. Firewall & Security**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `iptables`         | Legacy firewall                          | `iptables -A INPUT -p tcp --dport 22 -j ACCEPT` |
| `nftables`         | Modern firewall (replaces `iptables`)    | `nft add rule ip filter INPUT tcp dport 22 accept` |
| `ufw`              | User-friendly firewall                   | `ufw allow 22/tcp`                     |
| `openssl`          | TLS/SSL toolkit                          | `openssl s_client -connect google.com:443` |

---

### **6. DNS & HTTP Tools**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `dig`              | DNS lookup                               | `dig google.com`                       |
| `nslookup`         | Legacy DNS query                         | `nslookup google.com`                  |
| `curl`             | HTTP requests                            | `curl -v http://example.com`           |
| `httpie`           | User-friendly HTTP client                | `http GET http://example.com`          |
| `wget`             | Download files                           | `wget http://example.com/file.zip`     |

---

### **7. Bandwidth & Performance**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `iftop`            | Real-time bandwidth monitor              | `iftop -i eth0`                        |
| `nload`            | Per-interface traffic                    | `nload eth0`                           |
| `iperf3`           | Network speed test                       | `iperf3 -s` (server) / `iperf3 -c <IP>` (client) |
| `bmon`             | Visual bandwidth monitor                 | `bmon`                                 |

---

### **8. VPN & Tunneling**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `ssh`              | Secure shell (and tunneling)             | `ssh -L 8080:localhost:80 user@host`   |
| `wireguard`        | Modern VPN                               | `wg-quick up wg0`                      |
| `openvpn`          | Traditional VPN                          | `openvpn --config client.ovpn`         |
| `socat`            | Port forwarding                          | `socat TCP-LISTEN:8080,fork TCP:remote:80` |

---

### **9. Network Debugging**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `strace`           | Trace system calls                       | `strace -e trace=network curl example.com` |
| `dmesg`            | Kernel logs (for driver issues)          | `dmesg \| grep eth0`                   |
| `lsof`             | List open files (sockets)                | `lsof -i :80`                          |

---

### **10. Anonymity & Privacy**
| Command/Tool       | Description                              | Example Usage                          |
|--------------------|------------------------------------------|----------------------------------------|
| `tor`              | Onion routing                            | `torsocks curl ifconfig.me`            |
| `proxychains`      | Force apps through proxy                 | `proxychains curl ifconfig.me`         |
| `macchanger`       | Spoof MAC address                        | `macchanger -r eth0`                   |

---

### **Key Conventions**
1. **Prefer `ip` over `ifconfig`/`route`** (modern alternative).  
2. **Use `ss` instead of `netstat`** (faster, more detailed).  
3. **For firewalls**: `nftables` > `iptables` (newer, more efficient).  

