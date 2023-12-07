locals {
  integrations = merge(var.lambda_integrations, var.lb_integrations)
}

module "tags" {
  source = "git@github.com:luizandrends/terraform-modules.git//modules/tags?ref=v1.9.0"

  name            = var.name
  environment     = var.environment
  application     = var.application
  team            = var.team
  aws_object      = "apigw"
  additional_tags = var.additional_tags
}

resource "aws_apigatewayv2_api" "this" {
  count = var.create ? 1 : 0

  name          = module.tags.default_name
  description   = var.description
  protocol_type = var.protocol_type
  version       = var.api_version
  body          = var.body

  route_selection_expression   = var.route_selection_expression
  api_key_selection_expression = var.api_key_selection_expression
  disable_execute_api_endpoint = var.disable_execute_api_endpoint

  /*Quick Create*/
  route_key       = var.route_key
  credentials_arn = var.credentials_arn
  target          = var.target

  dynamic "cors_configuration" {
    for_each = length(keys(var.cors_configuration)) == 0 ? [] : [var.cors_configuration]

    content {
      allow_credentials = try(cors_configuration.value.allow_credentials, null)
      allow_headers     = try(cors_configuration.value.allow_headers, null)
      allow_methods     = try(cors_configuration.value.allow_methods, null)
      allow_origins     = try(cors_configuration.value.allow_origins, null)
      expose_headers    = try(cors_configuration.value.expose_headers, null)
      max_age           = try(cors_configuration.value.max_age, null)
    }
  }

  tags = module.tags.default_tags
}

resource "aws_apigatewayv2_domain_name" "this" {
  count = var.create && var.domain_name != null ? 1 : 0

  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn                        = var.domain_name_certificate_arn
    ownership_verification_certificate_arn = var.domain_name_ownership_verification_certificate_arn
    endpoint_type                          = "REGIONAL"
    security_policy                        = "TLS_1_2"
  }

  dynamic "mutual_tls_authentication" {
    for_each = length(keys(var.mutual_tls_authentication)) == 0 ? [] : [var.mutual_tls_authentication]

    content {
      truststore_uri     = mutual_tls_authentication.value.truststore_uri
      truststore_version = try(mutual_tls_authentication.value.truststore_version, null)
    }
  }

  tags = module.tags.default_tags
}

resource "aws_apigatewayv2_stage" "default" {
  count = var.create ? 1 : 0

  api_id      = aws_apigatewayv2_api.this[0].id
  name        = "$default"
  auto_deploy = true

  dynamic "access_log_settings" {
    for_each = var.default_stage_access_log_destination_arn != null && var.default_stage_access_log_format != null ? [true] : []

    content {
      destination_arn = var.default_stage_access_log_destination_arn
      format          = var.default_stage_access_log_format
    }
  }

  dynamic "default_route_settings" {
    for_each = length(keys(var.default_route_settings)) == 0 ? [] : [var.default_route_settings]

    content {
      data_trace_enabled = try(default_route_settings.value.data_trace_enabled, false) # supported in Websocket APIGateway only
      logging_level      = try(default_route_settings.value.logging_level, null)       # supported in Websocket APIGateway only

      detailed_metrics_enabled = try(default_route_settings.value.detailed_metrics_enabled, false)
      throttling_burst_limit   = try(default_route_settings.value.throttling_burst_limit, null)
      throttling_rate_limit    = try(default_route_settings.value.throttling_rate_limit, null)
    }
  }

  dynamic "route_settings" {
    for_each = { for k, v in local.integrations : k => v if length(keys(local.integrations)) > 0 && length(setintersection(["data_trace_enabled", "detailed_metrics_enabled", "logging_level", "throttling_burst_limit", "throttling_rate_limit"], keys(v))) > 0 }

    content {
      route_key          = route_settings.key
      data_trace_enabled = try(route_settings.value.data_trace_enabled, var.default_route_settings["data_trace_enabled"], false) # supported in Websocket APIGateway only
      logging_level      = try(route_settings.value.logging_level, var.default_route_settings["logging_level"], null)            # supported in Websocket APIGateway only

      detailed_metrics_enabled = try(route_settings.value.detailed_metrics_enabled, var.default_route_settings["detailed_metrics_enabled"], false)
      throttling_burst_limit   = try(route_settings.value.throttling_burst_limit, var.default_route_settings["throttling_burst_limit"], null)
      throttling_rate_limit    = try(route_settings.value.throttling_rate_limit, var.default_route_settings["throttling_rate_limit"], null)
    }
  }

  # Bug in terraform-aws-provider with perpetual diff
  lifecycle {
    ignore_changes = [deployment_id]
  }

  tags = module.tags.default_tags
}

