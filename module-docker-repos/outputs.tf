output "tenant_sa_passwords" {
    value = random_password.sa_password[*]
}