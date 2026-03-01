# 🎬 Jellyfin Media Server (Media LXC)

Jellyfin is your local media streaming hub. It's fully accelerated with Intel QuickSync/GPU.

## 📊 Quick Links
- **Web UI:** https://jellyfin.j1103.in
- **Alt Domain:** https://media.j1103.in
- **Internal IP:** 10.3.1.102

## 🚀 Performance & HW Acceleration
- **GPU Passthrough:** Enabled via `/dev/dri/renderD128`.
- **User Groups:** The container runs with the `homelab` user (UID: 1000) with permissions for `render` and `video` groups.

## 📂 Storage
- **/mnt/media:** This path contains all your media files. It's recommended to mount a separate ZFS pool or Proxmox storage at this location.
- **/etc/jellyfin:** Configuration and user database (backup-ready).

## 🛠️ Configuration
- **Transcoding:** Must be enabled manually in the Jellyfin Dashboard (Admin > Playback > Hardware Acceleration).
- **Network Setting:** "Allow remote connections to this server" must be checked to work with Traefik.