resource "aws_apigatewayv2_api_mapping" "this" {
  count = var.create && var.domain_name != null ? 1 : 0

  api_id      = aws_apigatewayv2_api.this[0].id
  domain_name = aws_apigatewayv2_domain_name.this[0].id
  stage       = aws_apigatewayv2_stage.default[0].id
}

resource "aws_apigatewayv2_route" "lambda_routes" {
  for_each = var.create && length(keys(var.lambda_integrations)) > 0 ? var.lambda_integrations : {}

  api_id    = aws_apigatewayv2_api.this[0].id
  route_key = each.key

  api_key_required                    = try(each.value.api_key_required, null)
  authorization_scopes                = try(split(",", each.value.authorization_scopes), null)
  authorization_type                  = try(each.value.authorization_type, "NONE")
  model_selection_expression          = try(each.value.model_selection_expression, null)
  operation_name                      = try(each.value.operation_name, null)
  route_response_selection_expression = try(each.value.route_response_selection_expression, null)
  target                              = "integrations/${aws_apigatewayv2_integration.lambda_integrations[each.key].id}"
}

resource "aws_apigatewayv2_route" "lb_routes" {
  for_each = var.create && length(keys(var.lb_integrations)) > 0 ? var.lb_integrations : {}

  api_id    = aws_apigatewayv2_api.this[0].id
  route_key = each.key

  api_key_required                    = try(each.value.api_key_required, null)
  authorization_scopes                = try(split(",", each.value.authorization_scopes), null)
  authorization_type                  = try(each.value.authorization_type, "NONE")
  model_selection_expression          = try(each.value.model_selection_expression, null)
  operation_name                      = try(each.value.operation_name, null)
  route_response_selection_expression = try(each.value.route_response_selection_expression, null)
  target                              = "integrations/${aws_apigatewayv2_integration.lb_integrations[each.key].id}"
}

resource "aws_apigatewayv2_integration" "lambda_integrations" {
  for_each = var.create && length(keys(var.lambda_integrations)) > 0 ? var.lambda_integrations : {}

  api_id              = aws_apigatewayv2_api.this[0].id
  description         = try(each.value.description, null)
  integration_type    = "AWS_PROXY"
  integration_subtype = try(each.value.integration_subtype, null)
  integration_method  = try(each.value.integration_method, try(each.value.integration_subtype, null) == null ? "POST" : null)
  integration_uri     = try(each.value.lambda_arn, try(each.value.integration_uri, null))

  connection_type = try(each.value.connection_type, "INTERNET")

  payload_format_version    = try(each.value.payload_format_version, null)
  timeout_milliseconds      = try(each.value.timeout_milliseconds, null)
  passthrough_behavior      = try(each.value.passthrough_behavior, null)
  content_handling_strategy = try(each.value.content_handling_strategy, null)
  credentials_arn           = try(each.value.credentials_arn, null)
  request_parameters        = try(jsondecode(each.value["request_parameters"]), each.value["request_parameters"], null)
}

resource "aws_lambda_permission" "allow_api_gw_trigger" {
  for_each = var.create && length(keys(var.lambda_integrations)) > 0 ? var.lambda_integrations : {}

  statement_id  = "AllowExecutionFromApiGw"
  action        = "lambda:InvokeFunction"
  function_name = each.value.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this[0].execution_arn}/*"
}

resource "aws_apigatewayv2_integration" "lb_integrations" {
  for_each = var.create && length(keys(var.lb_integrations)) > 0 ? var.lb_integrations : {}

  api_id              = aws_apigatewayv2_api.this[0].id
  description         = try(each.value.description, null)
  integration_type    = "HTTP_PROXY"
  integration_subtype = try(each.value.integration_subtype, null)
  integration_method  = try(each.value.integration_method, try(each.value.integration_subtype, null) == null ? "POST" : null)
  integration_uri     = try(each.value.lb_http_address, try(each.value.integration_uri, null))

  connection_type = try(each.value.connection_type, "INTERNET")

  payload_format_version    = try(each.value.payload_format_version, null)
  timeout_milliseconds      = try(each.value.timeout_milliseconds, null)
  passthrough_behavior      = try(each.value.passthrough_behavior, null)
  content_handling_strategy = try(each.value.content_handling_strategy, null)
  credentials_arn           = try(each.value.credentials_arn, null)
  request_parameters        = try(jsondecode(each.value["request_parameters"]), each.value["request_parameters"], null)
}
