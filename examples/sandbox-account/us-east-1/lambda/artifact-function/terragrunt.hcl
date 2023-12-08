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
  name = "artifact-function"

  handler     = "lambda_code/lambda_function.handler"
  memory_size = 128
  runtime     = "nodejs18.x"
  timeout     = 15

  vpc_security_group_ids = ["sg-00aa02465bc1b922d"]
  vpc_subnet_ids         = ["subnet-0a947f9c45703738a", "subnet-0f2769a8c44871b1b"]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate