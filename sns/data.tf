data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "sns_topic_default_policy" {
  dynamic "statement" {
    for_each = var.enable_default_topic_policy ? [1] : []

    content {
      sid = "__default_statement_ID"
      actions = [
        "sns:Subscribe",
        "sns:SetTopicAttributes",
        "sns:RemovePermission",
        "sns:Receive",
        "sns:Publish",
        "sns:ListSubscriptionsByTopic",
        "sns:GetTopicAttributes",
        "sns:DeleteTopic",
        "sns:AddPermission",
      ]
      effect    = "Allow"
      resources = ["arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.name}"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "StringEquals"
        values   = [data.aws_caller_identity.current.account_id]
        variable = "AWS:SourceOwner"
      }
    }
  }

  dynamic "statement" {
    for_each = var.create_topic ? [1] : []

    content {
      sid       = "default_http_transport_deny"
      actions   = ["sns:Publish"]
      effect    = "Deny"
      resources = ["arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.name}"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "Bool"
        variable = "aws:SecureTransport"
        values   = [false]
      }
    }
  }

  dynamic "statement" {
    for_each = var.policy

    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = ["arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${local.name}"]

      dynamic "principals" {
        for_each = statement.value.principals

        content {
          type        = principals.key
          identifiers = principals.value
        }
      }
    }
  }
}
