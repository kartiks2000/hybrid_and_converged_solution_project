resource "aws_vpc" "main-1" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)
  vpc_id     = aws_vpc.main-1.id
  cidr_block = var.public_subnets[count.index].cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnets[count.index].name
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)
  vpc_id     = aws_vpc.main-1.id
  cidr_block = var.private_subnets[count.index].cidr_block
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnets[count.index].name
  }
}
