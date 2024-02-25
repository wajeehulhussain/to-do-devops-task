output "vpc" {
  value = aws_vpc.vpc
}

output "private_subnet_ids" {
  value = [for private_subnet in aws_subnet.private_subnets : private_subnet.id]
}

output "public_subnet_ids" {
  value = [for public_subnet in aws_subnet.public_subnets : public_subnet.id]
}

output "private_subnet_cidrs" {
  value = [for private_subnet in aws_subnet.private_subnets : private_subnet.cidr_block]
}

output "public_subnet_cidrs" {
  value = [for public_subnet in aws_subnet.public_subnets : public_subnet.cidr_block]
}

output "private_rtb_id" {
  value = aws_route_table.private.id
}