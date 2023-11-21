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
  source = "../../../../../modules/lambda"
}

dependency "sqs_default_queue" {
  config_path = "../../sqs/default-queue"
}

dependency "sns_default_topic" {
  config_path = "../../sns/default-topic"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "policy-function"

  handler     = "index.js"
  memory_size = 128
  runtime     = "nodejs18.x"
  timeout     = 15
  filename    = "./lambda-code.zip"

  lambda_permissions = [
    {
      sid        = "AllowSNSInvokeFunction"
      principal  = "sns"
      source_arn = dependency.sns_default_topic.outputs.topic_arn
    }
  ]

  event_source_list = [
    {
      source_arn = dependency.sqs_default_queue.outputs.queue_arn
      enabled    = true
      batch_size = 1
    }
  ]

  policy = [
    {
      "sid": "AllowSQSReceiveMessage"
      "effect": "Allow"
      "actions": ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
      "resources": [dependency.sqs_default_queue.outputs.queue_arn]
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate