output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

output "subnet_a_id" {
  value = "${aws_subnet.subnet_a.id}"
}

output "subnet_b_id" {
  value = "${aws_subnet.subnet_b.id}"
}
