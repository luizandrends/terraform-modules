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
  source = "../../../../../sqs"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "sbscription-queue"

  create_dlq = true

  subscriptions = {
    first-sns-sub = {
      topic_arn = ""
      filter_policy = {
        "MyFilter1": ["value1"],
        "MyFilter2": ["value2"]
      }
      raw_message_delivery = false
    }

    second-sns-sub = {
      topic_arn = ""
      raw_message_delivery = false
    }
  }
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate