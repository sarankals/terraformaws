resource "aws_lb" "front_end" {
  name               = "frontend-lb-tf"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.webservers.id}"]
  subnets            = ["${aws_subnet.public.id}", "${aws_subnet.public2.id}"]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "front_end" {
  name = "Target-Group-for-frontend"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.star_vpc.id}"
}

resource "aws_lb_listener" "webserver" {
  load_balancer_arn = "${aws_lb.front_end.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.front_end.arn}"
  }
}

output "web server load balancer Endpoint" {
  value = "${aws_lb.front_end.dns_name}"
}
