provider "nexus" {
  insecure = true
  password = "${var.nexus_password}"
  url      = "https://${var.ingress_hostname}"
  username = "admin"
}

#resource "postgresql_role" "new_role" {
#  for_each = toset(var.items)
#  name     = "${each.value}"
#  login    = true
#  password = "${random_string.userpass[each.value].id}"
#}

resource "nexus_repository_docker_hosted" "repositories" {
    for_each = toset(var.docker_repositories)
    name = "${each.key}"
    online = true
    http_port = "${each.value}"
    docker {
      force_basic_auth = false
      v1_enabled       = false
    }
    storage {
      blob_store_name                = "default"
      strict_content_type_validation = true
      write_policy                   = "ALLOW"
    }
}