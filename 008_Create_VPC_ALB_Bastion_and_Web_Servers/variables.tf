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
# Security Group variable
#

variable "ssh_port" {} # for user data and aws_security_group


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
     path = "/"
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
