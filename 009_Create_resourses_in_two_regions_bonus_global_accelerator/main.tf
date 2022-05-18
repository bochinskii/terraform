
#
# EC2 Instances
#

#  EC2 Instance in default privider (eu-central-1)
resource "aws_instance" "nginx_eu" {
  ami = data.aws_ami.amazon_linux_2_5_latest_eu.image_id
  instance_type = var.instance_type

  key_name = var.key_names["key_name_eu"]

  vpc_security_group_ids = [
    aws_security_group.http_eu.id,
    aws_security_group.ssh_eu.id
  ]

  subnet_id = data.aws_subnets.subnets_eu.ids[0]

  user_data_base64 = base64encode(file("./nginx.sh"))

  user_data_replace_on_change = true

  root_block_device {
    volume_type = var.root_block_device["volume_type"]
    volume_size = var.root_block_device["volume_size"]
    delete_on_termination = true
  }

  tags = {
      Name = "nginx-eu"
      Owner = "Denis Bochinskii"
  }
}

#  EC2 Instance in default privider (ca-central-1)
resource "aws_instance" "nginx_ca" {
  provider = aws.canada
  ami = data.aws_ami.amazon_linux_2_5_latest_ca.image_id
  instance_type = var.instance_type

  key_name = var.key_names["key_name_ca"]

  vpc_security_group_ids = [
    aws_security_group.http_ca.id,
    aws_security_group.ssh_ca.id
  ]

  subnet_id = data.aws_subnets.subnets_ca.ids[0]

  user_data_base64 = base64encode(file("./nginx.sh"))

  user_data_replace_on_change = true

  root_block_device {
    volume_type = var.root_block_device["volume_type"]
    volume_size = var.root_block_device["volume_size"]
    delete_on_termination = true
  }

  tags = {
      Name = "nginx-ca"
      Owner = "Denis Bochinskii"
  }
}

#
# Security groups
#

# Security group for eu-central-1
resource "aws_security_group" "http_eu" {
  name        = "http_eu"
  description = "Allow Web traffic"
  vpc_id      = data.aws_vpc.default_eu.id

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
    Name = "http"
    Owner = "Denis Bochinskii"
  }
}

resource "aws_security_group" "ssh_eu" {
  name        = "ssh_eu"
  description = "Allow Web traffic"
  vpc_id      = data.aws_vpc.default_eu.id

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
    Name = "ssh"
    Owner = "Denis Bochinskii"
  }
}

# Security group for ca-central-1
resource "aws_security_group" "http_ca" {
  provider = aws.canada
  name        = "http_ca"
  description = "Allow Web traffic"
  vpc_id      = data.aws_vpc.default_ca.id

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
    Name = "http"
    Owner = "Denis Bochinskii"
  }
}

resource "aws_security_group" "ssh_ca" {
  provider = aws.canada
  name        = "ssh_ca"
  description = "Allow Web traffic"
  vpc_id      = data.aws_vpc.default_ca.id

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
    Name = "ssh"
    Owner = "Denis Bochinskii"
  }
}
