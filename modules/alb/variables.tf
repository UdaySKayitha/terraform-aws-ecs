variable "alb_definitions" {
  description = "Map of ALB definitions"
  type = map(object({
    alb_type       = string
    container_port = number
  }))
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}