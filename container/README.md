Now, in your main Terraform configuration where you want to use this module, you can reference it like this:
```
module "container" {
  source = "git::https://github.com/homelab/terraform-modules.git//container?ref=container/6.0.0"

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

```
Remember to replace "your_docker_image:tag" with the actual image name and tag you want to use, and adjust other variables as per your requirements.

This way, you can use your Terraform module multiple times with different configurations by passing in the appropriate values for the input variables. 
