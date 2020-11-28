data "aws_ami" "ubuntu" {
  most_recent = "true"
  owners = ["515798882395"]
  filter
  {
    name = "name"
    values = ["2018.07.05_0948 (HVM)"]
  }
  filter
  {
    name = "virtualization-type"
    values = ["hvm"]
  }

}
