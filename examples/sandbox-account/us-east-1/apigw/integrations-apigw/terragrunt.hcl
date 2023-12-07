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
  name = "default"

  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"
  api_version   = "2.0"

  default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 100
    throttling_rate_limit    = 100
  }

  lambda_integrations = {
    "POST /lambda-default-post-integration" = {
      lambda_arn             = ""
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }
  }

  lb_integrations = {
    "POST /loadbalancer-default-post-integration" = {
      lb_http_address        = ""
      payload_format_version = "1.0"
      timeout_milliseconds   = 12000
    }
  }
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate