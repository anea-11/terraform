terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"    # official HashiCorp provider; listing it here is not required, but is a good practice
        version = "5.7.0"
      }

      linode = {
        source = "linode/linode"    # verified provider; listing it here is required
        version = "1.25.2"
      }
    }
}

/*
Useful Terraform commands
1.  terraform plan
    - preview: shows you the difference between current state and desired state (described in .tf files); similar to terrafor apply, but without actually applying
2. terraform apply
    - apply the current configuration (desired state) to the infrastructure
3. terraform destroy (without specifying any specific resource)
    - destroys everything that's defined in .tf files
*/
