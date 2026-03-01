output "container_id" {
  value       = proxmox_lxc.container.vmid
  description = "The VMID of the LXC container."
}

output "container_ip" {
  value       = proxmox_lxc.container.network[0].ip
  description = "The IP address of the LXC container."
}

output "container_hostname" {
  value       = proxmox_lxc.container.hostname
  description = "The hostname of the LXC container."
}
