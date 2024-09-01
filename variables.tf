variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS Cluster name"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "ECS Task Execution Role name"
  type        = string
}

variable "ecs_instance_role_name" {
  description = "ECS Instance Role name"
  type        = string
}

variable "ecs_instance_profile_name" {
  description = "ECS Instance Profile name"
  type        = string
}

variable "ecs_launch_template_name" {
  description = "ECS Launch Configuration name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "ebs_volume_size" {
  description = "EBS volume size"
  type        = number
}

variable "desired_capacity" {
  description = "Desired capacity for Auto Scaling group"
  type        = number
}

variable "max_size" {
  description = "Maximum size for Auto Scaling group"
  type        = number
}

variable "min_size" {
  description = "Minimum size for Auto Scaling group"
  type        = number
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_definitions" {
  description = "Definitions for the ALBs"
  type = map(object({
    alb_type       = string
    container_port = number
  }))
}