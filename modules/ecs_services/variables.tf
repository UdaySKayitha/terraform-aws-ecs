variable "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "alb_target_group_arns" {
  description = "Map of target group ARNs for the ALBs"
  type        = map(string)
}

variable "alb_listener_arns" {
  description = "Map of listener ARNs for the ALBs"
  type        = map(string)
}

variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "ecs_instance_role_arn" {
  description = "ARN of the ECS instance role"
  type        = string
}