resource "aws_vpc" "main" {
  cidr_block = "10.180.0.0/16"

  tags {
    Name = "swarm_vpc"
  }

  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.180.100.0/24"
  availability_zone = "${var.az_a}"

  tags {
    Name = "swarm_subnet_a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "10.180.200.0/24"
  availability_zone = "${var.az_b}"

  tags {
    Name = "swarm_subnet_b"
  }
}
