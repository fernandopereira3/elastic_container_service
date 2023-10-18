# 1 - CRIACAO DO LOADBALANCE 
resource "aws_lb" "loadbalance" {
  name               = "ecs-django"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.aplication_lb.id]
  subnets            = module.vpc.public_subnets
}
# 2 - LISTENER PARA O LOADBALANCE 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.loadbalance.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target.arn
  }
}

# 3 - CRIACAO DO TARGET (GRUPO EM QUE O LB É O ALVO) GRUPO DO LOAD BALANCE
resource "aws_lb_target_group" "target" {
  name        = "ecs-django"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

# output "dns name" {
#   value = aws_lb.loadbalance.dns_name
# }