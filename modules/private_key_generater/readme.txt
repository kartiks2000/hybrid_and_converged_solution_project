parameters:
- algorithm (mandatory), default: ECDSA


To download the public key to SSH, copy the below code on any of the root ,tf file

resource "null_resource" "download_key" {

  provisioner "local-exec" {
    command = "echo '${module.gen_pvt_key.public_key}' > ./My-SSH-key.pem"
  }
}