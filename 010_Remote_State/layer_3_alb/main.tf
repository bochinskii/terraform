#
# ALB
#

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.ec2.outputs.alb_sg_id]
  subnets            = data.terraform_remote_state.vpc.outputs.subnet_ids


  tags = {
    Name = "alb-${data.terraform_remote_state.vpc.outputs.env}"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  deregistration_delay = 10

  health_check {
    enabled = true
    healthy_threshold = lookup(var.health_check, "healthy_threshold")
    interval = lookup(var.health_check, "interval")
    protocol = lookup(var.health_check, "protocol")
    timeout = lookup(var.health_check, "timeout")
    unhealthy_threshold = lookup(var.health_check, "unhealthy_threshold")
    port = lookup(var.health_check, "port")
    path = lookup(var.health_check, "path")
  }

  tags = {
    Name = "alb-tg-${data.terraform_remote_state.vpc.outputs.env}"
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_attach" {
  count            = length(data.terraform_remote_state.ec2.outputs.instances_ids)
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = element(data.terraform_remote_state.ec2.outputs.instances_ids, count.index)
  port             = 80
}

# Listeners
resource "aws_lb_listener" "alb_listener_80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}

resource "aws_lb_listener" "alb_listener_443" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-central-1:880954070217:certificate/b332d9f6-26ca-4635-9502-1d9e1e1ba4fb"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
