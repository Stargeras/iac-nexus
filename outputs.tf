output "tenant_sa_passwords" {
  value     = module.nexus-config.tenant_sa_passwords
  sensitive = true
}