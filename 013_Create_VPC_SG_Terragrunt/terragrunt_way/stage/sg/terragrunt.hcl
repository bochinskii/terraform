#
# Use parent terrugrunt.hcl file
#
include "root" {
  path = find_in_parent_folders()
}

#
# remote_state
#
dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = ""
  }
}

#
# VPC first then seciruty groups
#
dependencies {
  paths = ["../vpc"]
}

#
# Use Module
#
terraform {
  #source = "git@github.com:bochinskii/terraform-modules.git//aws_security_group?ref=v1.0.0"
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git//."
}

inputs = {
  name        = "all-stage"
  description = "ALL"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ALL"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_ipv6_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "ALL"
      ipv6_cidr_blocks = "::/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "ALL"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_ipv6_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "ALL"
      ipv6_cidr_blocks = "::/0"
    }
  ]

}
