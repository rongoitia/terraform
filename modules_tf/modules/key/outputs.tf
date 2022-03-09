output "private_key" {
  sensitive = true
  value = tls_private_key.keypair.private_key_pem
}

output "public_key" {
  value = tls_private_key.keypair.public_key_pem
}
