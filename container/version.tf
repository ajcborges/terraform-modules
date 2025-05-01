terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.4.0"
    }
  }
  required_version = ">=1.3.3"
}
