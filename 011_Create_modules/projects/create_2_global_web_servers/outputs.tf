output "instance_central_public_ip" {
  value = module.global_web_servers_ga.instance_first_public_ip
}

output "instance_west_public_ip" {
  value = module.global_web_servers_ga.instance_second_public_ip
}
