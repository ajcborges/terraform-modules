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

dynamic "volumes" {
    for_each = var.named_volumes
    content {
      volume_name    = volumes.key
      container_path = volumes.value.container_path
      read_only      = volumes.value.read_only
    }
  }

  dynamic "volumes" {
    for_each = var.host_paths
    content {
      host_path      = volumes.key
      container_path = volumes.value.container_path
      read_only      = volumes.value.read_only
    }
  }

  dynamic "volumes" {
    for_each = var.volumes_from_containers == null ? [] : var.volumes_from_containers
    content {
      from_container = volumes.value
    }
  }

  // Other configurations like environment variables, etc.
}
