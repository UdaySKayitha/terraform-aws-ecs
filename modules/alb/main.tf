resource "aws_lb" "alb" {
  for_each = var.alb_definitions

  name               = replace(each.key, "_", "-") # Replace underscores with hyphens
  internal           = each.value.alb_type == "internal" ? true : false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  tags = {
    Name = replace(each.key, "_", "-") # Replace underscores with hyphens
  }
}

resource "aws_lb_target_group" "tg" {
  for_each = var.alb_definitions

  name        = replace(each.key, "_", "-") # Replace underscores with hyphens
  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol = "HTTP"
    path     = "/"
  }

  tags = {
    Name = replace(each.key, "_", "-") # Replace underscores with hyphens
  }
}

resource "aws_lb_listener" "listener" {
  for_each = var.alb_definitions

  load_balancer_arn = aws_lb.alb[each.key].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[each.key].arn
  }
}
