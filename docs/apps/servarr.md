# 📦 Servarr Automation Stack (Servarr LXC)

The Servarr stack consists of multiple interconnected applications that automate your media downloads and library management. All these apps are consolidated into a single LXC to reduce resource overhead.

## 📊 Application Dashboard
All these apps can be accessed via their specific subdomains on `j1103.in`.

| Application | Role | Subdomain | Internal Port |
| :--- | :--- | :--- | :--- |
| **Radarr** | Movies Manager | `radarr`, `movies` | 7878 |
| **Sonarr** | TV Show Manager | `sonarr`, `tv` | 8989 |
| **Prowlarr** | Indexer Sync | `prowlarr`, `index` | 9696 |
| **Bazarr** | Subtitle Manager | `bazarr`, `subtitles` | 6767 |
| **Jellyseerr** | Media Requests | `jellyseerr`, `requests` | 5055 |
| **Flaresolverr** | Proxy | Internal Only | 8191 |
| **Recyclarr** | Config Sync | `recyclarr`, `sync` | 443 |

## 🚀 Shared Paths
All these applications share a common data structure to simplify path mapping and backups.

- **/opt/servarr_configs**: Parent folder for all individual app configurations.
- **/mnt/media**: Common media root (e.g., /mnt/media/movies, /mnt/media/tv).
- **/mnt/downloads**: Common download path (must match Deluge).

## 📂 Backup Strategy
- **Backup Rule:** The entire `/opt/servarr_configs` directory is compressed and backed up to Google Drive.
- **Restore:** The `restore_stack.yml` playbook will restore all these apps simultaneously.

## 🛠️ Configuration
- **API Keys:** You will need to manually copy API keys between apps (e.g., Sonarr to Prowlarr) through their respective Web UIs.
- **Download Client:** Point all apps to the `downloads.j1103.in` (Deluge) service.
