output "vpc" {
  value = aws_vpc.main.id
}

output "all_private_subnets" {
  value = aws_subnet.private[*].id
}

output "all_public_subnets" {
  value = aws_subnet.public[*].id
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "bastion_public_ip" {
  value = var.env == "dev" ? element(aws_instance.bastion[*].public_ip, 0) : "there is no bastion"
}

output "instances_private_ips" {
  value = aws_instance.instances[*].private_ip
}
