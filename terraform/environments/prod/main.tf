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

# 🌐 Network LXC (Traefik)
module "lxc_network" {
  source      = "../../modules/proxmox_lxc"
  vmid        = 101
  hostname    = "traefik-proxy"
  target_node = var.target_node
  cores       = var.lxc_cpu_cores["network"]
  memory      = var.lxc_memory_mb["network"]
  storage     = var.storage_id
  ip          = "10.3.0.101/24"
  gw          = var.network_gateway
}

# 🎬 Media LXC (Jellyfin)
module "lxc_media" {
  source      = "../../modules/proxmox_lxc"
  vmid        = 102
  hostname    = "jellyfin-media"
  target_node = var.target_node
  cores       = var.lxc_cpu_cores["media"]
  memory      = var.lxc_memory_mb["media"]
  storage     = var.storage_id
  ip          = "10.3.0.102/24"
  gw          = var.network_gateway
  # GPU Passthrough should be handled here via manual configuration or provider features
}

# 📺 Servarr LXC (Radarr, Sonarr, etc.)
module "lxc_servarr" {
  source      = "../../modules/proxmox_lxc"
  vmid        = 103
  hostname    = "servarr-stack"
  target_node = var.target_node
  cores       = var.lxc_cpu_cores["servarr"]
  memory      = var.lxc_memory_mb["servarr"]
  storage     = var.storage_id
  ip          = "10.3.0.103/24"
  gw          = var.network_gateway
}

# 📥 Downloads LXC (Deluge)
module "lxc_downloads" {
  source      = "../../modules/proxmox_lxc"
  vmid        = 104
  hostname    = "deluge-downloads"
  target_node = var.target_node
  cores       = var.lxc_cpu_cores["downloads"]
  memory      = var.lxc_memory_mb["downloads"]
  storage     = var.storage_id
  ip          = "10.3.0.104/24"
  gw          = var.network_gateway
}

# 🏠 Home LXC (Home Assistant)
module "lxc_home" {
  source      = "../../modules/proxmox_lxc"
  vmid        = 105
  hostname    = "home-assistant"
  target_node = var.target_node
  cores       = var.lxc_cpu_cores["home"]
  memory      = var.lxc_memory_mb["home"]
  storage     = var.storage_id
  ip          = "10.3.0.105/24"
  gw          = var.network_gateway
}
