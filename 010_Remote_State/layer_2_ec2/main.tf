
#
# EC2 Instance
#

locals {
  instance_public_subnets = [
    data.terraform_remote_state.vpc.outputs.subnet_ids[0],
    data.terraform_remote_state.vpc.outputs.subnet_ids[1]
  ]
}

resource "aws_instance" "instances" {
  count = length(local.instance_public_subnets)
  ami = data.aws_ami.amazon_linux_2_5_latest.image_id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]


  subnet_id = element(local.instance_public_subnets, count.index)

  user_data_replace_on_change = true

  user_data_base64 = base64encode(file("./nginx.sh"))

  root_block_device {
    volume_type = lookup(var.root_block_device, "volume_type")
    volume_size = lookup(var.root_block_device, "volume_size")
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "instance-${data.terraform_remote_state.vpc.outputs.env}-${count.index + 1}"
  }
}


#
# Security Groups
#

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Allow Web traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id


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
    Name = "alb-sg-${data.terraform_remote_state.vpc.outputs.env}"
  }

}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow Web traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description      = "All from ALB and Bastion"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_sg.id]
  }

  ingress {
    description      = "ssh"
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
    Name = "ec2-sg-${data.terraform_remote_state.vpc.outputs.env}"
  }
}
