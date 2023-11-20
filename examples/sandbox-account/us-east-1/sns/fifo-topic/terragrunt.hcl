locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    application = "some-sandbox-lambda"
    additional_tags = {
      some-key = "some-value"
    }
  }
}

terraform {
  source = "../../../../../modules/sns"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "fifo-topic"

  fifo_topic = true
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate