variable "docker_initial_name" {
  description = "Initial name for the Docker container"
}

variable "image_name" {
  description = "Name of the Docker image"
}

variable "port_mapping" {
  type = list(
    object(
      {
        container_port = string,
        host_port      = string,
        protocol       = string
      }
    )
  )
  description = "A list of maps of ports to be deployed for the container"
  default     = null
}

variable "named_volumes" {
  description = "Mount named volumes"
  type = map(object({
    container_path = string
    read_only      = bool
    create         = bool
  }))
  default = {}
}

variable "host_paths" {
  description = "Mount host paths"
  type = map(object({
    container_path = string
    read_only      = bool
  }))
  default = {}
}

variable "volumes_from_containers" {
  description = "Mount volumes from another container"
  type        = list(any)
  default     = null
}

variable "ip_address" {
  description = "IP address of the container, used in port mapping if its required"
  default     = "0.0.0.0"
}
// Add other input variables as needed
