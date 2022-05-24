output "vpc_cidr_block" {
  value = module.vpc_prod.vpc_cidr_block
}

output "public_subnet_cidr_blocks" {
  value = module.vpc_prod.public_subnet_cidr_blocks
}

output "db_subnet_cidr_blocks" {
  value = module.vpc_prod.db_subnet_cidr_blocks
}



output "vpc_id" {
  value = module.vpc_prod.vpc_id
}

output "public_subnets_ids" {
  value = module.vpc_prod.public_subnets_ids
}

output "db_subnets_ids" {
  value = module.vpc_prod.db_subnets_ids
}
