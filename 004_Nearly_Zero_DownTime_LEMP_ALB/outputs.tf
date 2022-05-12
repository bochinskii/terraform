output "aws_instance_my_lemp_public_ip" {
  value = aws_instance.my_lemp.public_ip
}

output "target_group_arn" {
  value = aws_lb_target_group.my_lemp_alb_tg.arn
}

output "aws_instance_my_lemp_public_dns" {
  value = aws_instance.my_lemp.public_dns
}

output "my_lemp_alb_dns" {
  value = aws_lb.my_lemp_alb.dns_name
}
