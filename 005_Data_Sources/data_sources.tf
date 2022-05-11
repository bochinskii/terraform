/
data "aws_availability_zones" "available" {
  state = "available"
}

output "data_aws_availability_zones_available"{
  value = data.aws_availability_zones.available
}

output "data_aws_availability_zones_available_names"{
  value = data.aws_availability_zones.available.names
}

output "data_aws_availability_zones_available_first_name"{
  value = data.aws_availability_zones.available.names[0]
}

#

data "aws_caller_identity" "current" {}

output "data_aws_caller_identity_current_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_caller_identity_current_user_id" {
  value = data.aws_caller_identity.current.user_id
}

output "data_aws_caller_identity_current_arn" {
  value = data.aws_caller_identity.current.arn
}

#

data "aws_region" "current" {}

output "data_aws_region_current_name" {
  value = data.aws_region.current.name
}

#

data "aws_vpcs" "all" {}

output "data_aws_vpcs_all_ids" {
  value = data.aws_vpcs.all.ids
}
