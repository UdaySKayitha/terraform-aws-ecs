provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "ecs_security_group" {
  name        = "ecs_security_group"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs_security_group"
  }
}

module "ecs_infrastructure" {
  source                        = "./modules/ecs_infrastructure"
  ecs_cluster_name              = var.ecs_cluster_name
  ecs_task_execution_role_name  = var.ecs_task_execution_role_name
  ecs_instance_role_name        = var.ecs_instance_role_name
  ecs_instance_profile_name     = var.ecs_instance_profile_name
  ecs_launch_template_name      = var.ecs_launch_template_name
  ami_id                        = var.ami_id
  instance_type                 = var.instance_type
  key_name                      = var.key_name
  ebs_volume_size               = var.ebs_volume_size
  desired_capacity              = var.desired_capacity
  max_size                      = var.max_size
  min_size                      = var.min_size
  subnet_ids                    = var.subnet_ids
  vpc_id                        = var.vpc_id
  security_group_id             = aws_security_group.ecs_security_group.id
}

module "alb" {
  source             = "./modules/alb"
  alb_definitions    = var.alb_definitions
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids
  security_group_id  = aws_security_group.ecs_security_group.id
}

module "ecs_services" {
  source                      = "./modules/ecs_services"
  ecs_cluster_id              = module.ecs_infrastructure.ecs_cluster_id
  ecs_task_execution_role_arn = module.ecs_infrastructure.ecs_task_execution_role_arn
  ecs_instance_role_arn       = module.ecs_infrastructure.ecs_instance_role_arn
  alb_listener_arns           = module.alb.alb_listener_arns
  alb_target_group_arns       = module.alb.target_group_arns
  aws_region                  = var.aws_region
  subnet_ids                  = var.subnet_ids
  security_group_id           = aws_security_group.ecs_security_group.id
}

output "ecs_cluster_id" {
  value = module.ecs_infrastructure.ecs_cluster_id
}

output "ecs_task_execution_role_arn" {
  value = module.ecs_infrastructure.ecs_task_execution_role_arn
}

output "ecs_instance_role_arn" {
  value = module.ecs_infrastructure.ecs_instance_role_arn
}

output "alb_listener_arns" {
  value = module.alb.alb_listener_arns
}

output "alb_arns" {
  value = module.alb.alb_arns
}

output "target_group_arns" {
  value = module.alb.target_group_arns
}