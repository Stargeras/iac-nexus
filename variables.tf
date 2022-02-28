variable "kubeconfig" {
    type = string
    default = "~/.kube/config"
}
variable "service_type" {
    type = string
    default = "ClusterIP"
}
variable "ingress_hostname" {
    type = string
    default = "nexus.local.domain"
}
variable "storage_class" {
    type = string
    default = "local-path"
}
variable "storage_size" {
    type = string
    default = "8Gi" #Default is 8Gi
}
#variable "docker_repositories" {
#    type = map
#    default = {
#        "tenant1":"8090",
#        "tenant2":"8091",
#        "tenant3":"8092"
#    }
#}
variable "tenants" {
  type = map(object({
      docker_repo_name = string
      docker_repo_fqdn = string
      docker_repo_port = number
      tenant_sa_name   = string
  }))
  default = {
      tenant1 = {
          docker_repo_name = "tenant1-docker"
          docker_repo_fqdn = "tenant1-docker.local.domain"
          docker_repo_port = 8090
          tenant_sa_name = "tenant1-sa"
      }
      tenant2 = {
          docker_repo_name = "tenant2-docker"
          docker_repo_fqdn = "tenant2-docker.local.domain"
          docker_repo_port = 8091
          tenant_sa_name = "tenant2-sa"
      }
      tenant3 = {
          docker_repo_name = "tenant3-docker"
          docker_repo_fqdn = "tenant3-docker.local.domain"
          docker_repo_port = 8092
          tenant_sa_name = "tenant3-sa"
      }
  }
}
variable "nexus_password" {
    # Used to create the databases. After Helm install, the password will be admin123
    type = string
    default = "admin123"
}

variable "nexus_anonymous_enable" {
    type = bool
    default = false
}

variable "nexus_anonymous_user" {
    type = string
    default = "anonymous"
}

# Not yet implemented, default nginx certificate is used
#variable "ingress_secret" {
#    type = string
#    default = "ingress-tls"
#}