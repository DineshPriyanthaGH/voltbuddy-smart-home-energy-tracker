resource "aws_s3_bucket" "frontend" {
  bucket = "voltbuddy-frontend-prod-240029900532"

  tags = {
    Name        = "VoltBuddy Frontend"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}