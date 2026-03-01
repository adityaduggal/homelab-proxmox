resource "proxmox_lxc" "container" {
  target_node  = var.target_node
  hostname     = var.hostname
  vmid         = var.vmid
  ostemplate   = var.ostemplate
  password     = var.password
  unprivileged = var.unprivileged
  onboot       = var.onboot
  cores        = var.cores
  memory       = var.memory
  ssh_public_keys = var.ssh_public_keys

  rootfs {
    storage = var.storage
    size    = var.size
  }

  network {
    name   = "eth0"
    bridge = var.bridge
    ip     = var.ip
    gw     = var.gw
  }

  features {
    nesting = var.nesting
  }

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}
