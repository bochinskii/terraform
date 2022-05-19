output "nginx_public_ip" {
  value = aws_instance.nginx.public_ip
}

output "alb_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "instances_ids" {
  value = aws_instance.instances[*].id
}
