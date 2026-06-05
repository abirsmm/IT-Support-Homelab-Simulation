# IT Handover Document

**Prepared for:** Next IT Administrator  
**Prepared by:** MD ABIR KHAN  
**Date:** June 2026  

---

## 1. Network Overview

| Component | Details |
|-----------|---------|
| Firewall | pfSense 2.7.2 CE |
| Gateway IP | 192.168.10.1 |
| WAN | 10.0.2.15 (NAT through VirtualBox) |
| LAN Range | 192.168.10.0/24 |
| DHCP Range | 192.168.10.100 - 192.168.10.200 |
| CCTV VLAN | 192.168.20.0/24 (ISOLATED) |

---

## 2. Device Inventory

| Device | IP Address | OS | RAM | Purpose |
|--------|------------|-----|-----|---------|
| pfSense | 192.168.10.1 | pfSense 2.7.2 | 1GB | Firewall/Router |
| Office-PC | DHCP (.100-.200) | Windows 10/11 | 4GB | General office work |
| Warehouse-PC | DHCP (.100-.200) | Windows 10/11 | 2GB | Inventory management |
| Ubuntu-POS | 192.168.10.50 (Static) | Ubuntu 22.04 | 2GB | Point of Sale system |
| CCTV-Test | 192.168.20.100 (Static) | Any | 1GB | Security cameras |

---

## 3. Firewall Rules

### LAN Tab (Office Network)
| # | Action | Source | Destination | Description |
|---|--------|--------|-------------|-------------|
| 1 | BLOCK | 192.168.10.0/24 | 192.168.20.0/24 | Block office from accessing CCTV |
| 2 | ALLOW | LAN net | Any | Default internet access |

### CCTV Tab (Security Network)
| # | Action | Source | Destination | Description |
|---|--------|--------|-------------|-------------|
| 1 | BLOCK | CCTV address | LAN address | Block CCTV from accessing office |

---

## 4. Common Tasks

### Add a new employee:
1. Create Windows local account
2. Add to department groups
3. Map Z: drive: `net use Z: \\192.168.10.15\Shared /persistent:yes`
4. Add HP printer: IP 192.168.10.45

### Check if internet is down:
1. From any PC: `ping 192.168.10.1` (gateway)
2. If gateway works: `ping 8.8.8.8`
3. If both fail: Reboot pfSense (console → option 5)

### Reset forgotten password:
1. Boot from Windows USB
2. Navigate to `C:\Windows\System32`
3. Rename `utilman.exe` → `utilman.bak`
4. Copy `cmd.exe` → `utilman.exe`
5. Reboot → click Ease of Access → type `net user username newpassword`

---

## 5. Troubleshooting Guide

| Problem | Likely Cause | Solution |
|---------|--------------|----------|
| No internet | pfSense down | Reboot pfSense VM |
| Can't map Z: drive | File server offline | Check if \\192.168.10.15 is reachable |
| Printer offline | Spooler stuck | Restart Print Spooler service |
| Slow network | Background updates | Check Task Manager → network usage |
| CCTV unreachable | VLAN isolation | This is by design (security feature) |

---

## 6. Passwords (Change on first login)

| System | Username | Password |
|--------|----------|----------|
| pfSense Web GUI | admin | pfsense |
| Office-PC local admin | Administrator | ChangeMe@123 |
| Ubuntu-POS | zone57 | Zone57@123 |

---

## 7. Backup Procedures

| What | How Often | Location |
|------|-----------|----------|
| pfSense config | Monthly | Download XML from Diagnostics → Backup |
| Critical files | Weekly | Manual copy to USB drive |
| Firewall logs | Monthly | Export from Status → System Logs |

---

## 8. Emergency Contacts

| Issue | Action |
|-------|--------|
| Fire/Evacuation | Shut down PCs gracefully (don't save files) |
| Power outage | UPS lasts 15 minutes → save work immediately |
| Internet down | Reboot pfSense (takes 2 minutes) |

---

## 9. Future Improvements

- [ ] Add Active Directory for centralized user management
- [ ] Deploy network backup solution (NAS)
- [ ] Set up monitoring (PRTG or Zabbix)
- [ ] Document all IP addresses in a spreadsheet

---

**Document End**  
*Handover complete — new administrator can operate all systems*