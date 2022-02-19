output "tenant_sa_passwords" {
    value = module.docker-repos.tenant_sa_passwords
    sensitive = true
}