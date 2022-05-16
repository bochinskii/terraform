output "vpc" {
  value = aws_vpc.main.id
}

output "all_private_subnets" {
  value = data.aws_subnets.all_private_subnets.ids
}

output "all_public_subnets" {
  value = data.aws_subnets.all_public_subnets.ids
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "bastion_public_ip" {
  value = var.env == "dev" ? element(aws_instance.bastion.*.public_ip, 0) : "there is no bastion"
}
