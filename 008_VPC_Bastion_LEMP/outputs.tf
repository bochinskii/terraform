output "vpc" {
  value = aws_vpc.main.id
}

output "all_private_subnets" {
  value = data.aws_subnets.all_private_subnets.ids
}

output "all_public_subnets" {
  value = data.aws_subnets.all_public_subnets.ids
}
