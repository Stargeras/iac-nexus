provider "helm" {
  kubernetes {
      config_path = "${var.kubeconfig}"
  }
}

resource "helm_release" "nexus" {
  name       = "nexus"
  namespace  = "nexus"
  create_namespace = "true"
  repository = "https://sonatype.github.io/helm3-charts/"
  chart      = "nexus-repository-manager"

  set {
    name  = "service.type"
    value = "${var.service_type}"
  }

  set {
    name = "ingress.enabled"
    value = "true"
  }

  set {
    name = "ingress.hostRepo"
    value = "${var.ingress_hostname}"
  }

  set {
    name = "persistence.storageClass"
    value = "${var.storage_class}"
  }

  set {
    name = "persistence.storageSize"
    value = "${var.storage_size}"
  }
  
  set {
      name = "nexus.docker.enabled"
      value = "true"
  }

  set {
      name = "nexus.env[0].name"
      value = "NEXUS_SECURITY_RANDOMPASSWORD"
  }

  set {
      name = "nexus.env[0].value"
      value = "false"
  }
}
