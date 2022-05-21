output "vpc_cidr_block" {
  value = var.vpc_cidr_block
}

output "public_subnet_cidr_blocks" {
  value = var.public_subnet_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  value = var.private_subnet_cidr_blocks
}

output "db_subnet_cidr_blocks" {
  value = var.db_subnet_cidr_blocks
}




output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private[*].id
}

output "db_subnets_ids" {
  value = aws_subnet.db[*].id
}
