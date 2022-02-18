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
    default = "nexus.svc.cluster.local"
}
variable "ingress_domain" {
    type = string
    default = "svc.cluster.local"
}
variable "storage_class" {
    type = string
    default = "local-path"
}
variable "storage_size" {
    type = string
    default = "8Gi" #Default is 8Gi
}
variable "docker_repositories" {
    type = map
    default = {
        "tenant1":"8090",
        "tenant2":"8091",
        "tenant3":"8092"
    }
}
variable "nexus_password" {
    type = string
    default = "admin123" #Used to create the databases. After Helm install, the password will be admin123
}

# Not yet implemented, default nginx certificate is used
#variable "ingress_secret" {
#    type = string
#    default = "ingress-tls"
#}