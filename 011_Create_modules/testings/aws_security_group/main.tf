
#
# Security Group
#

resource "aws_security_group" "main" {
  name        = "${var.sg_name}-${var.env}"
  description = var.sg_desc
  vpc_id      = var.vpc_default == false ? var.vpc_id : data.aws_vpc.selected.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      description      = var.ingress["description"]
      from_port        = ingress.value
      to_port          = var.ingress_ports[0] == 0 ? 65535 : ingress.value
      protocol         = var.ingress["protocol"]
      cidr_blocks      = var.from_sg == false ? var.ingress_cidr_blocks : []
      ipv6_cidr_blocks = var.from_sg == false ? var.ingress_ipv6_cidr_blocks : []
      security_groups  = var.from_sg == true ? var.ingress_security_groups_ids : []
    }
  }

  dynamic "egress" {
    for_each = var.egress_ports
    content {
      description      = var.egress["description"]
      from_port        = egress.value
      to_port          = var.egress_ports[0] == 0 ? 0 : egress.value
      protocol         = var.egress["protocol"]
      cidr_blocks      = var.to_sg == false ? var.egress_cidr_blocks : []
      ipv6_cidr_blocks = var.to_sg == false ? var.egress_ipv6_cidr_blocks : []
      security_groups  = var.to_sg == true ? var.egress_security_groups_ids : []
    }
  }


  tags = {
    Name = "${var.sg_name}-${var.env}"
  }
}
