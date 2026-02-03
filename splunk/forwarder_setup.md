# Splunk Universal Forwarder Setup

This document describes how the Splunk Universal Forwarder was configured
to forward security logs to the SIEM server.

---

## System
- Installed on: IDS / Firewall system
- OS: Debian Linux
- Forwarding Protocol: TCP

---

## Configuration Steps

1. Installed Splunk Universal Forwarder
2. Enabled forwarding to Splunk Enterprise server on port 9997
3. Configured log inputs using inputs.conf
4. Restarted the forwarder service
5. Verified connectivity to SIEM server

---

## Forwarding Configuration
- Destination: Splunk SIEM Server
- Port: 9997
- Data Type: Security and system logs

---

## Verification
- Forwarder status verified using Splunk CLI
- Incoming events confirmed on SIEM dashboard
- Suricata alerts successfully indexed

---

## Result
Security events from IDS and firewall systems are now
centrally visible within the SIEM platform.
