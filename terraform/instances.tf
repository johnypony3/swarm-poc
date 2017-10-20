resource "aws_instance" "docker_host" {
  instance_type               = "${var.instance_type}"
  vpc_security_group_ids      = ["${aws_security_group.docker_host.id}"]
  ami                         = "${data.aws_ami.swarm_base.id}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${module.vpc.subnet_a_id}"
  associate_public_ip_address = true
  monitoring                  = false
  source_dest_check           = true
  iam_instance_profile        = "${aws_iam_instance_profile.iam_instance.name}"

  tags {
    "Name"    = "swarm_docker_host"
    "petname" = "${random_pet.ec2_name.id}"
  }
}

resource "null_resource" "docker_deploy" {
  depends_on = ["aws_instance.docker_host"]

  triggers {
    instance = "${aws_instance.docker_host.id}"
  }

  connection {
    agent       = false
    host        = "${aws_instance.docker_host.public_ip}"
    private_key = "${file(var.pem_key)}"
    timeout     = "90s"
    user        = "ubuntu"
  }

  provisioner "file" {
    destination = "./"
    source      = "../docker"
  }

  provisioner "remote-exec" {
    inline = [
      "echo remote-exec docker_deploy",
      "docker login -u ${var.DOCKER_HUB_USER} -p ${var.DOCKER_HUB_PASS}",
      "sudo docker plugin rm rexray/s3fs:latest --force",
      "docker plugin install rexray/s3fs:latest S3FS_ACCESSKEY=${var.AWS_ACCESS_KEY_ID} S3FS_SECRETKEY=${var.AWS_SECRET_ACCESS_KEY} --grant-all-permissions",
      "NONSUDO VOLUME CALL ***********************",
      "docker volume ls",
      "SUDO VOLUME CALL ***********************",
      "sudo docker volume ls",
      "docker-compose -f './docker/compose-files/${var.DOCKER_COMPOSE_FILE}' down",
      "docker-compose -f './docker/compose-files/${var.DOCKER_COMPOSE_FILE}' up --build -d",
      "sudo rm -rf ./docker",
    ]
  }
}

resource "random_pet" "ec2_name" {
  separator = "_"
}
