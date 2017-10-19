provider "aws" {
  region = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "swarm-terraform"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
