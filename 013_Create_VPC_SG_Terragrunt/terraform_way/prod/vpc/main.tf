module "vpc_prod" {
  source = "git@github.com:bochinskii/terraform-modules.git//aws_vpc?ref=v1.0.0"

  env = "prod"
  vpc_cidr_block = "192.168.0.0/16"
  public_subnet_cidr_blocks = [
    "192.168.0.0/24",
    "192.168.1.0/24",
    "192.168.2.0/24"
  ]
  private_subnet_cidr_blocks = []
  db_subnet_cidr_blocks = [
    "192.168.10.0/24",
    "192.168.11.0/24",
    "192.168.12.0/24"
  ]
}
