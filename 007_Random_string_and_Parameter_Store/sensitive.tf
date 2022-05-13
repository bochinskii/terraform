variable "revision_number" {
  type = number
  default = 1
}

resource "random_string" "password" {
  length           = 12
  special          = true
  override_special = "#$"

  keepers = {
    keeper1 = var.revision_number
  }
}

output "password_rs" {
  value = random_string.password.result
}

resource "aws_ssm_parameter" "password" {
  name        = "/dev/password"
  description = "Just a password"
  type        = "SecureString"
  value       = random_string.password.result

  tags = {
    Owner = "Denis Bochinskii"
    Environment = "DEV"
  }
}

data "aws_ssm_parameter" "password" {
  name = "/dev/password"

  depends_on = [aws_ssm_parameter.password]
}

output "password_ssm" {
  value = data.aws_ssm_parameter.password.value
  sensitive = true
}
