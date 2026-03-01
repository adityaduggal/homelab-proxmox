# 🛠️ Internal Maintenance & Operations

Documentation for recurring management tasks within the `homelab-proxmox` infrastructure.

## 🔄 Terraform Module Management

### Creating New LXC Modules
When adding a new functional LXC group:
1.  Define the group in `terraform/environments/prod/variables.tf` (CPU/Memory).
2.  Add a new `module` block in `terraform/environments/prod/main.tf` using the `proxmox_lxc` source.
3.  Assign a unique `vmid` (standard: 100-199 for prod, 200-299 for dev).

### Terraform State Management
The project uses local state storage. **Do not delete `terraform.tfstate`** unless a full re-provision is desired.
- **Backup State:** State files are included in the automated backup routine defined in `docs/backup.md`.

## 🛠️ Ansible Maintenance

### Vault Encryption
All secrets in `group_vars` (e.g., Google Drive tokens) must be encrypted:
```bash
ansible-vault encrypt ansible/inventories/prod/group_vars/all.yml
```

### Adding New Playbooks
- Place core playbooks in `ansible/playbooks/`.
- Ensure each playbook follows the `become: yes` standard for Proxmox/Ubuntu hosts.

## 🧯 Emergency Procedures

### Full Host Recovery
If the main Proxmox host is irrecoverable:
1.  Set up a fresh PVE node (IP: `10.3.0.5`).
2.  Configure API Token and SSH keys as per `docs/PREREQUISITES.md`.
3.  Execute the restore chain:
    ```bash
    ./scripts/bootstrap.sh
    ./scripts/emergency_restore.sh
    ```

### Container Corruption
If a specific LXC is corrupted but the host is fine:
1.  Taint the module in Terraform:
    ```bash
    terraform taint module.lxc_servarr.proxmox_lxc.container
    ```
2.  Apply changes to re-provision the LXC:
    ```bash
    terraform apply
    ```
3.  Re-run Ansible for that specific host:
    ```bash
    ansible-playbook -i ansible/inventories/prod ansible/playbooks/deploy_stack.yml --limit servarr
    ```
