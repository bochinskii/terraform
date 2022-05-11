#
# Data Sources
#
data "aws_vpc" "prod" {
  tags = {
    Name = "prod"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

#
# Resources
#
resource "aws_subnet" "prod_1a" {
  vpc_id     = data.aws_vpc.prod.id
  cidr_block = "10.0.0.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "prod_${data.aws_availability_zones.available.names[0]}"
    Account = data.aws_caller_identity.current.account_id
  }
}

resource "aws_subnet" "prod_1b" {
  vpc_id     = data.aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "prod_${data.aws_availability_zones.available.names[1]}"
    Account = data.aws_caller_identity.current.account_id
  }
}

#
# Outputs
#
output "data_aws_vpc_prod_id" {
  value = data.aws_vpc.prod.id
}

output "aws_subnet_prod_1a_id" {
  value = aws_subnet.prod_1a.id
}

output "aws_subnet_prod_1a_cidr_block" {
  value = aws_subnet.prod_1a.cidr_block
}

output "aws_subnet_prod_1b_id" {
  value = aws_subnet.prod_1b.id
}

output "aws_subnet_prod_1b_cidr_block" {
  value = aws_subnet.prod_1b.cidr_block
}
