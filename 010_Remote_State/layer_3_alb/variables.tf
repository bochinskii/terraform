variable "env" {
  type = string
  default = "dev"
}

variable "health_check" {
   type = map
   default = {
     healthy_threshold = "2"
     interval = "5"
     protocol = "HTTP"
     timeout = "2"
     unhealthy_threshold = "2"
     port = "80"
     path = "/check.html"
  }
}
