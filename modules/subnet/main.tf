resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block
  map_public_ip_on_launch = var.public_ip_on_launch
  availability_zone = var.availability_zone != "" ? var.availability_zone : null

  tags = {
    Name = var.name
  }
}