# Proxmox LXC 

An LXC deployment with a `static` ip address that utilizes the VMID as the final octet of the ip address, which is then assigned to the LXC.

- `eth0` is the default name for the network interface.
- `vmbr0` is the default name for the bridge  attach the network interface.
- `192.168.30.0/24` is the default subnet.
- `192.168.30.254` is the default `gateway`.

## Running

Replace `PM_* ENV` vars with appropriate values.

```bash
 
export PM_API_URL=https://proxmox.example.com:8006/api2/json
export PM_USER=terraform@pve 
export PM_PASS=mypassword 
```

```bash
terraform init
terraform plan -var-file=filename.tfvars -out filename.tfplan
terraform apply filename.tfplan
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >=1.3.3|
| telmate/proxmox | >=2.9.14 |


## Inputs

The table below lists the variables (input) used by the deployment, which are managed in a `tfvar` file.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| proxmox_api_url | Proxmox API endpoint. | `string` | n/a | yes |
| proxmox_user | User used to authenticate with Proxmox API endpoint (myuser@pam or myuser@pve). | `string` | n/a | yes|
| proxmox_password | Password used to authenticate with Proxmox API endpoint. | `string` | n/a | yes|
| proxmox_tls_insecure | Disable TLS verification while connecting to the proxmox server. | `bool` | `true` | yes |
| proxmox_node | Cluster node name. | `string` | n/a | yes |
| lxc_hostname | Container Hostname. | `string` | n/a | yes |
| lxc_ostemplate | Volume identifier for the OS template. Update with your preference | `string` | local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst | yes |
| lxc_root_password | root password inside the Container. | `string` | PleaseChangeMe | yes |
| lxc_unprivileged | Makes the Container run as an unprivileged user.| `bool` | `false` | no |
| lxc_description | Container description| `string` | Created with Terraform| no|
| lxc_ostype | The operating system type used by Container.| `string` | debian | no|
| lxc_public_ssh_keys | The public keys of the local administrator.| `list(string)`| `[]`| no|
| proxmox_resource_pool | Proxmox resource pool to add this Container to.| `string` | n/a |yes|
| lxc_arch| Container OS architecture type. | `string` | `amd64` | no |
| lxc_vmid | VMID of the Container. Need to be set between 100 and 250.| `number`| `100` | yes|
| lxc_start_on_boot| Determines if the Container will start on boot.| `bool` | `true` | no|
| lxc_start_on_create |Determines if the Container is started after creation.| `bool`| `true`|no|
|lxc_protection | Enables the protection flag on this Container. Stops the Container and its disk from being removed/updated.| `bool`| `false` | no |
| lxc_enable_fuse | Enables FUSE mounts. | `bool`| `false` | no |
| lxc_enable_keyctl | Enables the keyctl() system call. Required to be `true` if you are planning to deploy docker inside the LXC| `bool`| `false` | no |
|lxc_allowed_mount_types| Defines the filesystem types that are allowed to be mounted.| `list(string)` | `[]` | no |
|lxc_enable_nesting | Allows nested virtualization. Required to be `true` if you are planning to deploy docker inside the LXC | `bool` | `false` | no|
|lxc_cores | Number of cores assigned to the Container. | `number` | `2` | no|
|lxc_memory | Number containing the amount of RAM to assign to the Container (in MB) | `number` | `4096` | yes|
|lxc_swap_memory | Number that sets the amount of swap memory available to the Container. |`number` | `1024` | yes |
| lxc_rootfs_storage_volume | Volume , directory, or device to be mounted into the Container. E.g. local-lvm, local-zfs, local etc. | `string`| `local-lvm` | yes|
|lxc_rootfs_size_gb | Size of the underlying volume. Must end in T, G, M, or K. Note that this is a read only value. | `number` | `40` | yes |
|lxc_dns_name_server | DNS server IP address used by the Container.| `string` | `1.1.1.1`| yes|
| lxc_dns_search_domain | DNS search domains for the Container. | `string` | n/a | no |
|lxc_firewall | Enable the firewall on the network interface. | `bool` | `false` | no|

## Outputs

- The Proxmox VMID.
- The lxc host ipaddress.
- The lxc host name.

```bash
Outputs:

id = 100
ip = "192.168.30.100/24"
name = "nonprod-docker-host"

```
