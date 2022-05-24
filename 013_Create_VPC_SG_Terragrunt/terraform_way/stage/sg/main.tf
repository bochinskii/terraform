module "sg_web_stage" {
  source = "git@github.com:bochinskii/terraform-modules.git//aws_security_group?ref=v1.0.0"

  env = "stage"
  sg_name = "all"
  sg_desc = "Allow WEB"
  vpc_default = false
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  from_sg = false
  to_sg = false
  ingress = {
    description = "All Ports from all"
    protocol = "tcp"
  }
  ingress_ports = [0]
}
