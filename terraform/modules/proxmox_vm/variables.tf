variable "target_node" {
  type        = string
  default     = "pve"
  description = "The Proxmox node to deploy the VM on."
}

variable "vmid" {
  type        = number
  description = "The VMID of the VM."
}

variable "name" {
  type        = string
  description = "The name of the VM."
  default     = "proxmox-vm"
}

variable "clone" {
  type        = string
  description = "The VM template to clone."
  default     = "ubuntu-cloud-template"
}

variable "cores" {
  type        = number
  default     = 2
  description = "The number of CPU cores for the VM."
}

variable "memory" {
  type        = number
  default     = 2048
  description = "The amount of memory (MB) for the VM."
}

variable "storage" {
  type        = string
  default     = "local-lvm"
  description = "The storage ID for the VM disk."
}

variable "size" {
  type        = string
  default     = "20G"
  description = "The size of the VM root disk."
}

variable "bridge" {
  type        = string
  default     = "vmbr0"
  description = "The network bridge for the VM."
}

variable "ipconfig0" {
  type        = string
  description = "The IP configuration for the VM (e.g., ip=10.3.0.100/24,gw=10.3.0.1)."
  default     = "ip=dhcp"
}

variable "onboot" {
  type        = bool
  default     = true
  description = "Whether the VM should start on boot."
}

variable "ssh_public_keys" {
  type        = string
  default     = ""
  description = "The SSH public keys to add to the VM via cloud-init."
}

variable "ciuser" {
  type        = string
  default     = "ubuntu"
  description = "The cloud-init user."
}

variable "cipassword" {
  type        = string
  description = "The cloud-init password."
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "scsihw" {
  type        = string
  default     = "virtio-scsi-pci"
  description = "The SCSI hardware type."
}

variable "bootdisk" {
  type        = string
  default     = "scsi0"
  description = "The boot disk identifier."
}
