#!/bin/bash
# ============================================================
# FINAL ENTERPRISE FIREWALL
# LAN + DMZ + PROXY + IDS/IPS + SYSLOG + SPLUNK
# (FIXED: Webserver Internet Access + Return Traffic)
# ============================================================

# Interfaces
WAN=enp0s3
LAN=enp0s8
DMZ=enp0s9

# Networks
LAN_NET=192.168.10.0/24
DMZ_NET=192.168.20.0/24

# Hosts
WEB=192.168.20.10
PROXY=192.168.20.20
SPLUNK=192.168.10.50

echo "[+] Enabling IP forwarding"
sysctl -w net.ipv4.ip_forward=1 > /dev/null

echo "[+] Flushing old rules"
iptables -F
iptables -t nat -F
iptables -X

echo "[+] Default policies"
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# ================= INPUT =================
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# SSH from LAN
iptables -A INPUT -i $LAN -p tcp --dport 22 -j ACCEPT

# ICMP
iptables -A INPUT -p icmp -j ACCEPT

# Allow SYSLOG from DMZ
iptables -A INPUT -s $DMZ_NET -p udp --dport 514 -j ACCEPT

# ================= NAT =================
iptables -t nat -A POSTROUTING -s $LAN_NET -o $WAN -j MASQUERADE
iptables -t nat -A POSTROUTING -s $DMZ_NET -o $WAN -j MASQUERADE

# ================= SPLUNK =================
# Firewall -> Splunk receiver
iptables -A OUTPUT -p tcp -d $SPLUNK --dport 9997 -j ACCEPT

# Splunk ACKs back to firewall (established only)
iptables -A INPUT  -p tcp -s $SPLUNK --sport 9997 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# ================= FORWARD =================

# 1️⃣ Allow return traffic FIRST (CRITICAL)
iptables -I FORWARD 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# ✅ FIX: Allow WAN replies back to WEB (Return traffic for outbound web/DNS)
iptables -I FORWARD 2 -d $WEB -i $WAN -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# 2️⃣ Proxy bypass IPS (stability)
iptables -I FORWARD 3 -s $PROXY -o $WAN -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -I FORWARD 4 -d $PROXY -i $WAN -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Allow LAN -> Proxy (explicit)
iptables -I FORWARD 5 -s $LAN_NET -d $PROXY -p tcp --dport 3128 -j ACCEPT

# 3️⃣ IDS / IPS (Suricata inline)
iptables -I FORWARD 6 -p tcp -j NFQUEUE --queue-num 0

# ================= LAN ACCESS =================
iptables -A FORWARD -s $LAN_NET -d $PROXY -p tcp --dport 3128 -j ACCEPT
iptables -A FORWARD -s $LAN_NET -d $WEB -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -s $LAN_NET -d $WEB -p tcp --dport 443 -j ACCEPT

# ================= WEB SERVER INTERNET =================
# Web -> Internet browsing/updates
iptables -A FORWARD -s $WEB -o $WAN -p tcp -m multiport --dports 80,443 -j ACCEPT

# DNS from Web
iptables -A FORWARD -s $WEB -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -s $WEB -p tcp --dport 53 -j ACCEPT

# ================= PROXY SERVER =================
# Proxy -> Internet browsing/updates
iptables -A FORWARD -s $PROXY -o $WAN -p tcp -m multiport --dports 80,443 -j ACCEPT

# DNS from Proxy
iptables -A FORWARD -s $PROXY -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -s $PROXY -p tcp --dport 53 -j ACCEPT

# ================= BLOCK DMZ → LAN =================
iptables -A FORWARD -i $DMZ -o $LAN -j DROP

echo "[✔] Firewall loaded successfully (Webserver internet fixed)"