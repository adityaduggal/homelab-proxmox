# 📥 Deluge Torrent Client (Downloads LXC)

Deluge is your dedicated BitTorrent downloader. It's isolated in its own LXC to prevent high disk I/O from affecting your media streaming performance.

## 📊 Quick Links
- **Web UI:** https://deluge.j1103.in
- **Alt Domain:** https://torrent.j1103.in
- **Internal IP:** 10.3.1.104

## 📂 Storage
- **/mnt/downloads**: All downloads are saved to this path. This path must be shared (via NFS or Bind Mount) to the Servarr LXC.
- **/etc/deluge**: Configuration and torrent database (backup-ready).

## 🛠️ Configuration
- **Default Password:** `deluge` (⚠️ Change immediately after first login!).
- **Remote Access:** The Deluge daemon (port 58846) is exposed to allow Servarr apps (Radarr, Sonarr) to connect.
- **VPN:** Not included by default. It's recommended to run a VPN client (like WireGuard) on the Proxmox host or within this LXC for secure torrenting.

## 🚏 Traefik Logic
Traefik is configured to expose the Deluge WebUI (port 8112) via `https://deluge.j1103.in`.
