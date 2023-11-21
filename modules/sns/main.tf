locals {
  name = var.fifo_topic ? "${module.tags.default_name}.fifo" : "${module.tags.default_name}"
}

module "tags" {
  source = "git@github.com:luizandrends/terraform-modules.git//modules/tags?ref=v1.9.0"

  name            = var.name
  environment     = var.environment
  application     = var.application
  team            = var.team
  aws_object      = "sns"
  additional_tags = var.additional_tags
}

resource "aws_sns_topic" "this" {
  count = var.create_topic ? 1 : 0

  name = local.name

  content_based_deduplication = var.content_based_deduplication
  delivery_policy             = var.delivery_policy
  fifo_topic                  = var.fifo_topic
  tracing_config              = var.tracing_config
  policy                      = data.aws_iam_policy_document.sns_topic_default_policy.json

  kms_master_key_id = var.kms_master_key_id

  tags = module.tags.default_tags
}

resource "aws_lambda_permission" "allow_sns_subscription_on_lambda" {
  for_each = { for k, v in var.lambda_subscriptions : k => v if var.create_topic == true && length(var.lambda_subscriptions) > 0 }

  statement_id       = try(each.value.sid, null)
  function_name      = each.value.lambda_arn
  action             = "lambda:InvokeFunction"
  principal          = try(each.value.principal, "sns.amazonaws.com")
  source_arn         = aws_sns_topic.this[0].arn
  source_account     = try(each.value.source_account, null)
  event_source_token = try(each.value.event_source_token, null)
}

resource "aws_sns_topic_subscription" "lambda_subscriptions" {
  for_each = { for k, v in var.lambda_subscriptions : k => v if var.create_topic == true && length(var.lambda_subscriptions) > 0 }

  topic_arn = aws_sns_topic.this[0].arn
  protocol  = "lambda"
  endpoint  = each.value.lambda_arn
}
