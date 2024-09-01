output "alb_arns" {
  value = { for k, v in aws_lb.alb : k => v.arn }
}

output "target_group_arns" {
  value = { for k, v in aws_lb_target_group.tg : k => v.arn }
}

output "alb_listener_arns" {
  value = { for k, v in aws_lb_listener.listener : k => v.arn }
}
