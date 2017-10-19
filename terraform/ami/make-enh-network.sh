#!/bin/bash
cd /Users/edward/git/swarm-poc/terraform/ami
echo ${PWD}

terraform destroy -force -var-file=../variables.tfvars
terraform apply -var-file=../variables.tfvars
#aws ec2 modify-instance-attribute --instance-id i-0662ee1bf50a6a040 --sriov-net-support simple
