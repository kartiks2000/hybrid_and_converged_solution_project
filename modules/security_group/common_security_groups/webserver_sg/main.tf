module "webserver_sg" {
  source = "../.."

  name = var.name
  description = var.description
  vpc_id = var.vpc_id
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