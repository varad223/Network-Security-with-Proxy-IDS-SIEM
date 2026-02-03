# Splunk Enterprise SIEM Setup

This document outlines the basic setup of the Splunk Enterprise server
used for centralized security monitoring.

---

## System Details
- Role: SIEM Server
- OS: Debian Linux
- Splunk Enterprise (Standalone)

---

## Server Configuration

1. Installed Splunk Enterprise
2. Enabled receiving on TCP port 9997
3. Created indexes for security and network events
4. Verified forwarder connectivity
5. Configured dashboards for alert visibility

---

## Indexes Used
- security – IDS/IPS alerts and attack data
- network – Firewall and network events
- os – System-level logs

---

## Data Visibility
- Suricata alerts visible in real time
- Blocked IP addresses identified
- Attack source and destination correlation possible

---

## Outcome
The SIEM server provides centralized visibility into
security incidents and network activity across the environment.
