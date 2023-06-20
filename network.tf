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

# Creating subnet

module "public_subnet_1" {
  source = "./modules/subnet"

  vpc_id = module.vpc-1.id
  cidr_block = "10.0.0.0/18"
  name = "public_subnet_1" 
}



