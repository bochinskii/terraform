output "current_region" {
  value = data.aws_region.current_region.name
}

output "my_lemp_alb_dns" {
  value = aws_lb.my_lemp_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.my_lemp_alb_tg.arn
}

output "my_lemp_asg" {
  value = aws_autoscaling_group.my_lemp_asg.arn
}
