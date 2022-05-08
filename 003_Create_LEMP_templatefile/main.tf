
resource "aws_instance" "my_lemp" {
  ami = var.ami
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [
    aws_security_group.my_lemp_web.id,
    aws_security_group.my_lemp_ssh.id
  ]

  availability_zone = var.availability_zone
  subnet_id = var.subnet_id
  # user_data = templatefile("./user_data.sh.tftpl", {})
  user_data_base64 = base64encode(templatefile("./user_data.sh.tftpl",
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

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    delete_on_termination = true
  }

  tags = merge(
    var.template_tags,
    {
      Name = "my_lemp_${var.template_tags["Env"]}"
    }
  )
  /*
  tags = {
    Name = "my_lemp"
    Owner = "Denis Bochinskii"
    Project = "rocinante"
    Env = "dev"
  }
  */
}

resource "aws_security_group" "my_lemp_web" {
  name        = "my_lemp_web"
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
      Name = "my_lemp_web"
    }
  )

}

resource "aws_security_group" "my_lemp_ssh" {
  name        = "my_lemp_ssh"
  description = "Allow Web traffic"
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
