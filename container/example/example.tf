module "container" {
  source = "../"

  docker_initial_name = "test"
  image_name          = "pihole/pihole:latest"
  port_mapping = [{
    container_port = "80"
    host_port      = "8080"
    protocol       = "tcp"
    },
    {
      container_port = "53"
      host_port      = "53"
      protocol       = "udp"
  }]
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">=3.0.2"
    }
  }
}
