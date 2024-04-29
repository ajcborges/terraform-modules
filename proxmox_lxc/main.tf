resource "proxmox_lxc" "basic" {
  target_node = var.proxmox_node_m          # String containing the cluster node name.
  pool        = var.proxmox_resource_pool_m # The name of the Proxmox resource pool to add this container to.

  ostemplate = var.lxc_ostemplate_m # The volume identifier that points to the OS template or backup file.
  ostype     = var.lxc_ostype_m     # The operating system type, used by LXC to set up and configure the container. 
  arch       = var.lxc_arch_m       # Sets the container OS architecture type.

  description = var.lxc_description_m   # Sets the container description seen in the web interface.
  vmid        = var.lxc_vmid_m          # A number that sets the VMID of the container. If set to 0, the next available VMID is used. Default is 0
  hostname    = var.lxc_hostname_m      # Specifies the host name of the container.
  password    = var.lxc_root_password_m # Sets the root password inside the container.
  # Multi-line string of SSH public keys that will be added to the container.
  ssh_public_keys = <<-EOF
  %{for key in var.lxc_public_ssh_keys_m~}
  ${key}
  %{endfor~}
EOF

  unprivileged = var.lxc_unprivileged_m    # A boolean that makes the container run as an unprivileged user.
  onboot       = var.lxc_start_on_boot_m   # A boolean that determines if the container will start on boot. 
  start        = var.lxc_start_on_create_m # A boolean that determines if the container is started after creation.
  protection   = var.lxc_protection_m      # A boolean that enables the protection flag on this container. 

  features {                                         # An object for allowing the container to access advanced features.
    fuse    = var.lxc_enable_fuse_m                    # A boolean for enabling FUSE mounts.
    keyctl  = var.lxc_enable_keyctl_m                  # A boolean for enabling the keyctl() system call.
    mount   = join(";", var.lxc_allowed_mount_types_m) # Defines the filesystem types (separated by semicolons) that are allowed to be mounted.
    nesting = var.lxc_enable_nesting_m                 # A boolean to allow nested virtualization.
  }

  cores  = var.lxc_cores_m       # The number of cores assigned to the container. A container can use all available cores by default.
  memory = var.lxc_memory_m      # A number containing the amount of RAM to assign to the container (in MB).
  swap   = var.lxc_swap_memory_m #A number that sets the amount of swap memory available to the container.

  # Terraform will crash without rootfs defined
  rootfs {                                          # An object for configuring the root mount point of the container. Can only be specified once.
    storage = var.lxc_rootfs_storage_volume_m         # A string containing the volume , directory, or device to be mounted into the container (at the path specified by mp)
    size    = format("%sG", var.lxc_rootfs_size_gb_m) # Size of the underlying volume. Must end in T, G, M, or K. Note that this is a read only value.
  }

  # mountpoint { # An object for defining a volume to use as a container mount point. Can be specified multiple times.
  #   key     = "1"  # The number that identifies the mount point (
  #   slot    = 1 # A string containing the number that identifies the mount point
  #   storage = "/mnt/containers/" # A string containing the volume , directory, or device to be mounted into the container (at the path specified by mp)
  #   # Without 'volume' defined, Proxmox will try to create a volume with
  #   # the value of 'storage' + : + 'size' (without the trailing G) - e.g. "/mnt/containers/:256".
  #   # This behaviour looks to be caused by a bug in the provider.
  #   volume  = "/mnt/containers/"
  #   mp      = "/mnt/data/" # The path to the mount point as seen from inside the container. The path must not contain symlinks for security reasons.
  #   size    = "256G" # Size of the underlying volume. Must end in T, G, M, or K. Note that this is a read only value.
  # }

  nameserver   = var.lxc_dns_name_server_m   # The DNS server IP address used by the container.
  searchdomain = var.lxc_dns_search_domain_m # Sets the DNS search domains for the container.

  network {                                                   # An object defining a network interface for the container. Can be specified multiple times.
    name     = "eth0"                                         # The name of the network interface as seen from inside the container
    bridge   = "vmbr0"                                        # The bridge to attach the network interface to
    ip       = join("", ["192.168.30.", var.lxc_vmid_m, "/24"]) # The IPv4 address of the network interface. Can be a static IPv4 address (in CIDR notation).
    firewall = var.lxc_firewall_m                               # A boolean to enable the firewall on the network interface.
    gw       = "192.168.10.254"                     # The IPv4 address belonging to the network interface's default gateway.
  }
}
