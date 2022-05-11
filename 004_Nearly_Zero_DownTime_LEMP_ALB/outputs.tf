output "aws_instance_my_lemp_public_ip" {
  value = aws_instance.my_lemp.public_ip
}

output "aws_instance_my_lemp_public_dns" {
  value = aws_instance.my_lemp.public_dns
}
