# Terraform automatically searches for a file namer terraform.tfvars for variable values
# If such a file doesn't exist, you must pass the filename to terraform apply command

# terraform apply -var-file terraform-staging.tfvars

# Use case: you want to replicate your infrastructure on dev, prod and staging environments, so you need different variables for each env.

dev-subnet-2-cidr-block = "172.31.64.0/20"