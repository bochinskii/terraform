resource "aws_security_group" "alb" {
  name = "alb_HTTP_HTTPS"
  description = "Allow WEB traffic to alb from all"

  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol = "tcp"
  }

  ingress {
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    protocol = "-1"
  }

  tags = {
    Name = "alb_HTTP_HTTPS"
  }
}

resource "aws_security_group" "ssh" {
  name = "ec2_SSH"
  description = "Allow SSH to ec2 instances from all ip addresses"

  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    protocol = "-1"
  }

  tags = {
    Name = "ec2_SSH"
  }
}

resource "aws_security_group" "all_from_alb" {
  name = "ec2_TCP_ALB"
  description = "Allow all traffic to ec2 instances from ALB"

  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = 0
    to_port = 65535
    security_groups = [aws_security_group.alb.id]
    protocol = "tcp"
  }

  egress {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    protocol = "-1"
  }

  tags = {
    Name = "ec2_TCP_ALB"
  }
}
