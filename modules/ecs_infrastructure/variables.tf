variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "The name of the ECS task execution role."
  type        = string
}

variable "ecs_instance_role_name" {
  description = "The name of the ECS instance role."
  type        = string
}

variable "ecs_instance_profile_name" {
  description = "The name of the ECS instance profile."
  type        = string
}

variable "ecs_launch_template_name" {
  description = "The name of the ECS launch configuration."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the ECS instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the ECS instances."
  type        = string
}

variable "key_name" {
  description = "The key name for the ECS instances."
  type        = string
}

variable "ebs_volume_size" {
  description = "The size of the EBS volume for the ECS instances."
  type        = number
}

variable "desired_capacity" {
  description = "The desired capacity of the ECS cluster."
  type        = number
}

variable "max_size" {
  description = "The maximum size of the ECS cluster."
  type        = number
}

variable "min_size" {
  description = "The minimum size of the ECS cluster."
  type        = number
}

variable "subnet_ids" {
  description = "The subnet IDs for the ECS instances."
  type        = list(string)
}

variable "vpc_id" {
  description = "The key name for the ECS instances."
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the ECS instances"
  type        = string
}