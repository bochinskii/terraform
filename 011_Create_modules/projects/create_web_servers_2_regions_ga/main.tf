#
# Provider
#

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  region = "eu-west-1"
  alias = "west"
}

#
# Resources
#

module "global_web_servers_ga" {
  source = "../../modules/aws_web_2_regions_and_ga"

  providers = {
    aws = aws
    aws.second = aws.west
  }

  default_vpc_id = true

  name_instances = "super-nginx"
  user_data_file = "./super_nginx.sh"

  key_names = {
    key_name_first = "bochinskii_Frankfurt_2"
    key_name_second = "bochinskii_Ireland"
  }
}
