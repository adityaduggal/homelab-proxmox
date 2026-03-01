#!/bin/bash
# ==============================================================================
# 🔍 Homelab Pre-flight Validation Script
# ==============================================================================
# Usage: ./preflight_check.sh
#
# DESCRIPTION:
#   Validates that all prerequisites are met before running the bootstrap.
#   1. Checks for .env and .vault_pass.
#   2. Verifies Proxmox API connectivity.
#   3. Verifies Rclone tokens are correctly formatted.
#   4. Checks for necessary local tools (terraform, ansible, rclone).
# ==============================================================================

set -e

# --- Helper functions ---
check_tool() {
    if ! command -v "$1" &> /dev/null; then
        echo "❌ Error: '$1' is not installed."
        exit 1
    fi
    echo "✅ Tool '$1' is available."
}

# --- 1. Tool Checks ---
echo "--- 🔍 1. Tooling Check ---"
check_tool "terraform"
check_tool "ansible"
check_tool "rclone"
check_tool "curl"

# --- 2. Environment Checks ---
echo ""
echo "--- 🔍 2. Environment Check ---"
if [[ ! -f ".env" ]]; then
    echo "❌ Error: .env file missing. Run 'cp .env.example .env' and configure it."
    exit 1
fi
source .env
echo "✅ .env file found."

if [[ ! -f ".vault_pass" ]]; then
    echo "⚠️  Warning: .vault_pass missing. Ansible Vault tasks will fail."
else
    echo "✅ .vault_pass file found."
fi

# --- 3. Connectivity Check (Proxmox API) ---
echo ""
echo "--- 🔍 3. Proxmox API Check ---"
API_HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -k "$PM_API_URL")
if [[ "$API_HTTP_CODE" == "200" || "$API_HTTP_CODE" == "401" ]]; then
    echo "✅ Proxmox API is reachable (HTTP $API_HTTP_CODE)."
else
    echo "❌ Error: Proxmox API unreachable (HTTP $API_HTTP_CODE) at $PM_API_URL."
    exit 1
fi

# --- 4. Rclone Check ---
echo ""
echo "--- 🔍 4. Rclone Configuration Check ---"
if [[ -z "$RCLONE_CONFIG_GDRIVE_TOKEN" ]]; then
    echo "❌ Error: RCLONE_CONFIG_GDRIVE_TOKEN is missing from .env."
    exit 1
fi
echo "✅ Rclone token found in .env."

echo ""
echo "--- 🏁 Pre-flight check complete. You are ready to run ./scripts/bootstrap.sh! ---"
