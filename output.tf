# # VPC

# output "vpc-1-id" {
#   value = module.vpc-1.id
# }


# # Route table

# output "public_route_table" {
#   value = module.public_route_table.id
# }


# # Subnet

# output "subnet_id" {
#   value = module.public_subnet_1.id
# }


# # Internet gateway

# output "internet_gateway_id" {
#   value = module.internet_gateway.id
# }

# output "internet_gateway_arn" {
#   value = module.internet_gateway.igw_arn
# }

output "public_subnets_ids" {
  value = module.network-1.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network-1.private_subnet_ids
}
