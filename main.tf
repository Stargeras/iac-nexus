module "nexus" {
    source = "./module-nexus"
    kubeconfig = "${var.kubeconfig}"
    service_type = "${var.service_type}"
    ingress_hostname = "${var.ingress_hostname}"
    ingress_secret = "${var.ingress_secret}"
    storage_class = "${var.storage_class}"
    storage_size = "${var.storage_size}"
}