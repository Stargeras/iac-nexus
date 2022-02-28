resource "nexus_security_realms" "example" {
  active = [
    "NexusAuthenticatingRealm",
    "NexusAuthorizingRealm",
    "DockerToken",
  ]
}

#data "nexus_security_realms" "default" {
    #Use terraform show to view data source  
#}

resource "random_password" "sa_password" {
  for_each = var.tenants
  special = false
  length = 32
}

resource "nexus_security_role" "tenants" {
  for_each = var.tenants
  name        = "${each.value["tenant_sa_name"]}"
  privileges = [
    "nx-repository-admin-docker-${each.value["docker_repo_name"]}-*",
    "nx-repository-admin-maven2-${each.key}-private-maven-2-releases-*",
    "nx-repository-admin-maven2-${each.key}-private-maven-2-snapshots-*",
    "nx-repository-view-docker-${each.value["docker_repo_name"]}-*",
    "nx-repository-view-maven2-${each.key}-private-maven-2-releases-*",
    "nx-repository-view-maven2-${each.key}-private-maven-2-snapshots-*",
  ]
  roleid = each.value["tenant_sa_name"]
  depends_on = [
    nexus_repository_docker_hosted.repositories,
    nexus_repository.maven_releases,
    nexus_repository.maven_snapshots,
  ]
}

resource "nexus_security_user" "tenants" {
  for_each = var.tenants
  userid    = "${each.value["tenant_sa_name"]}"
  firstname = "${each.value["tenant_sa_name"]}"
  lastname  = "${each.value["tenant_sa_name"]}"
  email     = "${each.value["tenant_sa_name"]}@example.com"
  password  = "${random_password.sa_password[each.key].result}"
  roles     = ["${each.value["tenant_sa_name"]}"]
  status    = "active"
  depends_on = [nexus_security_role.tenants]
}