resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/voltbuddy-backend"
  retention_in_days = 7

  tags = {
    Name        = "voltbuddy-backend-logs"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}