resource "aws_s3_bucket" "s3-terraform-state" {
  bucket = "${var.terraform_bucket_name}"
  acl    = "private"

  tags {
    Name = "${var.terraform_bucket_name}"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = true
  }
}

resource "aws_s3_bucket" "swarm_docker_data_mysql" {
  bucket = "swarm-docker-data-mysql"

  acl = "private"

  tags {
    bucket = "swarm-docker-data-mysql"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = true
  }
}

resource "aws_s3_bucket" "swarm_docker_data_portainer" {
  bucket = "swarm-docker-data-portainer"

  acl = "private"

  tags {
    bucket = "swarm-docker-data-portainer"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = true
  }
}
