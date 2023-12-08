data "aws_region" "current" {}

data "aws_iam_policy_document" "s3_bucket_default_policy" {
  dynamic "statement" {
    for_each = var.create ? [1] : []

    content {
      sid     = "default_http_transport_deny"
      actions = ["s3:*"]
      effect  = "Deny"
      resources = [
        aws_s3_bucket.this[0].arn,
        "${aws_s3_bucket.this[0].arn}/*"
      ]

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
      resources = [aws_s3_bucket.this.arn, "${aws_s3_bucket.this.arn}/*"]

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
