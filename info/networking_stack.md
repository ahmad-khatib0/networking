Here’s a structured breakdown of the **Linux networking stack**, covering tools, 
conventions, and key concepts:

---

### **1. Network Interfaces (iface)**
#### **Tools & Commands**
- **`ip` (modern)**:  
  ```bash
  ip addr show       # List interfaces
  ip link set eth0 up
  ip route add default via 192.168.1.1
  ```
- **`ifconfig` (legacy)**:  
  ```bash
  ifconfig eth0 192.168.1.2 netmask 255.255.255.0
  ```
- **`ethtool`**:  
  ```bash
  ethtool eth0       # Check interface stats/speed
  ```

#### **Conventions**
- **Naming**:  
  - `eth0`, `wlan0` (traditional).  
  - Predictable names (e.g., `enp3s0` for PCIe).  
- **Config Files**:  
  - `/etc/network/interfaces` (Debian).  
  - `/etc/sysconfig/network-scripts/ifcfg-eth0` (RHEL).  

---

### **2. IP Addressing & Routing**
#### **Tools**
- **`ip route`**:  
  ```bash
  ip route show      # View routing table
  ```
- **`netstat`/`ss`**:  
  ```bash
  ss -tuln           # Show open ports (modern)
  netstat -tuln      # Legacy alternative
  ```
- **`traceroute`/`mtr`**:  
  ```bash
  mtr google.com     # Real-time traceroute
  ```

#### **Network Masks (CIDR)**
- **Notation**: `192.168.1.0/24` (mask `255.255.255.0`).  
- **Calculate**: Use `ipcalc` or Python:  
  ```bash
  ipcalc 192.168.1.10/24
  ```

---

### **3. Packet Analysis & Debugging**
#### **Tools**
- **`tcpdump`**:  
  ```bash
  tcpdump -i eth0 port 80
  ```
- **`Wireshark`**: GUI for deep packet analysis.  
- **`nc` (netcat)**:  
  ```bash
  nc -lvnp 8080      # Listen on port
  nc -zv 192.168.1.1 80  # Port scan
  ```
- **`nmap`**:  
  ```bash
  nmap -sV 192.168.1.1  # Service/OS detection
  ```

---

### **4. Network Security**
#### **Certificates & TLS**
- **OpenSSL**:  
  ```bash
  openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
  ```
- **`certbot` (Let’s Encrypt)**:  
  ```bash
  certbot --nginx -d example.com
  ```

#### **Firewalling**
- **`iptables`/`nftables`**:  
  ```bash
  iptables -A INPUT -p tcp --dport 22 -j ACCEPT
  ```
- **`ufw` (user-friendly)**:  
  ```bash
  ufw allow 22/tcp
  ```

---

### **5. Advanced Tools**
#### **Reverse Engineering**
- **Ghidra**: Analyze network binaries for vulnerabilities.  
- **`strace`**: Trace syscalls of network apps:  
  ```bash
  strace -e trace=network curl example.com
  ```

#### **Load Testing**
- **`ab` (Apache Bench)**:  
  ```bash
  ab -n 1000 -c 10 http://example.com/
  ```
- **`vegeta`**:  
  ```bash
  echo "GET http://example.com" | vegeta attack -rate=10/s
  ```

---

### **6. Virtual Networking**
#### **Namespaces & Virtual Interfaces**
- **`ip netns`**:  
  ```bash
  ip netns add ns1
  ip link add veth0 type veth peer name veth1
  ```
- **VPNs**:  
  - `OpenVPN`, `WireGuard` (`wg-quick`).  

#### **Container Networking**
- **Docker**:  
  ```bash
  docker network ls
  ```
- **Kubernetes CNI**:  
  - Calico, Cilium, Flannel.  

---

### **7. Protocol-Specific Tools**
| Protocol  | Tools                          |
|-----------|--------------------------------|
| **HTTP**  | `curl`, `httpie`, `wget`       |
| **DNS**   | `dig`, `nslookup`              |
| **DHCP**  | `dhclient`, `dnsmasq`          |
| **SSH**   | `ssh`, `scp`, `autossh`        |

---

### **8. Network Masking & Anonymity**
- **Proxy Chains**:  
  ```bash
  proxychains curl ifconfig.me
  ```
- **TOR**:  
  ```bash
  sudo apt install tor
  torsocks curl ifconfig.me
  ```
- **MAC Spoofing**:  
  ```bash
  ip link set eth0 address 00:11:22:33:44:55
  ```

---

### **9. Performance Monitoring**
- **`iftop`**: Bandwidth usage per connection.  
- **`nload`**: Real-time traffic monitoring.  
- **`bmon`**: Visual interface stats.  

---

### **10. Linux Kernel Networking**
- **Sysctls**:  
  ```bash
  sysctl net.ipv4.ip_forward=1   # Enable routing
  ```
- **Kernel Modules**:  
  ```bash
  lsmod | grep nf_conntrack      # Track connections
  ```

---

### **Key Conventions**
1. **Config Files**: Prefer `/etc/` over runtime commands for persistence.  
2. **Modern Tools**: Use `ip` instead of `ifconfig`/`route`.  
3. **Security**:  
   - Always use TLS (e.g., `certbot`).  
   - Restrict services with `iptables`/`nftables`.  

