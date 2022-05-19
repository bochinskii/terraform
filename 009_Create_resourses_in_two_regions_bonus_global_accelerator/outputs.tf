#
# Region
#

output "current_region_eu" {
  value = data.aws_region.current_region_eu.name
}

output "current_region_ca" {
  value = data.aws_region.current_region_ca.name
}

#
# VPC
#

output "availability_zones_eu" {
  value = data.aws_availability_zones.available_eu.names
}

output "availability_zones_ca" {
  value = data.aws_availability_zones.available_ca.names
}

output "aws_vpc_eu" {
  value = data.aws_vpc.default_eu.id
}

output "aws_vpc_ca" {
  value = data.aws_vpc.default_ca.id
}


output "subnets_eu" {
  value = data.aws_subnets.subnets_eu.ids
}

output "subnets_ca" {
  value = data.aws_subnets.subnets_ca.ids
}

#
# Endpoints ips (ec2 instances)
#

output "nginx_eu_public_ip" {
  value = aws_instance.nginx_eu.public_ip
}

output "nginx_ca_public_ip" {
  value = aws_instance.nginx_ca.public_ip
}

#
# Image id Amazon Linux
#

output "amazon_image_id_eu" {
  value = data.aws_ami.amazon_linux_2_5_latest_eu.image_id
}

output "amazon_image_id_ca" {
  value = data.aws_ami.amazon_linux_2_5_latest_ca.image_id
}
