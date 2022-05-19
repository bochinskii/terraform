terraform {
  backend "s3" {
    bucket = "bochinskii-lemp-state"
    key    = "nginx/ec2/terraform.tfstate"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

#provider "aws" {
#  region = "eu-central-1"
#  shared_credentials_files = ["~/.aws/credentials"]
#  profile = "default"
#}
