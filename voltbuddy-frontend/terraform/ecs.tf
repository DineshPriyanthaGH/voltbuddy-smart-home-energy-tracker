resource "aws_ecs_cluster" "backend" {
  name = "voltbuddy-backend-cluster"

  tags = {
    Name        = "voltbuddy-backend-cluster"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}