resource "aws_lb_listener" "front_end" {
  load_balancer_arn = var.load_balancer_arn
  protocol          = var.protocol
  port = var.port
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = var.action_type
    target_group_arn = var.target_group_arn
  }
}