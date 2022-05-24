terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "bochinskii-network-state"
    key    = "terraform/stage/sg/terraform.tfstate"
    region = "eu-central-1"
  }

}

provider "aws" {
  region = "eu-central-1"
}
