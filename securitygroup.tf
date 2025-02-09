resource "aws_security_group" "webservers" {
  name        = "Http"
  description = "Allow Http all inbound traffic"
  vpc_id      = "${aws_vpc.star_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "Tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "Tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "Tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
