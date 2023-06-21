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
  cidr_block = "10.0.1.0/24"
  name = "public_subnet_1" 
  public_ip_on_launch = true
  availability_zone = "us-east-1a"
}

module "public_subnet_2" {
  source = "./modules/subnet"

  vpc_id = module.vpc-1.id
  cidr_block = "10.0.2.0/24"
  name = "public_subnet_2" 
  public_ip_on_launch = true
  availability_zone = "us-east-1b"
}


# Route table - subnet association

module "subnet_route_route_table_association_1" {
  source = "./modules/route_table_association"

  subnet_id = module.public_subnet_1.id
  route_table_id = module.public_route_table.id
}

module "subnet_route_route_table_association_2" {
  source = "./modules/route_table_association"

  subnet_id = module.public_subnet_2.id
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
  source = "./modules/security_group/common_security_groups/webserver_sg"

  vpc_id = module.vpc-1.id
}

# module "ssh_sg" {
#   source = "./modules/security_group"

#   name = "ssh_sg"
#   description = "sg for SSH."
#   vpc_id = module.vpc-1.id
#   ingress_rules = [
#     {
#       description      = "SSH allow"
#       from_port        = 22
#       to_port          = 22
#       protocol         = "tcp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = []
#     }
#   ]
# }

module "ssh_sg" {
  source = "./modules/security_group/common_security_groups/ssh_sg"

  vpc_id = module.vpc-1.id
}

# module "icmp_sg" {
#   source = "./modules/security_group"

#   name = "icmp_sg"
#   description = "ping for SSH."
#   vpc_id = module.vpc-1.id
#   ingress_rules = [
#     {
#       description      = "Ping allow"
#       from_port = -1
#       to_port = -1
#       protocol = "icmp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = []
#     }
#   ]
#   egress_rules = [{
#     description      = "Ping allow"
#       from_port = -1
#       to_port = -1
#       protocol = "icmp"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = []
#   }]
# }


module "icmp_sg" {
  source = "./modules/security_group/common_security_groups/icmp_ping_sg"

  vpc_id = module.vpc-1.id
}


# Key-pair

module "gen_pvt_key" {
  source = "./modules/private_key_generater"

}

module "key_pair" {
  source = "./modules/key_pair"

  key_name = "my_key_007"
  public_key = module.gen_pvt_key.public_key
}

resource "null_resource" "download_key" {

  provisioner "local-exec" {
    command = "echo '${module.gen_pvt_key.public_key}' > ./My-SSH-key.pem"
  }
}



# EC2

module "ec2_1" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_1"
  subnet_id = module.public_subnet_1.id
  security_group_ids = [module.webserver_sg.id, module.ssh_sg.id, module.icmp_sg.id]
  key_name = module.key_pair.key_name
}

module "ec2_2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_2"
  subnet_id = module.public_subnet_2.id
  security_group_ids = [module.webserver_sg.id, module.ssh_sg.id, module.icmp_sg.id]
  key_name = module.key_pair.key_name
}

module "ec2_3" {
  source = "./modules/ec2"

  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  name = "ec2_3"
  # availability_zone = "us-east-1a"
  subnet_id = module.public_subnet_1.id
  security_group_ids = [module.webserver_sg.id, module.ssh_sg.id, module.icmp_sg.id]
  key_name = module.key_pair.key_name
}


# load balancing

module "load_balancer_1" {
  source = "./modules/load_balancer"

  name = "my-lb"
  security_groups = [module.webserver_sg.id, module.ssh_sg.id]
  subnets = [module.public_subnet_1.id, module.public_subnet_2.id]
  enable_deletion_protection = false
}


module "load_balancing_target_group" {
  source = "./modules/load_balancing_target_group"

  name = "lbgroup1"
  vpc_id = module.vpc-1.id
}

# Attaching EC2 to target group

module "tg1_el1" {
  source = "./modules/load_balancing_target_ec2_register"

  target_group_arn = module.load_balancing_target_group.arn
  target_id = module.ec2_1.id
  port = 80
}

module "tg1_el2" {
  source = "./modules/load_balancing_target_ec2_register"

  target_group_arn = module.load_balancing_target_group.arn
  target_id = module.ec2_2.id
  port = 80
}

module "tg1_el3" {
  source = "./modules/load_balancing_target_ec2_register"

  target_group_arn = module.load_balancing_target_group.arn
  target_id = module.ec2_3.id
  port = 80
}

module "lb_listener" {
  source = "./modules/load_balancer_listner"

  load_balancer_arn = module.load_balancer_1.arn
  target_group_arn = module.load_balancing_target_group.arn
}

