locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    aws_object = "lambda"
    application = "some-sandbox-lambda"
  }
}

terraform {
  source = "../../../../../dynamodb"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "local-secondary-index-table"

  hash_key                    = "id"
  range_key                   = "title"
  table_class                 = "STANDARD"
  deletion_protection_enabled = false

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "age"
      type = "N"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "GlobalTitleIndex"
      hash_key           = "title"
      range_key          = "age"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
    }
  ]

  local_secondary_indexes = [
    {
      name               = "LocalTitleIndex"
      range_key          = "age"
      projection_type    = "INCLUDE"
      non_key_attributes = ["Id"]
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate