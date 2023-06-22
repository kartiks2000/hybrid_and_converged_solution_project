output "id" {
  value = aws_vpc.main-1.id
}

output "arn" {
  value = aws_vpc.main-1.arn
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnets[*].id
  description = "The IDs of all public subnets."
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnets[*].id
  description = "The IDs of all private subnets."
}


