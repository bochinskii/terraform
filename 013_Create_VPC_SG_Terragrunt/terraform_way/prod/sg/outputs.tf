output "web_sg_id" {
  value = module.sg_web_prod.sg_id
}

output "ssh_sg_id" {
  value = module.sg_ssh_prod.sg_id
}
