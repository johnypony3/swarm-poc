#!/bin/bash
cd /Users/edward/git/swarm-poc/terraform/ami
echo ${PWD}
terraform destroy -force -var-file=../variables.tfvars
terraform apply -var-file=../variables.tfvars
terraform state rm aws_ami_from_instance.swarm_base
terraform destroy -force -var-file=../variables.tfvars
