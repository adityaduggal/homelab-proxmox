#!/bin/bash
# ==============================================================================
# 🚑 Homelab Emergency Restore Script
# ==============================================================================
# Usage: ./emergency_restore.sh [-h]
#
# DESCRIPTION:
#   Restores the homelab configuration from the latest Google Drive backup.
#   Ideal for recovering from a total host failure or corrupted LXC.
#
# PROCESS:
#   1. Pulls the latest homelab_backup.zip via Rclone/Ansible.
#   2. Validates backup integrity.
#   3. Restores config files to their respective LXC paths.
#   4. Restarts all impacted services.
# ==============================================================================

set -e

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help      Show this help message"
    echo ""
}

main() {
    if [[ ! -f ".env" ]]; then
        echo "❌ Error: .env required for Rclone credentials."
        exit 1
    fi
    source .env

    echo "--- ☁️  1. Initiating Recovery from Google Drive ---"
    cd ansible
    ansible-playbook playbooks/restore_stack.yml

    echo "--- ✅ Recovery Complete! ---"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

main "$@"
