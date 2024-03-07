resource "docker_image" "my_container_image" {
  name = var.image_name
}

resource "docker_container" "my_container" {
  name  = var.docker_initial_name
  image = docker_image.my_container_image.image_id

  dynamic "ports" {
    for_each = var.port_mapping
    content {
      external = ports.value["host_port"]
      internal = ports.value["container_port"]
      protocol = ports.value["protocol"]
      ip       = var.ip_address
    }
  }

  // Other configurations like environment variables, volumes, etc.
}
