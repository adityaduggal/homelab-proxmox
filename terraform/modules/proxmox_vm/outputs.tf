output "vm_id" {
  value       = proxmox_vm_qemu.vm.vmid
  description = "The VMID of the Proxmox VM."
}

output "vm_name" {
  value       = proxmox_vm_qemu.vm.name
  description = "The name of the Proxmox VM."
}

output "vm_ip" {
  value       = proxmox_vm_qemu.vm.default_ipv4_address
  description = "The default IPv4 address of the Proxmox VM."
}
