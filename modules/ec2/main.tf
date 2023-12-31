resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  availability_zone = var.availability_zone != "" ? var.availability_zone : null
  key_name = var.key_name != "" ? var.key_name : null
  vpc_security_group_ids = var.security_group_ids != [] ? var.security_group_ids : []
  subnet_id = var.subnet_id != "" ? var.subnet_id : null

  tags = {
    Name = var.name
  }
}