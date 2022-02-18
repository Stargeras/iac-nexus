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
variable "ingress_domain" {
    type = string
    default = "local.domain"
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
variable "docker_repositories" {
  type = map(object({
      name = string
      fqdn = string
      port = number
  }))
  default = {
      repo1 = {
          name = "tenant1"
          fqdn = "tenant1.local.domain"
          port = 8090
      }
      repo2 = {
          name = "tenant2"
          fqdn = "tenant2.local.domain"
          port = 8091
      }
      repo3 = {
          name = "tenant3"
          fqdn = "tenant3.local.domain"
          port = 8092
      }
  }
}
variable "nexus_password" {
    # Used to create the databases. After Helm install, the password will be admin123
    type = string
    default = "admin123"
}

# Not yet implemented, default nginx certificate is used
#variable "ingress_secret" {
#    type = string
#    default = "ingress-tls"
#}