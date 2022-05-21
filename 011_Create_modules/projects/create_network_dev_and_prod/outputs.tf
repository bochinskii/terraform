output "dev_vpc_id" {
  value = module.vpc_dev.vpc_id
}

output "dev_public_subnets_ids" {
  value = module.vpc_dev.public_subnets_ids
}



output "prod_vpc_id" {
  value = module.vpc_prod.vpc_id
}

output "prod_public_subnets_ids" {
  value = module.vpc_prod.public_subnets_ids
}

output "db_public_subnets_ids" {
  value = module.vpc_prod.db_subnets_ids
}



output "dev_web_sg_id" {
  value = module.sg_web_dev.sg_id
}

output "dev_ssh_sg_id" {
  value = module.sg_ssh_dev.sg_id
}



output "prod_web_alb_sg_id" {
  value = module.sg_web_alb_prod.sg_id
}

output "prod_ssh_ec2_sg_id" {
  value = module.sg_ssh_ec2_prod.sg_id
}

output "prod_all_ec2_sg_id" {
  value = module.sg_all_ec2_prod.sg_id
}
