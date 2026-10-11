resource "aws_security_group" "alb" {
  name        = "voltbuddy-alb-sg"
  description = "Security group for VoltBuddy Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "voltbuddy-alb-sg"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_security_group" "ecs" {
  name        = "voltbuddy-ecs-sg"
  description = "Security group for VoltBuddy ECS tasks"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Backend traffic from ALB"
    from_port       = 5001
    to_port         = 5001
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "voltbuddy-ecs-sg"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}