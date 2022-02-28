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
