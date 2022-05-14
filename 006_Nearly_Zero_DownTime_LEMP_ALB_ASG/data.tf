data "aws_region" "current_region" {}
/*
output "current_region" {
  value = data.aws_region.current_region.name
}
*/

data "aws_ami" "amazon_linux_2_5_latest" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
/*
output "amazon_linux_2_5_latest" {
  value = data.aws_ami.amazon_linux_2_5_latest.image_id
}
*/

data "aws_vpc" "vpc_project" {
  tags = {
    Name = "vpc_Default"
  }
}

data "aws_subnets" "all_subnets" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.vpc_project.id]
  }

}
/*
output "vpc_project" {
  value = data.aws_vpc.vpc_project.id
}

output "all_subnets" {
  value = data.aws_subnets.all_subnets.ids
}
*/

data "aws_availability_zones" "all_az" {
  state = "available"
}
/*
output "all_az" {
  value = data.aws_availability_zones.all_az.names
}
*/
