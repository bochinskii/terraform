variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "bochinskii_Frankfurt_2"
}

variable "root_block_device" {
  type = map(string)
  default = {
    volume_type = "gp3"
    volume_size = "10"
  }
}
