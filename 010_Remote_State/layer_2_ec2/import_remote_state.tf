data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "bochinskii-lemp-state"
    key    = "nginx/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}
/*
output "vpc_backend" {
  value = data.terraform_remote_state.vpc
}
*/
