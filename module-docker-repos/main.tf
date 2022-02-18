provider "nexus" {
  insecure = true
  password = "${var.nexus_password}"
  url      = "https://${var.ingress_hostname}"
  username = "admin"
}

provider "kubernetes" {
  config_paths = [
    "${var.kubeconfig}"
  ]
}

#resource "postgresql_role" "new_role" {
#  for_each = toset(var.items)
#  name     = "${each.value}"
#  login    = true
#  password = "${random_string.userpass[each.value].id}"
#}

resource "nexus_repository_docker_hosted" "repositories" {
    for_each = var.docker_repositories
    name = each.value["name"]
    online = true
    docker {
        http_port = each.value["port"]
        force_basic_auth = false
        v1_enabled       = false
    }
    storage {
        blob_store_name                = "default"
        strict_content_type_validation = true
        write_policy                   = "ALLOW"
    }
}

resource "kubernetes_service" "repositories" {
    for_each = var.docker_repositories
    metadata {
      name = each.value["name"]
      namespace = "nexus"
    }
    spec {
      selector = {
          app.kubernetes.io/instance = "nexus"
          app.kubernetes.io/name = "nexus-repository-manager"
      }
      port {
          port        = each.value["port"]
          target_port = each.value["port"]
      }
      type = "ClusterIP"
    }
}