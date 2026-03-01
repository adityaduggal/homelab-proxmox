resource "proxmox_vm_qemu" "vm" {
  name        = var.name
  target_node = var.target_node
  vmid        = var.vmid
  clone       = var.clone
  full_clone  = true
  onboot      = var.onboot
  cores       = var.cores
  memory      = var.memory
  scsihw      = var.scsihw
  bootdisk    = var.bootdisk

  disk {
    size    = var.size
    type    = "scsi"
    storage = var.storage
  }

  network {
    model  = "virtio"
    bridge = var.bridge
  }

  # Cloud-init settings
  ipconfig0 = var.ipconfig0
  ciuser    = var.ciuser
  cipassword = var.cipassword
  sshkeys   = var.ssh_public_keys

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
