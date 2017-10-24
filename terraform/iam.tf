resource "aws_iam_instance_profile" "iam_instance" {
  role = "${aws_iam_role.ecs-instance.name}"
}

resource "aws_iam_policy" "ec2-s3" {
  name   = "swarm-ec2-s3"
  policy = "${data.aws_iam_policy_document.ec2-s3.json}"
}

resource "aws_iam_role" "ecs-instance" {
  name_prefix        = "swarm-ecsinstance"
  assume_role_policy = "${file("./files/roles/ecsPolicy.json")}"
}

resource "aws_iam_role_policy_attachment" "attach-ec2-s3" {
  role       = "${aws_iam_role.ecs-instance.name}"
  policy_arn = "${aws_iam_policy.ec2-s3.arn}"
}
