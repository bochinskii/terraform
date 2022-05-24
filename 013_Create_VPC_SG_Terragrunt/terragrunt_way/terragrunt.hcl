#
# Backend
#

remote_state {
  backend = "s3"
  generate = {
    path      = "_backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "bochinskii-network-state"

    key     = "terragrunt/${path_relative_to_include()}/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}

#
# Provider
#
generate "provider" {
  path = "_provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "aws" {
  region = var.region
}

variable "region" {}
EOF

}

#
# Load vars
#

terraform {
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [find_in_parent_folders("common.tfvars")]
  }
}
