#
# Use parent terrugrunt.hcl file
#
include "root" {
  path = find_in_parent_folders()
}

#
# Use Module
#
terraform {
  source = "git@github.com:bochinskii/terraform-modules.git//aws_vpc?ref=v1.0.0"
}

inputs = {
  env = "dev"
  vpc_cidr_block = "10.10.0.0/16"
  public_subnet_cidr_blocks = [
    "10.10.0.0/24",
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]
  private_subnet_cidr_blocks = []
  db_subnet_cidr_blocks = []
}
