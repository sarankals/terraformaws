resource "aws_launch_configuration" "for_webserver" {
  name = "webserver-autoscaling-gp"
  image_id = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${file("install_httpd.sh")}"
  security_groups = ["${aws_security_group.webservers.id}"]
  key_name      = "${aws_key_pair.tf_demo.key_name}"
  root_block_device
  {
    volume_type = "${var.volume_type}"
    volume_size = "${var.volume_size}"
  }
}

resource "aws_launch_configuration" "for_appserver" {
  name = "appsever-autoscaling-gp"
  image_id = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  user_data     = "${file("install_httpd.sh")}"
  security_groups = ["${aws_security_group.webservers.id}"]
  key_name      = "${aws_key_pair.tf_demo.key_name}"
  root_block_device
  {
    volume_type = "${var.volume_type}"
    volume_size = "${var.volume_size}"
  }
}

resource "aws_key_pair" "tf_demo" {
}
