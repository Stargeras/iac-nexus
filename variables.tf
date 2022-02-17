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
variable "storage_class" {
    type = string
    default = "local-path"
}
variable "storage_size" {
    type = string
    default = "8Gi" #Default is 8Gi
}
variable "ingress_secret" {
    type = string
    default = "false" #false uses the default secret configured in nginx
}