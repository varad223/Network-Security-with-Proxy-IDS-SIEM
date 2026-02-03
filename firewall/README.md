```markdown
# Firewall Configuration (iptables)

## Purpose
The firewall is the **core security control** of this architecture.  
It enforces segmentation between LAN, DMZ, WAN, and VPN while controlling all traffic flow.

---

## Key Design Principles
- Default **DROP** policy (zero trust)
- Explicit allow rules only
- Stateful inspection
- No direct LAN → DMZ access
- IDS-safe traffic handling using NFQUEUE

---

## Implemented Controls
- LAN users must access the internet via the proxy
- DMZ services cannot initiate connections to LAN
- VPN users can only access DMZ web services
- NAT applied only where required
- Traffic forwarded to Suricata for inline inspection

---

## Files
- `firewall_final_ips_proxy.sh` – Complete firewall ruleset