#
# VPC
#
variable "env" {
  type = string
  default = "dev"
}

variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type = list
  default = [
    "10.0.128.0/24",
    "10.0.129.0/24",
    "10.0.130.0/24"
  ]
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}
#
# User data
#
variable "hostname" {
  type = string
  default = "rocinante"
}
variable "timezone" {
  type = string
  default = "Europe/Berlin"
}
variable "ssh_port" {} # for user data and aws_security_group
variable "mysql_repo" {
  type = string
  default = "https://dev.mysql.com/get/mysql80-community-release-el7-6.noarch.rpm"
}
variable "mysql_root_pass" {}
variable "mysql_admin_user" {}
variable "mysql_admin_user_pass" {}
variable "mysql_drupal_user" {}
variable "mysql_drupal_user_pass" {}
variable "mysql_drupal_db" {}
variable "pkgs" {
  type = list(string)
  default = [
    "php", "php-fpm", "php-pdo", "php-mysqlnd", "php-xml", "php-gd", "php-curl",
    "php-mbstring", "php-json", "php-common", "php-gmp", "php-intl", "php-gd", "php-cli", "php-zip", "php-opcache"
  ]
}
variable "site_dir" {}
variable "site_config" {
  type = string
  default = "rocinante.conf"
}

# ALB variables

variable "health_check" {
   type = map
   default = {
     healthy_threshold = "2"
     interval = "5"
     protocol = "HTTP"
     timeout = "2"
     unhealthy_threshold = "2"
     port = "80"
     path = "/index.html"
  }
}

#
# Other
#

variable "instance_type" {
  type = map(string)
  default = {
    dev = "t2.micro"
    prod = "t3.large"
    bastion = "t2.micro"
  }
}

variable "volume_type" {
  type = map(string)
  default = {
    dev = "gp2",
    prod = "io1",
    bastion = "gp2"
  }
}

variable "volume_size" {
  type = map(number)
  default = {
    dev = 10,
    prod = 30,
    bastion = 8
  }
}

variable "key_name" {
  type = string
  default = "bochinskii_Frankfurt_2"
}
