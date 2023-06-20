# Creating VPC(s)

module "vpc-1" {
  source = "./modules/vpc"

  name = join("-", ["my-vpc", "1"])
}

# Internet Gateway

module "internet_gateway" {
  source = "./modules/internet_gateway"

  vpc_id = module.vpc-1.id
  igw_name = "my-igw"
}


# Route Table

module "public_route_table" {
  source = "./modules/route_table"

  vpc_id = module.vpc-1.id
  name = "public-RT"
}

# Declaring route and associating w/ route table

module "route_to_igw" {
  source = "./modules/route_internet_gateway"

  route_table_id = module.public_route_table.id
  destination_cidr = "0.0.0.0/0"
  internet_gateway_id = module.internet_gateway.id
}


# Creating subnet

module "public_subnet_1" {
  source = "./modules/subnet"

  vpc_id = module.vpc-1.id
  cidr_block = "10.0.0.0/18"
  name = "public_subnet_1" 
}



