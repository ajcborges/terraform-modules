module "container" {
  source = "../"

  image          = "portainer/portainer-ce"
  container_name = "portainer"
  hostname       = "portainer-srv"
  restart_policy = "always"
  ports = [{
    external = "9443"
    internal = "9443"
    protocol = "tcp"
  }]

  named_volumes = {
    "portainer_data" = {
      container_path = "/opt/portainer/data"
      read_only      = false
      create         = true
    }
  }

  host_paths = {
    "/mnt/containers/portainer" = {
      container_path = "/opt/portainer/"
      read_only      = false
    }
  }


}
