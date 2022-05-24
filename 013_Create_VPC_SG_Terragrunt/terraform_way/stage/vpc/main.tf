module "vpc_stage" {
  source = "git@github.com:bochinskii/terraform-modules.git//aws_vpc?ref=v1.0.0"

  env = "stage"
  vpc_cidr_block = "10.20.0.0/16"
  public_subnet_cidr_blocks = [
    "10.20.0.0/24",
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]
  private_subnet_cidr_blocks = []
  db_subnet_cidr_blocks = []
}