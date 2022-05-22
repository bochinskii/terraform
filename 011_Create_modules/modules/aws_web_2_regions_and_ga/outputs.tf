#
# Region
#

output "current_region_first" {
  value = data.aws_region.current_region_first.name
}

output "current_region_second" {
  value = data.aws_region.current_region_second.name
}

#
# VPC
#

output "availability_zones_first" {
  value = data.aws_availability_zones.available_first.names
}

output "availability_zones_second" {
  value = data.aws_availability_zones.available_second.names
}

output "aws_vpc_first" {
  value = data.aws_vpc.default_first.id
}

output "aws_vpc_second" {
  value = data.aws_vpc.default_second.id
}


output "subnets_first" {
  value = data.aws_subnets.subnets_first.ids
}

output "subnets_second" {
  value = data.aws_subnets.subnets_second.ids
}

#
# Endpoints ips (ec2 instances)
#

output "instance_first_public_ip" {
  value = aws_instance.instance_first.public_ip
}

output "instance_second_public_ip" {
  value = aws_instance.instance_second.public_ip
}

#
# Image id Amazon Linux
#

output "amazon_image_id_first" {
  value = data.aws_ami.amazon_linux_2_5_latest_first.image_id
}

output "amazon_image_id_second" {
  value = data.aws_ami.amazon_linux_2_5_latest_second.image_id
}
