terraform {
  required_providers {
    nexus = {
      source = "datadrivers/nexus"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig
  }
}

provider "nexus" {
  insecure = true
  password = var.nexus_password
  url      = "https://${var.ingress_hostname}"
  username = "admin"
}

provider "kubernetes" {
  config_paths = [
    "${var.kubeconfig}"
  ]
}
