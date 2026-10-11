locals {
  backend_secret_names = [
    "MONGODB_URI",
    "JWT_SECRET",
    "GEMINI_API_KEY",
    "SMTP_HOST",
    "SMTP_PORT",
    "SMTP_USER",
    "SMTP_PASS"
  ]
}

resource "aws_secretsmanager_secret" "backend" {
  for_each = toset(local.backend_secret_names)

  name                    = "voltbuddy/backend/${each.key}"
  description             = "VoltBuddy backend configuration: ${each.key}"
  recovery_window_in_days = 7

  tags = {
    Name        = "voltbuddy-backend-${lower(each.key)}"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}