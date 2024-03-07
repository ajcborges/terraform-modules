resource "docker_container" "my_container" {
  name  = var.docker_initial_name
  image = var.image_name

  ports {
    internal = var.container_port
    external = var.host_port
  }

  // Other configurations like environment variables, volumes, etc.
}
