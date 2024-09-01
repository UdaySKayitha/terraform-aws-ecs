resource "aws_cloudwatch_log_group" "ecs_log_group_backend" {
  name              = "/ecs/tii-backend-task-definition"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "ecs_log_group_frontend" {
  name              = "/ecs/tii-frontend-task-definition"
  retention_in_days = 30
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "tii-backend-task-definition"
  network_mode             = "bridge"
  container_definitions    = jsonencode([{
    name            = "backend"
    image           = "049087505393.dkr.ecr.eu-central-1.amazonaws.com/backend"
    cpu             = 0
    memory          = 1024
    portMappings    = [{
      containerPort = 3000
      hostPort      = 0
      protocol      = "tcp"
    }]
    essential       = true
    environment     = [
      { name = "MONGO_DB_CONNECTION_STRING", value = "mongodb://admin:password@internal-mongodb-264059930.eu-central-1.elb.amazonaws.com:27017/tii_mongo" }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"        = aws_cloudwatch_log_group.ecs_log_group_backend.name

        "awslogs-region"       = var.aws_region
        "awslogs-stream-prefix"= "ecs"
      }
    }
    ulimits = [{
      name      = "nofile"
      softLimit = 65535
      hardLimit = 65535
    }]
  }])
  requires_compatibilities = ["EC2"]
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_execution_role_arn
  cpu                      = "512"
  memory                   = "1024"
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "tii-frontend-task-definition"
  network_mode             = "bridge"
  container_definitions    = jsonencode([{
    name            = "frontend"
    image           = "049087505393.dkr.ecr.eu-central-1.amazonaws.com/frontend"
    cpu             = 0
    memory          = 512
    portMappings    = [{
      containerPort = 80
      hostPort      = 0
      protocol      = "tcp"
    }]
    essential       = true
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"        = aws_cloudwatch_log_group.ecs_log_group_frontend.name
        "awslogs-region"       = var.aws_region
        "awslogs-stream-prefix"= "ecs"
      }
    }
  }])
  requires_compatibilities = ["EC2"]
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_execution_role_arn
  cpu                      = "512"
  memory                   = "512"
}

resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "EC2"
  load_balancer {
    target_group_arn = var.alb_target_group_arns["backend"]
    container_name   = "backend"
    container_port   = 3000
  }
}

resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "EC2"
  load_balancer {
    target_group_arn = var.alb_target_group_arns["frontend"]
    container_name   = "frontend"
    container_port   = 80
  }
}
