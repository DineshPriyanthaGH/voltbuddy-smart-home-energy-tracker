# IAM Role assumed by ECS tasks
resource "aws_iam_role" "ecs_execution_role" {
  name = "voltbuddy-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "voltbuddy-ecs-execution-role"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# Permissions for ECR image pulls and CloudWatch logging
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role = aws_iam_role.ecs_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Allow ECS execution role to read VoltBuddy backend secrets
resource "aws_iam_role_policy" "ecs_secrets_policy" {
  name = "voltbuddy-ecs-secrets-access"
  role = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = [
          for secret in aws_secretsmanager_secret.backend :
          secret.arn
        ]
      }
    ]
  })
}