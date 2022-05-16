data "aws_region" "current_region" {}

/*
output "current_region" {
  value = data.aws_region.current_region.name
}
*/

data "aws_availability_zones" "available" {
  state = "available"
}

/*
output "availability_zones" {
  value = data.aws_availability_zones.available.names
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

data "aws_ami" "ubuntu_2204_latest" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
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

data "aws_subnets" "all_private_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }
  tags = {
    Name = "subnet-private-${var.env}-*"
  }
  depends_on = [aws_subnet.private]
}

/*
output "all_private_subnets" {
  value = data.aws_subnets.all_private_subnets.ids
}
*/

data "aws_subnets" "all_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }
  tags = {
    Name = "subnet-public-${var.env}-*"
  }
  depends_on = [aws_subnet.public]
}

/*
output "all_public_subnets" {
  value = data.aws_subnets.all_public_subnets.ids
}
*/

data "aws_instances" "lemp" {
  filter {
    name   = "tag:Name"
    values = ["lemp-${var.env}-*"]
  }

  instance_state_names = ["running"]

  depends_on = [aws_instance.lemp]

}

output "lemp_private_ips" {
  value = data.aws_instances.lemp.private_ips
}
