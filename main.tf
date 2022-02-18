module "nexus" {
    source = "./module-nexus"
    kubeconfig = "${var.kubeconfig}"
    service_type = "${var.service_type}"
    ingress_hostname = "${var.ingress_hostname}"
    ingress_secret = "${var.ingress_secret}"
    storage_class = "${var.storage_class}"
    storage_size = "${var.storage_size}"
}

module "docker-repos" {
    source = "./module-docker-repos"
    kubeconfig = "${var.kubeconfig}"
    ingress_hostname = "${var.ingress_hostname}"
    ingress_domain = "${var.ingress_domain}"
    docker_repositories = "${var.docker_repositories}"
    nexus_password = "{var.nexus_password}"
}