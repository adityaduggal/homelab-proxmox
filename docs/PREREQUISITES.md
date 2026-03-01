# 📋 Homelab Prerequisites Guide

Follow these steps meticulously before running the bootstrap script.

## 1. Proxmox VE Installation
1.  Download Proxmox VE ISO from the [official site](https://www.proxmox.com/en/downloads).
2.  Flash to a USB using Etcher/Rufus.
3.  Install on your host.
    - **Hostname:** `pve.j1103.in`
    - **IP:** `10.3.0.5` (or as defined in your map)
    - **Gateway:** `10.3.0.1` (Opnsense)

## 2. Generate Proxmox API Token (for Terraform)
Terraform needs an API token to manage the hypervisor.
1.  Log into PVE Web UI (`https://10.3.0.5:8006`).
2.  Go to **Datacenter > Permissions > Users**.
3.  Add User: `terraform-user@pve`.
4.  Go to **Datacenter > Permissions > API Tokens**.
5.  Add Token: Select `terraform-user@pve`, Token ID: `prov-token`, uncheck "Privilege Separation".
6.  **SAVE THE SECRET.** You will only see it once.
7.  Add Permissions: **Datacenter > Permissions**.
8.  Add `API Token` permission for `/` with role `Administrator`.

## 3. Ansible Vault Setup
We encrypt sensitive data (like Google Drive tokens) using Ansible Vault.
1.  Create a password file (it is git-ignored):
    ```bash
    echo "your_super_secret_password" > .vault_pass
    ```
2.  Update `ansible.cfg` to point to this file (optional, but convenient).

## 4. Opnsense Configuration
Ensure your Opnsense firewall (separate hardware) has:
1.  **HACS Plugin:** Enable the Opnsense API for Home Assistant control.
2.  **DHCP Reservations:** While we use static IPs for LXCs, Opnsense should be aware of the `10.3.0.0/16` range.
3.  **Static Routes:** Ensure `10.3.1.x` routable if using VLANs.

## 5. Rclone for Google Drive
1.  Install Rclone on your local machine.
2.  Run `rclone config`.
3.  Name it `gdrive`, select Google Drive, and follow the OAuth flow.
4.  Once finished, run `rclone config show gdrive`.
5.  Get your `client_id`, `client_secret`, and `token`.
6.  Paste these into your `.env` file.
