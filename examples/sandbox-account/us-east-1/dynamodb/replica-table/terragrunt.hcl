locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    application = "some-sandbox-lambda"
  }
}

terraform {
  source = "../../../../../modules/dynamodb"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "replica-table"

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
      name               = "TitleIndex"
      hash_key           = "title"
      range_key          = "age"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
    }
  ]

  replica_regions = [
    {
      region_name            = "sa-east-1"
      propagate_tags         = true
      point_in_time_recovery = true
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate