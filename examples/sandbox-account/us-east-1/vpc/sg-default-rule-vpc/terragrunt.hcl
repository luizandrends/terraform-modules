locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    aws_object = "lambda"
    application = "some-sandbox-lambda"
    additional_tags = {
      some-key = "some-value"
    }
  }
}

terraform {
  source = "../../../../../modules/vpc"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "sg-default-rule-vpc"

  cidr = "10.0.0.0/21"

  default_security_group_ingress = [
    {
      from_port   = "22",
      to_port     = "22",
      protocol    = "tcp",
      cidr_blocks = "163.116.224.117/32",
      description = "Allow ssh to my IP adress",
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate