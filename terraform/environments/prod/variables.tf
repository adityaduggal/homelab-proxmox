# ==============================================================================
# 🏗️ Terraform Variables for Homelab Proxmox
# ==============================================================================

variable "proxmox_host" {
  type        = string
  description = "The IP address or FQDN of your Proxmox host (e.g., 10.3.0.5)."
}

variable "pm_api_token_id" {
  type        = string
  description = "The API Token ID from Proxmox (e.g., terraform-user@pve!prov-token)."
  sensitive   = true
}

variable "pm_api_token_secret" {
  type        = string
  description = "The secret part of the Proxmox API Token."
  sensitive   = true
}

variable "target_node" {
  type        = string
  default     = "pve"
  description = "The name of the Proxmox node where LXCs will be deployed."
}

# --- Resource Specifications ---

variable "lxc_cpu_cores" {
  type        = map(number)
  default     = {
    network   = 1
    media     = 4
    servarr   = 2
    downloads = 1
    home      = 2
  }
  description = "Map of CPU cores allocated per functional LXC."
}

variable "lxc_memory_mb" {
  type        = map(number)
  default     = {
    network   = 512
    media     = 4096
    servarr   = 2048
    downloads = 1024
    home      = 2048
  }
  description = "Map of RAM (in MB) allocated per functional LXC."
}

variable "storage_id" {
  type        = string
  default     = "local-lvm"
  description = "The Proxmox storage ID for the LXC root disks (e.g., local-lvm or NVMe)."
}

variable "gpu_passthrough_enabled" {
  type        = bool
  default     = true
  description = "If true, /dev/dri/renderD128 will be mapped to the Media LXC for Jellyfin transcoding."
}

variable "network_gateway" {
  type        = string
  default     = "10.3.0.1"
  description = "The gateway IP (Opnsense)."
}
