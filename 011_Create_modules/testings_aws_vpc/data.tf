data "aws_region" "current_region" {}

/*
output "current_region" {
  value = data.aws_region.current_region.name
}
*/

data "aws_availability_zones" "available" {
  state = "available"
}

/*
output "availability_zones" {
  value = data.aws_availability_zones.available.names
}
*/
