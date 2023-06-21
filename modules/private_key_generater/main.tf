resource "tls_private_key" "pvt_key" {
  algorithm = var.algorithm
  provisioner "local-exec" {
    command = "echo '${tls_private_key.pvt_key.private_key_pem}' > ../././deployer-key.pem"
  }
}