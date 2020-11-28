resource "aws_lb" "back_end" {
  name               = "simbu-lb-tf"
  internal           = "true"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.webservers.id}"]
  subnets            = ["${aws_subnet.private.id}", "${aws_subnet.private2.id}"]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "back_end" {
  name = "Target-Group-for-Backend"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.simbu_vpc.id}"
}

resource "aws_lb_listener" "appserver" {
  load_balancer_arn = "${aws_lb.back_end.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.back_end.arn}"
  }
}

output "Application load balancer Endpoint" {
  value = "${aws_lb.back_end.dns_name}"
}
