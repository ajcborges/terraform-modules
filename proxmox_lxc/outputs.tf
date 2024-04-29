output "id" {
  description = "The Proxmox VMID."
  value       = proxmox_lxc.basic.vmid
}

output "name" {
  description = "The lxc host name."
  value       = proxmox_lxc.basic.hostname
}

output "ip" {
  description = "The lxc host ipaddress."
  value       = proxmox_lxc.basic.network
}