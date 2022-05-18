variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_names" {
  type = map(string)
  default = {
    key_name_eu = "bochinskii_Frankfurt_2"
    key_name_ca = "bochinskii_Canada"
  }
}

variable "root_block_device" {
  type = map(string)
  default = {
    volume_type = "gp3"
    volume_size = "10"
  }
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
