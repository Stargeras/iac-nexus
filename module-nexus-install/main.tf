resource "helm_release" "nexus" {
  name             = "nexus"
  namespace        = "nexus"
  create_namespace = "true"
  repository       = "https://sonatype.github.io/helm3-charts/"
  chart            = "nexus-repository-manager"

  values = [
    templatefile("${path.module}/values-tmpl.yaml", {
      service_type     = var.service_type
      ingress_hostname = var.ingress_hostname
      storage_class    = var.storage_class
      storage_size     = var.storage_size
    })
  ]
}
