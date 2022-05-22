data "aws_region" "current_region_first" {}

data "aws_region" "current_region_second" {
  provider = aws.second
}


data "aws_availability_zones" "available_first" {
  state = "available"
}

data "aws_availability_zones" "available_second" {
  provider = aws.second
  state = "available"
}


data "aws_vpc" "default_first" {
  default = true
}

data "aws_vpc" "default_second" {
  provider = aws.second
  default = true
}


data "aws_subnets" "subnets_first" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_first.id]
  }
}

data "aws_subnets" "subnets_second" {
  provider = aws.second
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_second.id]
  }
}


data "aws_ami" "amazon_linux_2_5_latest_first" {
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

data "aws_ami" "amazon_linux_2_5_latest_second" {
  provider = aws.second
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
