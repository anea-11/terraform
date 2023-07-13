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
