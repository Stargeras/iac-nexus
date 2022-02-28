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

resource "nexus_repository" "maven-releases" {
    for_each = var.tenants
    name = "${each.key}-private-maven-2-relases"
    format = "maven2"
    type = "hosted"

    storage {
        blob_store_name                = "default"
        strict_content_type_validation = true
        write_policy                   = "ALLOW"
    }

    maven {
        version_policy = "RELEASE"
    }
}

resource "nexus_repository" "maven-snapshots" {
    for_each = var.tenants
    name = "${each.key}-private-maven-2-snapshots"
    format = "maven2"
    type = "hosted"

    storage {
        blob_store_name                = "default"
        strict_content_type_validation = true
        write_policy                   = "ALLOW"
    }

    maven {
        version_policy = "RELEASE"
    }
}