data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "bochinskii-lemp-state"
    key    = "nginx/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"

  config = {
    bucket = "bochinskii-lemp-state"
    key    = "nginx/ec2/terraform.tfstate"
    region = "eu-central-1"
  }
}

output "vpc_backend" {
  value = terraform_remote_state.vpc
}

output "ec2_backend" {
  value = terraform_remote_state.ec2
}
