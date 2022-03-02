resource "kubernetes_service" "repositories" {
  for_each = var.tenants
  metadata {
    name      = "${each.value["docker_repo_name"]}-docker-repo"
    namespace = "nexus"
  }
  spec {
    selector = {
      "app.kubernetes.io/instance" = "nexus"
      "app.kubernetes.io/name"     = "nexus-repository-manager"
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
    name      = "${each.value["docker_repo_name"]}-docker-repo"
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
