# Network Security with Proxy, IDS/IPS & SIEM

## 📌 Project Overview
This project demonstrates the design and implementation of a **secure enterprise-grade network**
using **Debian Linux** and **VirtualBox**. The architecture focuses on **network segmentation,
controlled internet access, attack detection & prevention, and centralized monitoring**.

The project simulates a **real-world enterprise security environment** by implementing
a firewall with LAN–DMZ separation, deploying a proxy server, enabling IDS/IPS capabilities,
and integrating a SIEM platform for visibility and analysis.

---

## 🧱 Architecture Summary
The network is divided into multiple security zones:

- **LAN** – Internal users
- **DMZ** – Public-facing services (Web Server & Proxy)
- **WAN** – Internet
- **Management Network** – SIEM monitoring

Security controls are enforced using Linux firewalling, intrusion detection/prevention,
and centralized logging.

---

## 🌐 Network Design

| Component | IP Address |
|--------|------------|
Firewall (LAN) | 192.168.10.1
Client Machine | 192.168.10.10
Web Server (DMZ) | 192.168.20.10
Proxy Server (DMZ) | 192.168.20.20
Splunk SIEM Server | 192.168.10.50

---

## 🔥 Key Security Features

### 🔐 Firewall (iptables)
- Stateful packet filtering
- NAT for LAN and DMZ networks
- Strict LAN ↔ DMZ isolation
- Controlled access to services
- Inline traffic inspection via NFQUEUE

### 🌐 Proxy Server (Squid)
- Centralized internet access control
- Prevents direct client internet exposure
- Improves security visibility and policy enforcement

### 🚨 IDS / IPS (Suricata)
- Inline IPS mode using NFQUEUE
- Detects network reconnaissance (Nmap scans)
- Automatically blocks malicious traffic
- Generates structured security alerts

### 📊 SIEM (Splunk)
- Centralized log collection
- Suricata alerts forwarded via Universal Forwarder
- Real-time security monitoring and analysis
- Attack visibility with source/destination correlation

---

## 🧪 Attack Detection Demonstration
1. An **Nmap SYN scan** is launched from the LAN client.
2. The firewall forwards traffic to **Suricata IPS**.
3. Suricata detects reconnaissance behavior.
4. Malicious packets are **blocked inline**.
5. Alerts are forwarded to **Splunk SIEM** for monitoring.

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
- SIEM integration and log analysis
- Security-focused system documentation

---

## 📁 Repository Structure
    firewall/ → iptables firewall rules
    ids_ips/ → Suricata configuration and detection rules
    proxy/ → Squid proxy configuration
    splunk/ → SIEM and forwarder setup
    diagrams/ → Network architecture diagrams
    screenshots/ → Proof of detection & blocking

---

## 👤 Author
**Varad Suryawanshi**  
Cybersecurity & Network Security Enthusiast  

> *This project was built for learning, demonstration, and interview preparation purposes,
simulating real enterprise security controls and workflows.*
