# ==============================================================================
# 🏗️ Terraform Variables for Homelab Proxmox (DEV)
# ==============================================================================

variable "proxmox_host" {
  type        = string
  description = "The IP address or FQDN of your Proxmox host (e.g., 10.3.0.11)."
}

variable "pm_api_token_id" {
  type        = string
  description = "The API Token ID from Proxmox."
  sensitive   = true
}

variable "pm_api_token_secret" {
  type        = string
  description = "The secret part of the Proxmox API Token."
  sensitive   = true
}

variable "target_node" {
  type        = string
  default     = "pve-dev"
  description = "The name of the Proxmox node where LXCs will be deployed."
}

variable "storage_id" {
  type        = string
  default     = "local-lvm"
  description = "The Proxmox storage ID for the LXC root disks."
}

variable "network_gateway" {
  type        = string
  default     = "10.3.0.1"
  description = "The gateway IP."
}
