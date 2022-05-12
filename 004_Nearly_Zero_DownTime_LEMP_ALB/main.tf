#
# EC2 Instance
#
resource "aws_instance" "my_lemp" {
  ami = var.ami
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.my_lemp_web.id,
    aws_security_group.my_lemp_ssh.id
  ]

  availability_zone = var.availability_zone
  subnet_id = var.all_subnet_id[0]

  user_data_base64 = base64encode(templatefile("./user_data_http_old.sh.tftpl",
  {
    hostname = var.hostname,
    timezone = var.timezone,
    ssh_port = var.ssh_port,
    mysql_repo = var.mysql_repo,
    mysql_root_pass = var.mysql_root_pass,
    mysql_admin_user = var.mysql_admin_user,
    mysql_admin_user_pass = var.mysql_admin_user_pass,
    mysql_drupal_user = var.mysql_drupal_user,
    mysql_drupal_user_pass = var.mysql_drupal_user_pass,
    mysql_drupal_db = var.mysql_drupal_db,
    pkgs = var.pkgs,
    ssl_cert = var.ssl_cert,
    ssl_key = var.ssl_key,
    site_dir = var.site_dir,
    site_config = var.site_config
  }
  ))
  user_data_replace_on_change = true

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.template_tags,
    {
      Name = "my_lemp_${var.template_tags["Env"]}"
    }
  )
}

#
# ALB
#
resource "aws_lb" "my_lemp_alb" {
  name               = "my-lemp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_lemp_alb_sg.id]
  subnets            = var.all_subnet_id

  tags = merge(
    var.template_tags,
    {
      Name = "my_lemp_alb_${var.template_tags["Env"]}"
    }
  )
}

resource "aws_lb_target_group" "my_lemp_alb_tg" {
  name        = "my-lemp-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled = true
    healthy_threshold = var.health_check["healthy_threshold"]
    interval = var.health_check["interval"]
    protocol = var.health_check["protocol"]
    timeout = var.health_check["timeout"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    port = var.health_check["port"]
  }

  tags = merge(
    var.template_tags,
    {
      Name = "my_lemp_alb_tg_${var.template_tags["Env"]}"
    }
  )
}

resource "aws_lb_target_group_attachment" "my_lemp_alb_tg_attach" {
  target_group_arn = aws_lb_target_group.my_lemp_alb_tg.arn
  target_id        = aws_instance.my_lemp.id
  port             = 80
}

# Listeners
resource "aws_lb_listener" "my_lemp_alb_listener_80" {
  load_balancer_arn = aws_lb.my_lemp_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    # type = "forward"
    # target_group_arn = aws_lb_target_group.my_lemp_alb_tg.arn
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}

resource "aws_lb_listener" "my_lemp_alb_listener_443" {
  load_balancer_arn = aws_lb.my_lemp_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-central-1:880954070217:certificate/b332d9f6-26ca-4635-9502-1d9e1e1ba4fb"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_lemp_alb_tg.arn
  }
}


#
# Security Groups
#
resource "aws_security_group" "my_lemp_alb_sg" {
  name        = "my_lemp_alb_sg"
  description = "Allow Web traffic"
  vpc_id      = var.vpc_id


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

  tags = merge(
    var.template_tags,
    {
      Name = "my_lemp_alb_sg"
    }
  )
}

resource "aws_security_group" "my_lemp_web" {
  name        = "my_lemp_web"
  description = "Allow Web traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "All from ALB"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    security_groups  = [aws_security_group.my_lemp_alb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.template_tags,
    {
      Name = "my_lemp_web"
    }
  )
}

resource "aws_security_group" "my_lemp_ssh" {
  name        = "my_lemp_ssh"
  description = "Allow ssh traffic"
  vpc_id      = var.vpc_id

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

  tags = merge(
    var.template_tags,
    {
      Name = "my_lemp_ssh"
    }
  )
}
