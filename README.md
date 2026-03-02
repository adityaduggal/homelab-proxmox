# 🏠 Homelab Proxmox Automation
[![Proxmox](https://img.shields.io/badge/Hypervisor-Proxmox_VE-orange.svg)](https://www.proxmox.com/en/)
[![Ansible](https://img.shields.io/badge/Config-Ansible-red.svg)](https://www.ansible.com/)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-blueviolet.svg)](https://www.terraform.io/)

A fully automated, "one-click" deployment for a Proxmox-based homelab. This repository uses Terraform to provision infrastructure and Ansible to configure services, optimized for resource efficiency and easy backups.

## 🏗️ Architecture
To balance isolation and resource usage, services are consolidated into 5 functional LXC containers:

1.  **LXC-Network:** Traefik Reverse Proxy (SSL via LetsEncrypt).
2.  **LXC-Media:** Jellyfin (with Hardware Passthrough).
3.  **LXC-Servarr:** Consolidated stack (Radarr, Sonarr, Prowlarr, Bazarr, etc.).
4.  **LXC-Downloads:** Deluge (Torrent client).
5.  **LXC-Home:** Home Assistant.

## 🚀 Quick Start

### 1. Prerequisites
- Proxmox VE installed and accessible.
- API Token created for Terraform.
- `ansible-vault` password ready for secrets.

**If you are setting up from a fresh machine (Ubuntu/Proxmox/Debian):**
```bash
chmod +x scripts/*.sh
./scripts/setup_dev_env.sh
```

### 2. Setup Configuration
```bash
cp .env.example .env
# Fill in your Proxmox API details and secrets
```

### 3. Deploy
```bash
chmod +x scripts/bootstrap.sh
./scripts/bootstrap.sh
```

## 📂 Repository Structure
- `/terraform`: Infrastructure definitions (LXC/VM).
- `/ansible`: Service configuration and "Software as Code".
- `/scripts`: Automation wrappers for setup and recovery.
- `/docs`: Detailed app-specific documentation and network maps.

## ☁️ Backup & Restore
Backups are automated to Google Drive using `rclone`.
- **Backup:** `ansible-playbook ansible/playbooks/backup_config.yml`
- **Restore:** `./scripts/emergency_restore.sh`

---
*Created and maintained for the j1103.in domain.*
