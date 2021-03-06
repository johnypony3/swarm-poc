provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "swarm-terraform"
    key    = "ami.terraform.tfstate"
    region = "us-west-2"
  }
}

module "vpc" {
  source     = "../vpc"
  aws_region = "${var.aws_region}"
  az_a       = "${var.az_a}"
  az_b       = "${var.az_b}"
}
