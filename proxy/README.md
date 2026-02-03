# Squid Proxy Server

## Purpose
The Squid proxy enforces **controlled internet access** for internal LAN users.

Direct internet access from LAN is blocked at the firewall level.  
All outbound web traffic must pass through the proxy.

---

## Security Benefits
- Prevents direct exposure of internal clients
- Enables centralized logging of web access
- Simplifies policy enforcement
- Mirrors real enterprise proxy deployments

---

## Files
- `squid.conf` – Proxy configuration used in this project
