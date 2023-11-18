locals {
  name = var.fifo_topic ? "${module.tags.default_name}.fifo" : "${module.tags.default_name}"
}

module "tags" {
  source = "git@github.com:luizandrends/terraform-modules.git//tags?ref=v1.2.0"

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
