variable "kubeconfig" {}
variable "service_type" {}
variable "ingress_hostname" {}
variable "storage_class" {}
variable "storage_size" {}
variable "nexus_password" {}
variable "nexus_anonymous_enable" {}
variable "nexus_anonymous_user" {}
variable "tenants" {
  type = map(object({
    docker_repo_name = string
    docker_repo_fqdn = string
    docker_repo_port = number
    tenant_sa_name   = string
  }))
}

/*
variable "docker_repositories" {
  type = map
  default = {
    "tenant1":"8090",
    "tenant2":"8091",
    "tenant3":"8092"
  }
}

# Not yet implemented, default nginx certificate is used
variable "ingress_secret" {
    type = string
    default = "ingress-tls"
}
*/