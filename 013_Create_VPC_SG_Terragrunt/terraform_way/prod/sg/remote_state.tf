data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "bochinskii-network-state"
    key    = "terraform/prod/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}
