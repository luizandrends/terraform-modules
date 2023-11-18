locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    aws_object = "lambda"
    application = "some-sandbox-lambda"
  }
}

terraform {
  source = "../../../../../tags"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "sandbox"
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate