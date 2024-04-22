remote_state {
  backend = "s3"
  config = {
    bucket         = "tf-lib-tests-131328494269"
    key            = "tags-example/${path_relative_to_include()}"
    region         = "us-east-1"
    encrypt        = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

generate "versions" {
  path = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    terraform {
      required_version = "1.1.3"
      required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
      }
    }
  EOF
}