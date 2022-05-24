output "web_sg_id" {
  value = module.sg_web_dev.sg_id
}

output "ssh_sg_id" {
  value = module.sg_ssh_dev.sg_id
}
