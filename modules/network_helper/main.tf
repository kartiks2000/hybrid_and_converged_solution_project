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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-1.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "Public_RT" {
  vpc_id = aws_vpc.main-1.id

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route" "r" {
  route_table_id            = aws_route_table.Public_RT.id
  destination_cidr_block    = var.internet_gateway_route_destination_cidr
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "main" {
  count = length(aws_subnet.public_subnets.*)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.Public_RT.id
}


resource "aws_route_table" "Private_RT" {
  vpc_id = aws_vpc.main-1.id

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_eip" "eip" {}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = var.nat_gateway_name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "r1" {
  route_table_id            = aws_route_table.Private_RT.id
  destination_cidr_block    = var.nat_route_destination_cidr
  gateway_id = aws_nat_gateway.example.id
}

resource "aws_route_table_association" "main1" {
  count = length(aws_subnet.private_subnets.*)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.Private_RT.id
}

