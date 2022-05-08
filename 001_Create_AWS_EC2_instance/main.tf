resource "aws_instance" "my_amazon_linux" {
  ami = "ami-05f5f4f906feab6a7"
  instance_type = "t2.micro"

  key_name = "bochinskii_Frankfurt_2"

  vpc_security_group_ids = [
    "sg-004c28689f21a4a77",
    "sg-061ddb8453ccbf935"
  ]
  availability_zone = "eu-central-1a"
  subnet_id = "subnet-000c2008b7496a3b7"

  root_block_device {
    volume_type = "gp3"
    volume_size = 10
    delete_on_termination = true
  }

  tags = {
    Name = "my_amazon_linux"
    Owner = "Denis Bochinskii"
  }
}

#resource "aws_instance" "my_amazon_linux_2" {
#  ami = "ami-05f5f4f906feab6a7"
#  instance_type = "t2.micro"
#
#  key_name = "bochinskii_Frankfurt_2"
#
#  vpc_security_group_ids = [
#    "sg-004c28689f21a4a77",
#    "sg-061ddb8453ccbf935"
#  ]
#  availability_zone = "eu-central-1b"
#  subnet_id = "subnet-0646580d441af171c"
#
#  root_block_device {
#    volume_type = "gp3"
#    volume_size = 10
#    delete_on_termination = true
#  }
#
#  tags = {
#    Name = "my_amazon_linux_2"
#    Owner = "Denis Bochinskii"
#  }
#}
