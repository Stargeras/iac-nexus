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

resource "nexus_security_realms" "example" {
  active = [
    "NexusAuthenticatingRealm",
    "NexusAuthorizingRealm",
    "DockerToken",
  ]
}

data "nexus_security_realms" "default" {
    #Use terraform show to view data source  
}

resource "nexus_repository_docker_hosted" "repositories" {
    for_each = var.tenants
    name = each.value["docker_repo_name"]
    online = true
    docker {
        http_port = each.value["docker_repo_port"]
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
    for_each = var.tenants
    metadata {
      name = "${each.value["docker_repo_name"]}-docker-repo"
      namespace = "nexus"
    }
    spec {
      selector = {
          "app.kubernetes.io/instance" = "nexus"
          "app.kubernetes.io/name" = "nexus-repository-manager"
      }
      port {
          port        = each.value["docker_repo_port"]
          target_port = each.value["docker_repo_port"]
      }
      type = "ClusterIP"
    }
}

resource "kubernetes_ingress_v1" "repositories" {
  for_each = var.tenants
  metadata {
    name = "${each.value["docker_repo_name"]}-docker-repo"
    namespace = "nexus"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = each.value["docker_repo_fqdn"]
      http {
        path {
          backend {
            service {
              name = "${each.value["docker_repo_name"]}-docker-repo"
              port {
                number = each.value["docker_repo_port"]
              }
            }
          }
          path = "/"
        }
      }
    }
    tls {
      hosts = [
        each.value["docker_repo_fqdn"]
      ]
    }
  }
}

resource "random_password" "sa_password" {
  for_each = var.tenants
  length = 16
}

resource "nexus_security_role" "tenants" {
  for_each = var.tenants
  name        = "${each.value["tenant_sa_name"]}"
  privileges = [
    "nx-repository-admin-docker-${each.value["docker_repo_name"]}-*",
    "nx-repository-view-docker-${each.value["docker_repo_name"]}-*",
  ]
  roleid = each.value["tenant_sa_name"]
}

resource "nexus_security_user" "tenants" {
  userid    = "${each.value["tenant_sa_name"]}"
  firstname = "${each.value["tenant_sa_name"]}"
  lastname  = "${each.value["tenant_sa_name"]}"
  email     = "${each.value["tenant_sa_name"]}@example.com"
  password  = random_password.sa_password[each.value].result
  roles     = ["${each.value["tenant_sa_name"]}"]
  status    = "active"
}