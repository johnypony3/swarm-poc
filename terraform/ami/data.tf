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

data "aws_ami" "ubuntu_server" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Ubuntu Server *"]
  }
}

data "aws_ami" "enhanced_networking_base" {
  most_recent = true

  filter {
    name   = "name"
    values = ["enhanced_networking_base"]
  }
}
