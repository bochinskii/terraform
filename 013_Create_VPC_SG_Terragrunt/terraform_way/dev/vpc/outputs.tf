output "vpc_cidr_block" {
  value = module.vpc_dev.vpc_cidr_block
}

output "public_subnet_cidr_blocks" {
  value = module.vpc_dev.public_subnet_cidr_blocks
}




output "vpc_id" {
  value = module.vpc_dev.vpc_id
}

output "public_subnets_ids" {
  value = module.vpc_dev.public_subnets_ids
}
