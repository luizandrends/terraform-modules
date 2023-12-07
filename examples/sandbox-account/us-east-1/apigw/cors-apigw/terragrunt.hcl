locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    application = "some-sandbox-lambda"
  }
}

terraform {
  source = "../../../../../modules/apigw"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "cors"

  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"
  api_version   = "2.0"

  default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 100
    throttling_rate_limit    = 100
  }

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate