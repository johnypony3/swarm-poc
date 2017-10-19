data "aws_iam_policy_document" "ec2-s3" {
  statement {
    actions = [
      "s3:Get",
      "s3:List",
    ]

    resources = [
      "*",
    ]

    effect = "Allow"
  }
}

/*
data "aws_route53_zone" "theemm" {
  name         = "theemm.com."
  private_zone = true
}
*/

data "aws_ami" "swarm_base" {
  most_recent = true

  filter {
    name   = "name"
    values = ["swarm_base*"]
  }
}
