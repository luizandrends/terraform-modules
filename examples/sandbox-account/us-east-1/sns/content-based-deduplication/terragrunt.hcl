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
  source = "../../../../../sns"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "deduplication-topic"
  
  fifo_topic                  = true
  content_based_deduplication = true
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate