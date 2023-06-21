output "public_key" {
  value = tls_private_key.pvt_key.public_key_openssh
}