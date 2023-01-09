###
### RDS and Route53 Requirements
###

terraform {
  required_version = "~> 1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }

  // experiments = [
  //  module_variable_optional_attrs
  // ]
}