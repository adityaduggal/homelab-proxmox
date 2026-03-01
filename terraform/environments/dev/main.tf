terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.proxmox_host}:8006/api2/json"
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  pm_tls_insecure = true
}

# 🌐 Test LXC
module "test_lxc" {
  source      = "../../modules/proxmox_lxc"
  vmid        = 901
  hostname    = "test-lxc"
  target_node = var.target_node
  cores       = 1
  memory      = 512
  storage     = var.storage_id
  ip          = "10.3.0.201/24"
  gw          = var.network_gateway
}

# 🖥️ Test VM
module "test_vm" {
  source      = "../../modules/proxmox_vm"
  vmid        = 902
  name        = "test-vm"
  target_node = var.target_node
  cores       = 1
  memory      = 1024
  storage     = var.storage_id
  ipconfig0   = "ip=10.3.0.202/24,gw=10.3.0.1"
}
