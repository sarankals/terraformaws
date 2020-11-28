resource "aws_vpc" "simbu_vpc" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name = "Simbuvpc"
  }
}

resource "aws_internet_gateway" "simbu_gw" {
  vpc_id = "${aws_vpc.simbu_vpc.id}"

  tags = {
    Name = "main"
  }
}

resource "aws_eip" "nat" {
  vpc = true
  depends_on = ["aws_internet_gateway.simbu_gw"]
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public.id}"
  depends_on  = ["aws_internet_gateway.simbu_gw"]

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_subnet" "public" {
  vpc_id             = "${aws_vpc.simbu_vpc.id}"
  availability_zone = "${element(var.azs, 0)}"
  cidr_block         = "${element(var.subnets_cidr,0)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-${count.index+1}"
  }
}

resource "aws_subnet" "public2" {
  vpc_id             = "${aws_vpc.simbu_vpc.id}"
  availability_zone = "${element(var.azs, 2)}"
  cidr_block         = "${element(var.subnets_cidr,2)}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-${count.index+3}"
  }
}

resource "aws_subnet" "private" {
  vpc_id             = "${aws_vpc.simbu_vpc.id}"
  availability_zone = "${element(var.azs, 1)}"
  cidr_block         = "${element(var.subnets_cidr,1)}"

  tags = {
    Name = "Subnet-${count.index+2}"
  }
}

resource "aws_subnet" "private2" {
  vpc_id             = "${aws_vpc.simbu_vpc.id}"
  availability_zone = "${element(var.azs, 0)}"
  cidr_block         = "${element(var.subnets_cidr,3)}"

  tags = {
    Name = "Subnet-${count.index+4}"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.simbu_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.simbu_gw.id}"
  }

  tags = {
    Name = "PublicRT"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.simbu_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw.id}"

  }

  tags = {
    Name = "PrivateRT"
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "rt_association2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}

resource "aws_route_table_association" "private_rt_association2" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}
