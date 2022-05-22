#
# Provider
#

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

      configuration_aliases = [
        aws.second
      ]
      
    }
  }
}

#
# EC2 Instances
#

#  EC2 Instance in default privider (eu-central-1)
resource "aws_instance" "instance_first" {
  ami = data.aws_ami.amazon_linux_2_5_latest_first.image_id
  instance_type = var.instance_type

  key_name = var.key_names["key_name_first"]

  vpc_security_group_ids = [
    aws_security_group.http_first.id,
    aws_security_group.ssh_first.id
  ]

  subnet_id = var.default_vpc_id == true ? data.aws_subnets.subnets_first.ids[0] : var.subnet_id_first

  user_data_base64 = base64encode(file(var.user_data_file))

  user_data_replace_on_change = true

  root_block_device {
    volume_type = var.root_block_device["volume_type"]
    volume_size = var.root_block_device["volume_size"]
    delete_on_termination = true
  }

  tags = {
    Name = "${var.name_instances}-${data.aws_region.current_region_first.name}"
  }
}

#  EC2 Instance in privider (ca-central-1)
resource "aws_instance" "instance_second" {
  provider = aws.second
  ami = data.aws_ami.amazon_linux_2_5_latest_second.image_id
  instance_type = var.instance_type

  key_name = var.key_names["key_name_second"]

  vpc_security_group_ids = [
    aws_security_group.http_second.id,
    aws_security_group.ssh_second.id
  ]

  subnet_id = var.default_vpc_id == true ? data.aws_subnets.subnets_second.ids[0] : var.subnet_id_second

  user_data_base64 = base64encode(file(var.user_data_file))

  user_data_replace_on_change = true

  root_block_device {
    volume_type = var.root_block_device["volume_type"]
    volume_size = var.root_block_device["volume_size"]
    delete_on_termination = true
  }

  tags = {
    Name = "${var.name_instances}-${data.aws_region.current_region_second.name}"
  }
}

#
# Security groups
#

# Security group for eu-central-1
resource "aws_security_group" "http_first" {
  name        = "http-${data.aws_region.current_region_first.name}"
  description = "Allow Web traffic"
  vpc_id      = var.default_vpc_id == true ? data.aws_vpc.default_first.id : var.vpc_id_first

  ingress {
    description      = "To HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "http-${data.aws_region.current_region_first.name}"
  }
}

resource "aws_security_group" "ssh_first" {
  name        = "ssh-${data.aws_region.current_region_first.name}"
  description = "Allow ssh traffic"
  vpc_id      = var.default_vpc_id == true ? data.aws_vpc.default_first.id : var.vpc_id_first

  ingress {
    description      = "To SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-${data.aws_region.current_region_first.name}"
  }
}

# Security group for ca-central-1
resource "aws_security_group" "http_second" {
  provider = aws.second
  name        = "http-${data.aws_region.current_region_second.name}"
  description = "Allow Web traffic"
  vpc_id      = var.default_vpc_id == true ? data.aws_vpc.default_second.id : var.vpc_id_second

  ingress {
    description      = "To HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "http-${data.aws_region.current_region_second.name}"
  }
}

resource "aws_security_group" "ssh_second" {
  provider = aws.second
  name        = "ssh-${data.aws_region.current_region_second.name}"
  description = "Allow ssh traffic"
  vpc_id      = var.default_vpc_id == true ? data.aws_vpc.default_second.id : var.vpc_id_second

  ingress {
    description      = "To SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh-${data.aws_region.current_region_second.name}"
  }
}
