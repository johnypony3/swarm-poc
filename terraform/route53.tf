resource "aws_route53_record" "swarm" {
  #zone_id = "${aws_route53_zone.theemm.zone_id}"
  zone_id = "Z30GFBEA6WECL0"
  name    = "swarm"
  type    = "A"
  ttl     = "5"
  records = ["${aws_instance.docker_host.public_ip}"]
}
