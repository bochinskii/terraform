
variable "env" {
  type = string
  default = "default"
}

#
# VPC
#

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
  default = []
}
/*
variable "private_subnet_cidr_blocks" {
  type = list(string)
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}
*/
variable "db_subnet_cidr_blocks" {
  type = list(string)
  default = [
    "10.0.64.0/24",
    "10.0.65.0/24",
    "10.0.66.0/24"
  ]
}
