data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "sqs_queue_default_policy" {

  dynamic "statement" {
    for_each = var.create ? [1] : []

    content {
      sid       = "default_http_transport_deny"
      actions   = ["sqs:ReceiveMessage", "sqs:SendMessage"]
      effect    = "Deny"
      resources = [aws_sqs_queue.this[0].arn]

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
      sid     = statement.value.sid
      effect  = statement.value.effect
      actions = statement.value.actions

      resources = ["arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]

      dynamic "principals" {
        for_each = statement.value.principals

        content {
          type        = principals.key
          identifiers = principals.value
        }
      }
    }
  }

  dynamic "statement" {
    for_each = length(keys(var.subscriptions)) > 0 ? [1] : []
    content {
      sid       = "sns-subscriptions"
      effect    = "Allow"
      actions   = ["sqs:SendMessage"]
      resources = [aws_sqs_queue.this[0].arn]

      principals {
        type        = "Service"
        identifiers = ["sns.amazonaws.com"]
      }

      dynamic "condition" {
        for_each = { for k, v in var.subscriptions : k => v }
        content {
          test     = "ArnEquals"
          variable = "aws:SourceArn"
          values   = [condition.value.topic_arn]
        }
      }
    }
  }
}
