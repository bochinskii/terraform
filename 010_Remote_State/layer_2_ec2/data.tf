data "aws_ami" "amazon_linux_2_5_latest" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
