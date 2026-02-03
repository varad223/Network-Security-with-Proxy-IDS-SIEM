# IDS / IPS – Suricata

## Purpose
Suricata is deployed in **inline IPS mode** to inspect and block malicious traffic in real time.

---

## IDS vs IPS
- **IDS** detects attacks and generates alerts
- **IPS** actively blocks malicious packets

This project uses **IPS mode**.

---

## Detection Flow
1. Firewall forwards packets to NFQUEUE
2. Suricata inspects traffic
3. Malicious patterns are detected
4. Traffic is dropped
5. Alerts are logged and forwarded to SIEM

---

## Files
- `suricata.yaml` – Main configuration
- `local.rules` – Custom detection rules
