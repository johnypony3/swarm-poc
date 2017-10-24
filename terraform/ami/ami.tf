resource "aws_instance" "docker_base" {
  instance_type               = "${var.instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.docker_host.id}"]
  ami                         = "${data.aws_ami.enhanced_networking_base.id}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${module.vpc.subnet_a_id}"
  associate_public_ip_address = true
  monitoring                  = false
  source_dest_check           = false
  iam_instance_profile        = "${aws_iam_instance_profile.iam_instance.name}"

  tags {
    "Name"    = "swarm_docker_base"
    "petname" = "${random_pet.ec2_name.id}"
  }
}

resource "null_resource" "dependencies" {
  depends_on = ["aws_instance.docker_base"]

  triggers {
    instance = "${aws_instance.docker_base.id}"
  }

  connection {
    agent       = false
    host        = "${aws_instance.docker_base.public_ip}"
    private_key = "${file(var.pem_key)}"
    timeout     = "90s"
    user        = "ubuntu"
  }

  provisioner "file" {
    destination = "/home/ubuntu"
    source      = "/Users/edward/git/swarm-poc/docker/provision-files"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'remote-exec dependencies'",
      "bash /home/ubuntu/provision-files/base-dependencies.sh",
      "echo 'remote-exec base-docker'",
      "bash /home/ubuntu/provision-files/base-docker.sh",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'installing s3 volume driver'",
      "docker plugin install rexray/s3fs:latest S3FS_ACCESSKEY=${var.AWS_ACCESS_KEY_ID} S3FS_SECRETKEY=${var.AWS_SECRET_ACCESS_KEY} --grant-all-permissions",
      "docker volume ls",
      "echo 'remote-exec base-main'",
      "bash /home/ubuntu/provision-files/base-main.sh",
      "echo 'remote-exec cleanup'",
      "rm -rf /home/ubuntu/provision-files",
    ]
  }
}

/*
resource "null_resource" "dependencies" {
  depends_on = ["null_resource.docker_group"]

  triggers {
    instance = "${aws_instance.docker_base.id}"
  }

  connection {
    agent       = false
    host        = "${aws_eip.docker_base.public_ip}"
    private_key = "${file(var.pem_key)}"
    timeout     = "90s"
    user        = "ubuntu"
  }

  provisioner "file" {
    destination = "/home/ubuntu"
    source      = "/Users/edward/git/swarm-poc/docker/provision-files"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'remote-exec dependencies'",
      "echo ' > base-dependencies.sh'",
      "bash /home/ubuntu/provision-files/base-dependencies.sh",
      "echo ' > cleanup'",
      "rm -rf /home/ubuntu/provision-files",
    ]
  }
}
*/

resource "random_pet" "ec2_name" {
  separator = "_"
}

resource "random_pet" "ami_name" {
  depends_on = ["null_resource.dependencies"]

  keepers = {
    ami_id = "${aws_instance.docker_base.id}"
  }

  separator = "_"
  prefix    = "swarm_base"
}

resource "aws_ami_from_instance" "swarm_base" {
  depends_on = ["random_pet.ami_name"]

  name               = "${random_pet.ami_name.id}"
  source_instance_id = "${aws_instance.docker_base.id}"

  tags {
    "Name" = "swarm-base"
  }

  lifecycle {
    prevent_destroy = true
  }
}
