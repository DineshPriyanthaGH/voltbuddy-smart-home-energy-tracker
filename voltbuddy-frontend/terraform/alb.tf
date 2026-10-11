resource "aws_lb" "backend" {
  name               = "voltbuddy-backend-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name        = "voltbuddy-backend-alb"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_lb_target_group" "backend" {
  name        = "voltbuddy-backend-tg"
  port        = 5001
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = aws_vpc.main.id

  health_check {
    path     = "/health"
    protocol = "HTTP"
    port     = "traffic-port"

    healthy_threshold   = 2
    unhealthy_threshold = 3

    timeout  = 5
    interval = 30

    matcher = "200"
  }

  tags = {
    Name        = "voltbuddy-backend-tg"
    Project     = "VoltBuddy"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.backend.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.backend.arn
  }
}

