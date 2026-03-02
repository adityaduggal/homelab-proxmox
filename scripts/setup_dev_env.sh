#!/bin/bash
# ==============================================================================
# 🛠️ Homelab Dev Environment Setup Script
# ==============================================================================
# Usage: ./setup_dev_env.sh
#
# DESCRIPTION:
#   Installs all necessary tools for managing the Homelab Proxmox project:
#   - Terraform
#   - Ansible
#   - Rclone
#   - Git, Curl, Unzip
#
# Supported OS: Debian, Ubuntu, Proxmox VE
# ==============================================================================

set -e

echo "--- 🛠️  Starting Dev Environment Setup ---"

# --- 1. Update and Install Base Tools ---
echo "--- 📦 Updating APT and installing base tools ---"
sudo apt update
sudo apt install -y curl git unzip gnupg software-properties-common

# --- 2. Install Terraform ---
if ! command -v terraform &> /dev/null; then
    echo "--- 🏗️  Installing Terraform ---"
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install -y terraform
else
    echo "✅ Terraform already installed."
fi

# --- 3. Install Ansible ---
if ! command -v ansible &> /dev/null; then
    echo "--- 🛠️  Installing Ansible ---"
    sudo apt update
    sudo apt install -y ansible
else
    echo "✅ Ansible already installed."
fi

# --- 4. Install Rclone ---
if ! command -v rclone &> /dev/null; then
    echo "--- ☁️  Installing Rclone ---"
    sudo -v ; curl https://rclone.org/install.sh | sudo bash
else
    echo "✅ Rclone already installed."
fi

echo "--- ✅ Dev Environment Setup Complete! ---"
echo "You can now run './scripts/preflight_check.sh' to verify your configuration."
