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
  name = "domain."

  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"
  api_version   = "2.0"

  default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 100
    throttling_rate_limit    = 100
  }

  domain_name = "domain.observability.ppay.me"
  domain_name_certificate_arn = "arn:aws:acm:us-east-1:035267315123:certificate/80854eee-fdf1-46db-9e8a-1942f0c3d218"

  # mutual_tls_authentication = {
  #   truststore_uri     = ""
  #   truststore_version = 
  # }

})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate