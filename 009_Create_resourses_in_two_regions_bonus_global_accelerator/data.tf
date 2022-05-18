data "aws_region" "current_region_eu" {}

data "aws_region" "current_region_ca" {
  provider = aws.canada
}


data "aws_availability_zones" "available_eu" {
  state = "available"
}

data "aws_availability_zones" "available_ca" {
  provider = aws.canada
  state = "available"
}


data "aws_vpc" "default_eu" {
  default = true
}

data "aws_vpc" "default_ca" {
  provider = aws.canada
  default = true
}


data "aws_subnets" "subnets_eu" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_eu.id]
  }
}

data "aws_subnets" "subnets_ca" {
  provider = aws.canada
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_ca.id]
  }
}


data "aws_ami" "amazon_linux_2_5_latest_eu" {
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

data "aws_ami" "amazon_linux_2_5_latest_ca" {
  provider = aws.canada
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
