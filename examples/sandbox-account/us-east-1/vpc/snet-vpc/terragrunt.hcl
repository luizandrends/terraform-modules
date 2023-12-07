locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    application = "some-sandbox-lambda"
    additional_tags = {
      services_vpc = true
    }
    private_subnet_additional_tags = {
      services_subnet = true
      private_subnet  = true
    }
    public_subnet_additional_tags = {
      services_subnet = false
      private_subnet  = false
    }
  }
}

terraform {
  source = "../../../../../modules/vpc"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "default"

  cidr = "10.0.0.0/16"

  private_subnets = [
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
    },
    {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1c"
    }
  ]

  public_subnets = [
    {
      cidr_block        = "10.0.101.0/24"
      availability_zone = "us-east-1a"
    },
    {
      cidr_block        = "10.0.102.0/24"
      availability_zone = "us-east-1b"
    },
    {
      cidr_block        = "10.0.103.0/24"
      availability_zone = "us-east-1c"
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate