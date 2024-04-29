### version.tf variables

variable "proxmox_api_url" {
  description = "This is the target Proxmox API endpoint."
  type        = string
}

variable "proxmox_api_token_id" {
  description = "This is an API token you have previously created for a specific user."
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "This uuid is only available when the token was initially created."
  type        = string
}

variable "proxmox_user" {
  description = "The user, remember to include the authentication realm such as myuser@pam or myuser@pve."
  type        = string
}

variable "proxmox_password" {
  description = "The password."
  type        = string
}

variable "proxmox_tls_insecure" {
  description = "Disable TLS verification while connecting to the proxmox server."
  type        = bool
  default     = true
}

### main.tf variables

variable "proxmox_node" {
  description = "String containing the cluster node name."
  type        = string
}

variable "lxc_hostname" {
  description = "Specifies the host name of the container."
  type        = string
}

variable "lxc_ostemplate" {
  description = "The volume identifier that points to the OS template or backup file."
  type        = string
  default     = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
}

variable "lxc_root_password" {
  description = "Sets the root password inside the container."
  type        = string
  default     = null
  sensitive   = true

  validation {
    condition     = var.lxc_root_password != ""
    error_message = "The password must not be empty."
  }

  validation {
    condition     = var.lxc_root_password != null ? length(var.lxc_root_password) >= 5 : true
    error_message = "The password must be at least 5 characters."
  }
}

variable "lxc_unprivileged" {
  description = "A boolean that makes the container run as an unprivileged user."
  type        = bool
  default     = false
}

variable "lxc_description" {
  description = "Sets the container description seen in the web interface."
  type        = string
  default     = "Created with Terraform."
}

variable "lxc_ostype" {
  description = "The operating system type, used by LXC to set up and configure the container. Automatically determined if not set."
  type        = string
  default     = "debian"
}

variable "lxc_public_ssh_keys" {
  type        = list(string)
  description = "Multi-line string of SSH public keys that will be added to the container."
  default     = []
}

variable "proxmox_resource_pool" {
  description = "The name of the Proxmox resource pool to add this container to."
  type        = string
  default     = null
}

variable "lxc_arch" {
  description = "Sets the container OS architecture type."
  type        = string
  default     = "amd64"
}

variable "lxc_vmid" {
  description = "A number that sets the VMID of the container. If set to 0, the next available VMID is used."
  type        = number
  default     = 0
}

variable "lxc_start_on_boot" {
  description = "A boolean that determines if the container will start on boot."
  type        = bool
  default     = true
}

variable "lxc_start_on_create" {
  description = "A boolean that determines if the container is started after creation."
  type        = bool
  default     = false
}

variable "lxc_protection" {
  description = "A boolean that enables the protection flag on this container. Stops the container and its disk from being removed/updated."
  type        = bool
  default     = false
}

variable "lxc_enable_fuse" {
  description = "A boolean for enabling FUSE mounts."
  type        = bool
  default     = false
}

variable "lxc_enable_keyctl" {
  description = "A boolean for enabling the keyctl() system call."
  type        = bool
  default     = false
}

variable "lxc_allowed_mount_types" {
  type        = list(string)
  description = "Defines the filesystem types that are allowed to be mounted. Options include 'nfs' and 'smb'."
  default     = []
}

variable "lxc_enable_nesting" {
  description = "A boolean to allow nested virtualization."
  type        = bool
  default     = false
}

variable "lxc_cores" {
  description = "The number of cores assigned to the container. A container can use all available cores by default."
  type        = number
  default     = 2
}

variable "lxc_memory" {
  description = "A number containing the amount of RAM to assign to the container (in MB)."
  type        = number
  default     = 4096
}

variable "lxc_swap_memory" {
  description = "A number that sets the amount of swap memory available to the container."
  type        = number
  default     = 1024
}

variable "lxc_rootfs_storage_volume" {
  type        = string
  description = "A string containing the volume , directory, or device to be mounted into the container. E.g. local-lvm, local-zfs, local etc."
  default     = "local-lvm"
}

variable "lxc_rootfs_size_gb" {
  type        = number
  description = "Size of the underlying volume. Must end in T, G, M, or K. Note that this is a read only value."
  default     = 40
}

variable "lxc_dns_name_server" {
  type        = string
  description = "The DNS server IP address used by the container."
  default     = "1.1.1.1"
}

variable "lxc_dns_search_domain" {
  type        = string
  description = "Sets the DNS search domains for the container"
}

variable "lxc_firewall" {
  description = "A boolean to enable the firewall on the network interface."
  type        = bool
  default     = false
}