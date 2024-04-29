terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
  required_version = ">= 1.3.3"

  backend "local" {

  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url # Required. This is the target Proxmox API endpoint.
  #pm_api_token_id     = var.proxmox_api_token_id     # Optional. This is an API token you have previously created for a specific user.
  #pm_api_token_secret = var.proxmox_api_token_secret # Optional. This uuid is only available when the token was initially created.

  pm_user     = var.proxmox_user     # Optional. Proxmox User (myuser@pam or myuser@pve)
  pm_password = var.proxmox_password # Optional. Sensitive. Proxmox User password.

  pm_tls_insecure = var.proxmox_tls_insecure # Optional. Disable TLS verification while connecting to the proxmox server.
}
