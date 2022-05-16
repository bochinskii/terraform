terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {}

#provider "aws" {
#  region = "eu-central-1"
#  shared_credentials_files = ["~/.aws/credentials"]
#  profile = "default"
#}
