module "nexus" {
    source = "./module-nexus"
    kubeconfig = "${var.kubeconfig}"
    service_type = "${var.service_type}"
    ingress_hostname = "${var.ingress_hostname}"
    storage_class = "${var.storage_class}"
    storage_size = "${var.storage_size}"
}

module "docker-repos" {
    source = "./module-docker-repos"
    kubeconfig = "${var.kubeconfig}"
    ingress_hostname = "${var.ingress_hostname}"
    tenants = "${var.tenants}"
    nexus_password = "${var.nexus_password}"
}