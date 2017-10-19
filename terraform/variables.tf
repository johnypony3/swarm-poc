variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "az_a" {
  description = "Availability zone A"
}

variable "az_b" {
  description = "Availability zone B"
}

variable "key_name" {}
variable "instance_type" {}
variable "pem_key" {}
variable "terraform_bucket_name" {}
variable "docker_data_bucket_name" {}
variable "DOCKER_HUB_USER" {}
variable "DOCKER_HUB_PASS" {}
