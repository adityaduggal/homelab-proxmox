# ☁️ Backup & Restore Strategy

The system is designed for "One-Click" backup and recovery, prioritizing small configuration files over massive media libraries for fast cloud synchronization.

## 📦 What is Backed Up?
- **Configurations:** All XML, DB, and INI files in `/opt/servarr_configs`.
- **Certificates:** Traefik's `acme.json` and dynamic configuration rules.
- **Home Assistant:** The `.config` directory and database.
- **Terraform State:** The `terraform.tfstate` to manage current infrastructure.

## 📂 Backup Repository
All backups are encrypted using `ansible-vault` and synced to **Google Drive** using **Rclone**.

### 1. Manual Backup Trigger
```bash
ansible-playbook ansible/playbooks/backup_config.yml --ask-vault-pass
```

### 2. Automated Backups
Configured via `crontab` in the `LXC-Servarr` container, running the Ansible playbook daily at 3 AM.

## 🚀 One-Click Restore
In case of a total host failure, follow these steps:
1.  **Re-provision:** Run `./scripts/bootstrap.sh` on the new Proxmox host.
2.  **Restore Settings:** Run `./scripts/emergency_restore.sh`.

The restore script will:
1.  Pull the latest `homelab_backup.zip` from Google Drive.
2.  Unzip to the corresponding LXC directories.
3.  Restart all services in the stack.

## 🛠️ Configuration
Ensure your `rclone` tokens are correctly set in the `.env` file for the backup role to function.
