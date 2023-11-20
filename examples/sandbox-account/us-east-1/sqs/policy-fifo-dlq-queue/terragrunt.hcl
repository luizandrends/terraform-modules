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
  source = "../../../../../modules/sqs"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "policy-fifo-dlq-queue"
  create_dlq = true
  fifo_queue = true

  policy = [
    {
      "sid": "grant-lambda-fucntion-send-message",
      "effect": "Allow",
      "principals": {
        "AWS": [
          "arn:aws:iam::035267315123:role/service-role/alfred-lambda-terraform-role-7c99x1yj"
        ]
      },
      "actions": ["sqs:SendMessage"],
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate