module "nexus-install" {
    source = "./module-nexus-install"
    kubeconfig = "${var.kubeconfig}"
    service_type = "${var.service_type}"
    ingress_hostname = "${var.ingress_hostname}"
    storage_class = "${var.storage_class}"
    storage_size = "${var.storage_size}"
}

module "nexus-config" {
    source = "./module-nexus-config"
    kubeconfig = "${var.kubeconfig}"
    ingress_hostname = "${var.ingress_hostname}"
    tenants = "${var.tenants}"
    nexus_password = "${var.nexus_password}"
    nexus_allow_anonymous = "${var.nexus_allow_anonymous}"
}