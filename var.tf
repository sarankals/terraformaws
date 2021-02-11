variable "aws_region" {
  default = "us-west-2"
}
variable "vpc_cidr" {
  default = "10.10.0.0/16"
}
variable "subnets_cidr" {
  type = "list"
  default = ["10.10.1.0/24","10.10.2.0/24","10.10.3.0/24","10.10.4.0/24"]
}
variable "azs" {
  type = "list"
  default = ["us-west-2a","us-west-2b","us-west-2c","us-west-2d"]
}

variable "instance_type" {
  default = "t2.micro"
}
variable "ami" {
  type = "map"
  default = {
    us-west-2 = "ami-XXXXXXXXXXXXXXXX"
    us-east-1 = "ami-XXXXXXXXXXXXXXXX"
  }
}
