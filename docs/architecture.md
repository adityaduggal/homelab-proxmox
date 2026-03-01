# 🏗️ Homelab Architecture Overview

The system is designed to be resource-efficient and easy to maintain by grouping related services into functional LXC containers.

## 📦 Container Grouping Logic

### 1. LXC-Network (Gateway)
- **Service:** Traefik
- **Role:** Handles all incoming traffic, reverse proxying, and SSL termination.
- **Port 80/443:** Only port 80/443 are exposed to the local network for routing.
- **Redirects:** Implements shortname to FQDN redirects (e.g., `jellyfin/` -> `jellyfin.j1103.in`).

### 2. LXC-Media (Core)
- **Service:** Jellyfin
- **Role:** Heavy lifting for media streaming and transcoding.
- **Hardware:** Accesses host GPU/Intel QuickSync (`/dev/dri/renderD128`) for transcoding.

### 3. LXC-Servarr (The Brains)
- **Services:** Radarr, Sonarr, Prowlarr, Bazarr, Jellyseerr, Recyclarr, Flaresolverr.
- **Consolidation:** These lightweight apps are grouped into one LXC for efficiency and shared storage logic.
- **Backup:** Single backup policy for `/opt/servarr_configs`.

### 4. LXC-Downloads (Edge)
- **Service:** Deluge
- **Role:** Handles torrenting. High disk I/O and potential VPN requirement.
- **Isolation:** Isolated from media streaming.

### 5. LXC-Home (Automation)
- **Service:** Home Assistant
- **Role:** Smart Home management.
- **Networking:** Uses `host` networking for discovery.
- **Integration:** Controls **Opnsense** via HACS for AI-driven security monitoring.

---

## 🌐 Opnsense Firewall Integration

The homelab architecture relies on an external Opnsense firewall (separate hardware) for core network services:

1.  **Gateway:** 10.3.0.1
2.  **DHCP & Wireguard:** Managed by Opnsense.
3.  **Home Assistant Integration:**
    - **HACS Plugin:** The "Opnsense" custom integration is used within Home Assistant.
    - **AI Monitoring:** Enables Home Assistant to monitor bandwidth, firewall logs, and active VPN clients for automated AI responses.

## 🌐 Networking
- **Local Subdomains:** Managed by Traefik and individual certificates for `j1103.in`.
- **Shortnames:** Traefik middlewares handle `http://service/` to `https://service.j1103.in/` redirection.
