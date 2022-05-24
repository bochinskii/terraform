data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "bochinskii-network-state"
    key    = "terraform/dev/vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}
