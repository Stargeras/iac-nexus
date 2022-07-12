kubeconfig             = "~/.kube/config"

service_type           = "ClusterIP"
ingress_hostname       = "nexus.local.domain"
storage_class          = "local-path"
storage_size           = "8Gi" #Default is 8Gi
nexus_password         = "admin123" # Used to create the databases. After Helm install, the password will be admin123
nexus_anonymous_enable = false
nexus_anonymous_user   = "anonymous"

tenants = {
  tenant1 = {
    docker_repo_name = "tenant1-docker"
    docker_repo_fqdn = "tenant1-docker.local.domain"
    docker_repo_port = 8090
    tenant_sa_name   = "tenant1-sa"
  }
  tenant2 = {
    docker_repo_name = "tenant2-docker"
    docker_repo_fqdn = "tenant2-docker.local.domain"
    docker_repo_port = 8091
    tenant_sa_name   = "tenant2-sa"
  }
  tenant3 = {
    docker_repo_name = "tenant3-docker"
    docker_repo_fqdn = "tenant3-docker.local.domain"
    docker_repo_port = 8092
    tenant_sa_name   = "tenant3-sa"
  }
}
