Now, in your main Terraform configuration where you want to use this module, you can reference it like this:
```
module "project" {
  source = "git::https://github.com/homelab/terraform-modules.git//container?ref=container/6.0.0"

  docker_initial_name = "docker-${var.suffix}"
  image_name          = "your_docker_image:tag"
  container_port      = 8080
  host_port           = 8080
  // other variables needed by your module
}
```
Remember to replace "your_docker_image:tag" with the actual image name and tag you want to use, and adjust other variables as per your requirements.

This way, you can use your Terraform module multiple times with different configurations by passing in the appropriate values for the input variables. 
