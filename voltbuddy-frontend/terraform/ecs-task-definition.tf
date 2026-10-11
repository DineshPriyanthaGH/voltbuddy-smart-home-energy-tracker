# CloudWatch log group is managed in ecs-logs.tf

resource "aws_ecs_task_definition" "backend" {
  family                   = "voltbuddy-backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "voltbuddy-backend"
      image     = "240029900532.dkr.ecr.us-east-1.amazonaws.com/voltbuddy-backend:latest"
      essential = true

      portMappings = [
        {
          containerPort = 5001
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "PORT"
          value = "5001"
        }
      ]

      secrets = [
        for secret_name in local.backend_secret_names : {
          name      = secret_name
          valueFrom = aws_secretsmanager_secret.backend[secret_name].arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.backend.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Name        = "voltbuddy-backend-task"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}