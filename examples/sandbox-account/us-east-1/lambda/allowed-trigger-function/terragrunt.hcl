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

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "allowed-trigger-function"

  handler     = "index.js"
  memory_size = 128
  runtime     = "nodejs18.x"
  timeout     = 15
  filename    = "./lambda-code.zip"

  triggers = [
    {
      sid        = "AllowS3Invoke"
      source_arn = "arn:aws:s3:::s3-trigger-test-035267315123"
      principal  = "s3"
    },
    {
      sid        = "AllowSNSInvoke"
      source_arn = "arn:aws:sns:us-east-1:035267315123:alfred-sns-terraform"
      principal  = "sns"
    },
    {
      sid        = "AllowSQSInvoke"
      source_arn = "arn:aws:sqs:us-east-1:035267315123:alfred-sqs-terraform"
      principal  = "sqs"
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate