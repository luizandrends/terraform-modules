locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    aws_object = "lambda"
    application = "some-sandbox-lambda"
    additional_tags = {
      services_vpc = true
    }
    private_subnet_additional_tags = {
      services_subnet = true
      private_subnet  = true
    }
  }
}

terraform {
  source = "../../../../../modules/vpc"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "snet-cfg-vpc"

  cidr = "10.0.0.0/24"

  private_subnets = [
    {
      cidr_block        = "10.0.0.0/26"
      availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.0.0.64/26"
      availability_zone = "us-east-1b"
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate