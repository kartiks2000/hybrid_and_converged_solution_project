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


data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# EC2

module "ec2_1" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_1"
}

module "ec2_2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_2"
}

module "ec2_3" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_2"
  availability_zone = "us-east-1a"
}

output "sgs" {
  value = module.ec2_3.security_group_ids
}

