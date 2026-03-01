# 🧪 Internal Testing Procedures

This document outlines the internal testing protocols for the `homelab-proxmox` project, ensuring infrastructure and configuration changes are validated before production deployment.

## 🏗️ Development Environment (Dev)

The Dev environment is a **Nested Proxmox** instance or a dedicated physical node (IP: `10.3.0.11`) used to mirror the production topology.

### 1. Provisioning Dev Infrastructure
To test Terraform module changes:
```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

### 2. Ansible Configuration Testing
Test playbooks against the dev inventory:
```bash
# Verify connectivity
ansible -i ansible/inventories/dev all -m ping

# Run deployment in check mode
ansible-playbook -i ansible/inventories/dev ansible/playbooks/deploy_stack.yml --check

# Full deployment to Dev
ansible-playbook -i ansible/inventories/dev ansible/playbooks/deploy_stack.yml
```

### 3. Service Verification
Since Dev uses production subdomains (e.g., `radarr.j1103.in`), override your local DNS to point to the Dev Traefik IP (`10.3.0.101` in Dev).

**Example `/etc/hosts`:**
```text
10.3.0.201  radarr.j1103.in sonarr.j1103.in jellyfin.j1103.in
```

## 🛠️ Automated Checks (Pre-flight)

Before any commit or deployment, run the pre-flight script to validate your local environment:
```bash
./scripts/preflight_check.sh
```

This script verifies:
- Presence of `.env` and `.vault_pass`.
- Terraform binary and provider versions.
- Ansible connectivity and vault encryption status.

## 🔄 CI/CD Simulation (Dry-Run)

Simulate a full deployment lifecycle without making permanent changes:
```bash
./scripts/bootstrap.sh --dry-run
```
