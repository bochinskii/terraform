
variable "env" {
  type = string
  default = "dev"
}



variable "vpc_default" {
  type = bool
  default = true
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "from_sg" {
  default = false
}

variable "ingress_security_groups_ids" {
  type = list(string)
  default = []
}

variable "to_sg" {
  default = false
}

variable "egress_security_groups_ids" {
  type = list(string)
  default = []
}



variable "sg_name" {
  type = string
  default = "main"
}

variable "sg_desc" {
  type = string
  default = "main"
}

# Ingress
variable "ingress" {
  type = map
  default = {
    description = "All TCP Ports from all"
    protocol = "tcp"
  }
}

variable "ingress_ports" {
  type = list(number)
  default = [0]
}

variable "ingress_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "ingress_ipv6_cidr_blocks" {
  type = list(string)
  default = ["::/0"]
}


# Egress

variable "egress" {
  type = map
  default = {
    description = "All TCP Ports to all"
    protocol = "-1"
  }
}

variable "egress_ports" {
  type = list(number)
  default = [0]
}

variable "egress_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  type = list(string)
  default = ["::/0"]
}
