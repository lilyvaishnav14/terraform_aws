resource "aws_lb" "test" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sgid
  subnets            = var.subnets
}

resource "aws_lb_target_group" "tg" {
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpcid
  health_check {
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = var.instance1_id
  port = 80

}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = var.instance2_id
  port = 80

}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.test.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
}
