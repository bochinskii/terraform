
#
# Instances
#

variable "default_vpc_id" {
  type = bool
  default = true
}

variable "vpc_id_first" {
  type = string
  default = ""
}

variable "vpc_id_second" {
  type = string
  default = ""
}

variable "subnet_id_first" {
  type = string
  default = ""
}

variable "subnet_id_second" {
  type = string
  default = ""
}

variable "name_instances" {
  default = "instance"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "user_data_file" {
  type = string
  default = "./nginx.sh"
}

variable "key_names" {
  type = map(string)
  default = {
    key_name_first = ""
    key_name_second = ""
  }
}

variable "root_block_device" {
  type = map(string)
  default = {
    volume_type = "gp3"
    volume_size = "8"
  }
}

#
# GA
#

variable "ga_name" {
  type = string
  default = "ga"
}

variable "health_checks_ga" {
  type = map(string)
  default = {
    health_check_interval_seconds = "10",
    health_check_path = "/check.html"
    health_check_protocol = "HTTP"
    threshold_count = "2"
  }
}
