variable "ssh_port" {}

resource "aws_instance" "my_lemp" {
  ami = "ami-05f5f4f906feab6a7"
  instance_type = "t2.micro"

  key_name = "bochinskii_Frankfurt_2"

  vpc_security_group_ids = [
    aws_security_group.my_lemp_web.id,
    aws_security_group.my_lemp_ssh.id
  ]

  availability_zone = "eu-central-1a"
  subnet_id = "subnet-000c2008b7496a3b7"
  user_data_base64 = file("../secret/user_data.base64.sh")

  root_block_device {
    volume_type = "gp3"
    volume_size = 10
    delete_on_termination = true
  }

  tags = {
    Name = "my_lemp"
    Owner = "Denis Bochinskii"
  }
}

resource "aws_security_group" "my_lemp_web" {
  name        = "my_lemp_web"
  description = "Allow Web traffic"
  vpc_id      = "vpc-03ccdbfd7272a7584"

  ingress {
    description      = "To HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "To HTTPS"
    from_port        = 443
    to_port          = 443
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
    Name = "my_lemp_web"
    Owner = "Denis Bochinskii"
  }
}

resource "aws_security_group" "my_lemp_ssh" {
  name        = "my_lemp_ssh"
  description = "Allow Web traffic"
  vpc_id      = "vpc-03ccdbfd7272a7584"

  ingress {
    description      = "To SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "To custome SSH"
    from_port        = var.ssh_port
    to_port          = var.ssh_port
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
    Name = "my_lemp_ssh"
    Owner = "Denis Bochinskii"
  }
}
