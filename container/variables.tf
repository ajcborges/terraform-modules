variable "docker_initial_name" {
  description = "Initial name for the Docker container"
}

variable "image_name" {
  description = "Name of the Docker image"
}

variable "container_port" {
  description = "Port to expose in the container"
}

variable "host_port" {
  description = "Port to expose on the host"
}

// Add other input variables as needed
