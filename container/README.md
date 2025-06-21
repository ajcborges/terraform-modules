# Container
Enables the deployment of a container.
## Introduction
This ```container``` module is a terraform module that setup a container up.
## Module Features
This Module allows you to create a container with the relevant information passed using variables.
## Compatibility
This module is meant for use with Terraform 1.3.3.
This module has been tested with the following terraform version and provider versions:
| Software Component | Version |
|-|-|
| Terraform Version | `1.3.3` |
| Provider: `kreuzwerker/docker` | `3.6.2` |

## Usage

```hcl
module "container" {
  source = "git::https://github.com/ajcborges/terraform-modules.git//container?ref=container/2.0.0"

  docker_initial_name = var.docker_name
  image_name          = var.docker_image
  port_mapping = [{
    container_port = var.container_port
    host_port      = var.host_port
    protocol       = var.protocol
    }]
}
```

Remember to replace "your_docker_image:tag" with the actual image name and tag you want to use, and adjust other variables as per your requirements.

This way, you can use your Terraform module multiple times with different configurations by passing in the appropriate values for the input variables. 

## Changelog

Below is a manual attempt at listing the recent changes.  Should probably move to standard file: CHANGELOG.md.

| Date | Release | Description |
|------|---------|-------------|
| March 2024 | `container/1.0.0` | initial release of the code  |
| June 2025 | `container/2.0.0` | update terraform providers  |

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| docker_initial_name | Name given to the container. | `any` | n/a | yes |
| docker_image | Docker image used to build the container | `any` | n/a | yes |
| container_port | Internal port used by the container  | `any` | n/a | yes |
| host_port | External Port used by the container | `any` | n/a | yes |
| protocol | protocol used by the container | `any` | n/a | yes |

## Outputs

None.
