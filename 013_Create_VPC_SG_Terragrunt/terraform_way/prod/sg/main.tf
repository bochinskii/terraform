module "sg_web_prod" {
  source = "git@github.com:bochinskii/terraform-modules.git//aws_security_group?ref=v1.0.0"

  env = "prod"
  sg_name = "web"
  sg_desc = "Allow WEB"
  vpc_default = false
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  from_sg = false
  to_sg = false
  ingress = {
    description = "WEB Ports from all"
    protocol = "tcp"
  }
  ingress_ports = [80, 443]
}

module "sg_ssh_prod" {
  source = "git@github.com:bochinskii/terraform-modules.git//aws_security_group?ref=v1.0.0"

  env = "prod"
  sg_name = "ssh"
  sg_desc = "Allow SSH"
  vpc_default = false
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  from_sg = false
  to_sg = false
  ingress = {
    description = "SSH Port from all"
    protocol = "tcp"
  }
  ingress_ports = [2222]

}
