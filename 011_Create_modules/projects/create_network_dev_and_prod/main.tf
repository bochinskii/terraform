#
# VPC
#
module "vpc_dev" {
  source = "../../modules/aws_vpc"

  env = "dev"
  vpc_cidr_block = "10.128.0.0/16"
  public_subnet_cidr_blocks = [
    "10.128.0.0/24",
    "10.128.1.0/24",
    "10.128.2.0/24"
  ]
  private_subnet_cidr_blocks = []
  db_subnet_cidr_blocks = []
}

module "vpc_prod" {
  source = "../../modules/aws_vpc"

  env = "prod"
  vpc_cidr_block = "10.254.0.0/16"
  public_subnet_cidr_blocks = [
    "10.254.0.0/24",
    "10.254.1.0/24",
    "10.254.2.0/24"
  ]
  private_subnet_cidr_blocks = []
  db_subnet_cidr_blocks = [
    "10.254.64.0/24",
    "10.254.65.0/24",
    "10.254.66.0/24"
  ]
}


#
# SG
#
module "sg_web_dev" {
  source = "../../modules/aws_security_group"

  env = "dev"
  sg_name = "web"
  sg_desc = "Allow WEB"
  vpc_default = false
  vpc_id = module.vpc_dev.vpc_id
  from_sg = false
  to_sg = false
  ingress = {
    description = "WEB Ports from all"
    protocol = "tcp"
  }
  ingress_ports = [80, 443]
}

module "sg_ssh_dev" {
  source = "../../modules/aws_security_group"

  env = "dev"
  sg_name = "ssh"
  sg_desc = "Allow SSH"
  vpc_default = false
  vpc_id = module.vpc_dev.vpc_id
  from_sg = false
  to_sg = false
  ingress = {
    description = "SSH Port from all"
    protocol = "tcp"
  }
  ingress_ports = [22]

}

module "sg_web_alb_prod" {
  source = "../../modules/aws_security_group"

  env = "prod"
  sg_name = "web-alb"
  sg_desc = "Allow WEB to ALB"
  vpc_default = false
  vpc_id = module.vpc_prod.vpc_id
  from_sg = false
  to_sg = false
  ingress = {
    description = "WEB Ports from all"
    protocol = "tcp"
  }
  ingress_ports = [80, 443]

}

module "sg_ssh_ec2_prod" {
  source = "../../modules/aws_security_group"

  env = "prod"
  sg_name = "ssh"
  sg_desc = "Allow SSH"
  vpc_default = false
  vpc_id = module.vpc_prod.vpc_id
  from_sg = false
  to_sg = false
  ingress = {
    description = "SSH Port from all"
    protocol = "tcp"
  }
  ingress_ports = [22]
}

module "sg_all_ec2_prod" {
  source = "../../modules/aws_security_group"

  env = "prod"
  sg_name = "all"
  sg_desc = "Allow All from ALB"
  vpc_default = false
  vpc_id = module.vpc_prod.vpc_id
  from_sg = true
  to_sg = false
  ingress = {
    description = "All TCP Ports from ALB"
    protocol = "tcp"
  }
  ingress_ports = [0]
  ingress_security_groups_ids = [module.sg_web_alb_prod.sg_id]

}
