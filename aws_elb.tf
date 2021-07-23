resource "aws_lb" "webservers-alb" {
  count              = var.lb_type == "alb" ? 1 : 0
  name               = "WebServer-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0bd1277867487c865"]
  subnets            = ["subnet-44be3608","subnet-69f78d13"]
 }

 resource "aws_lb_listener" "webservers-alb-listener" {
  count              = var.lb_type == "alb" ? 1 : 0
  load_balancer_arn = aws_lb.webservers-alb[0].arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:eu-west-2:091306531308:targetgroup/Webservers/3234192b504b8810"
  }
}

resource "aws_lb" "webservers-nlb" {
  count              = var.lb_type == "nlb"  ? 1 : 0 
  name               = "WebServer-NLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["subnet-44be3608","subnet-69f78d13"]
}

resource "aws_lb_listener" "webservers-nlb-listener" {
  count              = var.lb_type == "nlb"  ? 1 : 0 
  load_balancer_arn = aws_lb.webservers-nlb[0].arn
  port              = "80"
  protocol          = "TCP"
    default_action {
    type             = "forward"
    target_group_arn = "arn:aws:elasticloadbalancing:eu-west-2:091306531308:targetgroup/webservers-2/384fab9b7f4770e0"
  }
}