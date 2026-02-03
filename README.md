# Enterprise Network Security Architecture  
## Firewall, DMZ, VPN, Proxy, IDS/IPS & SIEM

---

## 📌 Project Overview
This project demonstrates the design and implementation of a **secure enterprise-grade network architecture** using **Debian Linux** and **VirtualBox**.

The goal of this project was to **connect multiple security controls together**—firewall, proxy, IDS/IPS, and SIEM—to simulate how real organizations **detect, block, and analyze network attacks**.

Rather than focusing on a single tool, this lab shows **end-to-end traffic flow and security visibility**.

---

## 🎯 Why This Project
During my PG-DITISS training, most labs focused on individual tools (only firewall, only IDS, or only SIEM).  
In real enterprises, these components **work together**.

This project was built to demonstrate:
- Network segmentation using **LAN, DMZ, WAN, and VPN**
- Controlled internet access using a **proxy**
- **Inline intrusion prevention** using Suricata
- **Centralized monitoring and alerting** using SIEM

---

## 🧱 Architecture Summary
The network is divided into multiple security zones:

- **LAN** – Internal users  
- **DMZ** – Public-facing services (Web Server & Proxy)  
- **WAN** – Internet  
- **Management Network** – SIEM monitoring  

All inter-zone communication is enforced using **iptables firewall rules**.

---

## 🌐 Network Design

| Component | IP Address |
|---|---|
| Firewall (LAN) | 192.168.10.1 |
| Client Machine | 192.168.10.10 |
| Web Server (DMZ) | 192.168.20.10 |
| Proxy Server (DMZ) | 192.168.20.20 |
| Splunk SIEM Server | 192.168.10.50 |

---

## 🔥 Key Security Components

### 🔐 Firewall (iptables)
- Default **DROP** policy (zero-trust)
- Stateful packet filtering
- NAT for LAN and DMZ
- Strict **LAN ↔ DMZ isolation**
- Inline traffic inspection using **NFQUEUE**

### 🌐 Proxy Server (Squid)
- Centralized internet access for LAN users
- Prevents direct LAN-to-internet communication
- Improves visibility and policy enforcement

### 🚨 IDS / IPS (Suricata)
- Inline IPS mode using NFQUEUE
- Detects reconnaissance activity (e.g., Nmap scans)
- Automatically blocks malicious traffic
- Generates structured security alerts

### 📊 SIEM (Splunk)
- Centralized log collection
- Suricata alerts forwarded via Universal Forwarder
- Real-time monitoring and alert correlation
- Visibility into blocked IPs and attack attempts

---

## 🧪 Attack Detection Demonstration
1. An **Nmap SYN scan** is launched from a LAN client  
2. Traffic is forwarded by the firewall  
3. Suricata detects reconnaissance behavior  
4. Malicious packets are blocked inline  
5. Alerts are forwarded to Splunk SIEM  

---

## 🛠 Technologies Used
- Debian Linux 13  
- iptables  
- Suricata IDS/IPS  
- Squid Proxy Server  
- Splunk Enterprise SIEM  
- VirtualBox  

---

## 🎓 Learning Outcomes
- Enterprise firewall rule design
- DMZ architecture and isolation
- IDS vs IPS practical implementation
- Network attack simulation and mitigation
- SIEM-based monitoring and analysis
- Security-focused documentation

---

## 📁 Repository Structure
```text
firewall/     → iptables firewall rules  
ids_ips/      → Suricata configuration and detection rules  
proxy/        → Squid proxy configuration  
splunk/       → SIEM and log forwarding setup  
diagrams/     → Network architecture diagrams  
screenshots/  → Proof of detection and blocking  
