#!/bin/bash
cd terraform
echo ${PWD}

terraform init -var-file=variables.tfvars
terraform get
terraform destroy -var-file=variables.tfvars -target=aws_instance.docker_host -force
terraform apply -var-file=variables.tfvars

#terraform destroy -var-file=variables.tfvars -force
#terraform destroy -var-file=variables.tfvars -force -target=null_resource.docker_deploy
#terraform destroy -var-file=variables.tfvars
