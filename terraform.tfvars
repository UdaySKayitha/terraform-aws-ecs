aws_region                = "us-east-1"
ecs_cluster_name          = "LC-ecs-cluster"
ecs_task_execution_role_name = "LC_ecsTaskExecutionRole"
ecs_instance_role_name    = "LC_cluster_ecsInstanceRole"
ecs_instance_profile_name = "LC_cluster_ecsInstanceProfile"
ecs_launch_template_name  = "LC_ecsLaunchTemplate"
ami_id                    = "ami-007868005aea67c54"
instance_type             = "t3.micro"
key_name                  = "amar_aws"
ebs_volume_size           = 1
desired_capacity          = 1
max_size                  = 3
min_size                  = 1
vpc_id                    = "vpc-09dda42fc903cdd61"
subnet_ids                = ["subnet-0d82ba3af1d3098bf", "subnet-0b3521928b8067075"]
alb_definitions = {
  backend     = { alb_type = "external", container_port = 3000 }
  frontend    = { alb_type = "external", container_port = 80 }
}
