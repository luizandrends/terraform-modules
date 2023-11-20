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
  source = "../../../../../modules/sns"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "policy-topic"

  policy = [
    {
      "sid": "grant-lambda-fucntion-push",
      "effect": "Allow",
      "principals": {
        "AWS": [
          "arn:aws:iam::accountid:role/role-name"
        ]
      },
      "actions": ["sns:Publish"],
    }
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate