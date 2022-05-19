variable "env" {
  type = string
  default = "dev"
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
