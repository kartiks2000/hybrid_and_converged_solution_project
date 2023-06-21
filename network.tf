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
  public_ip_on_launch = true
}


# Route table - subnet association

module "subnet_route_route_table_association_1" {
  source = "./modules/route_table_association"

  subnet_id = module.public_subnet_1.id
  route_table_id = module.public_route_table.id
}



data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}


# Security group

module "webserver_sg" {
  source = "./modules/security_group"

  name = "webserver_sg"
  description = "sg for web servers."
  vpc_id = module.vpc-1.id
  ingress_rules = [
    {
      description      = "Https allow"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    },
    {
      description      = "Http allow"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  ]
}

module "ssh_sg" {
  source = "./modules/security_group"

  name = "ssh_sg"
  description = "sg for SSH."
  vpc_id = module.vpc-1.id
  ingress_rules = [
    {
      description      = "SSH allow"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
    }
  ]
}

# EC2

module "ec2_1" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_1"
  subnet_id = module.public_subnet_1.id
  security_group_ids = [module.ssh_sg.id]
}

module "ec2_2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_2"
  subnet_id = module.public_subnet_1.id
  security_group_ids = [module.ssh_sg.id]
}

module "ec2_3" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_2"
  # availability_zone = "us-east-1a"
  subnet_id = module.public_subnet_1.id
  security_group_ids = [module.webserver_sg.id, module.ssh_sg.id]
}

output "sgs" {
  value = module.ec2_3.security_group_ids
}




