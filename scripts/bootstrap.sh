#!/bin/bash
# ==============================================================================
# 🚀 Homelab Bootstrap Script
# ==============================================================================
# Usage: ./bootstrap.sh [-h] [--dry-run]
#
# DESCRIPTION:
#   Orchestrates the full deployment of the Proxmox homelab.
#   1. Validates prerequisites (.env, .vault_pass).
#   2. Provisions infrastructure via Terraform.
#   3. Configures services via Ansible.
#
# PREREQUISITES:
#   - Proxmox API Token
#   - .env file (see .env.example)
#   - .vault_pass file
# ==============================================================================

set -e

# --- Help Function ---
show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo "  --dry-run       Run terraform plan and ansible check mode"
    echo ""
}

# --- Pre-flight Checks ---
check_files() {
    if [[ ! -f ".env" ]]; then
        echo "❌ Error: .env file not found. Copy .env.example and configure it."
        exit 1
    fi
    if [[ ! -f ".vault_pass" ]]; then
        echo "⚠️  Warning: .vault_pass not found. Ansible Vault tasks may fail."
    fi
}

# --- Execution ---
main() {
    check_files
    source .env

    echo "--- 🏗️  1. Provisioning Infrastructure (Terraform) ---"
    cd terraform/environments/prod
    terraform init
    if [[ "$1" == "--dry-run" ]]; then
        terraform plan
    else
        terraform apply -auto-approve
    fi

    echo "--- 🛠️  2. Configuring Software (Ansible) ---"
    cd ../../../ansible
    if [[ "$1" == "--dry-run" ]]; then
        ansible-playbook playbooks/deploy_stack.yml --check
    else
        ansible-playbook playbooks/deploy_stack.yml
    fi

    echo "--- ✅ Deployment Process Finished! ---"
}

# Parse Args
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

main "$@"
