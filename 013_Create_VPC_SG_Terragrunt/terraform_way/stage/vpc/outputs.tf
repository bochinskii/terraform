output "vpc_cidr_block" {
  value = module.vpc_stage.vpc_cidr_block
}

output "public_subnet_cidr_blocks" {
  value = module.vpc_stage.public_subnet_cidr_blocks
}




output "vpc_id" {
  value = module.vpc_stage.vpc_id
}

output "public_subnets_ids" {
  value = module.vpc_stage.public_subnets_ids
}
