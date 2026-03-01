variable "target_node" {
  type        = string
  default     = "pve"
  description = "The Proxmox node to deploy the LXC on."
}

variable "vmid" {
  type        = number
  description = "The VMID of the LXC."
}

variable "hostname" {
  type        = string
  description = "The hostname of the LXC."
  default     = "lxc-container"
}

variable "ostemplate" {
  type        = string
  description = "The OS template to use for the LXC."
  default     = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}

variable "unprivileged" {
  type        = bool
  default     = true
  description = "Whether the LXC should be unprivileged."
}

variable "cores" {
  type        = number
  default     = 1
  description = "The number of CPU cores for the LXC."
}

variable "memory" {
  type        = number
  default     = 512
  description = "The amount of memory (MB) for the LXC."
}

variable "storage" {
  type        = string
  default     = "local-lvm"
  description = "The storage ID for the LXC root disk."
}

variable "size" {
  type        = string
  default     = "8G"
  description = "The size of the LXC root disk."
}

variable "bridge" {
  type        = string
  default     = "vmbr0"
  description = "The network bridge for the LXC."
}

variable "ip" {
  type        = string
  description = "The IP address and subnet for the LXC (e.g., 10.3.0.101/24)."
}

variable "gw" {
  type        = string
  default     = "10.3.0.1"
  description = "The gateway IP for the LXC."
}

variable "onboot" {
  type        = bool
  default     = true
  description = "Whether the LXC should start on boot."
}

variable "password" {
  type        = string
  description = "The root password for the LXC."
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "nesting" {
  type        = bool
  default     = true
  description = "Enable nesting for the LXC."
}

variable "ssh_public_keys" {
  type        = string
  default     = ""
  description = "The SSH public keys to add to the LXC."
}
