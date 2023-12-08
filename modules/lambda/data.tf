data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "default_lambda_role" {
  dynamic "statement" {
    for_each = var.create ? [1] : []

    content {
      sid     = "LambdaRole"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]
      principals {
        type        = "Service"
        identifiers = ["lambda.amazonaws.com"]
      }
    }
  }
}

data "aws_iam_policy_document" "default_lambda_policy" {
  dynamic "statement" {
    for_each = var.create && var.enable_xray_tracing ? [1] : []

    content {
      sid       = "DefaultXrayTracingPolicy"
      effect    = "Allow"
      actions   = ["xray:PutTraceSegments", "xray:PutTelemetryRecords"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.create ? [1] : []

    content {
      sid       = "DefaultVpcPolicy"
      effect    = "Allow"
      actions   = ["ec2:CreateNetworkInterface", "ec2:DescribeNetworkInterfaces", "ec2:DeleteNetworkInterface"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.create ? [1] : []

    content {
      sid       = "AllowCreateCloudWatchLogGroup"
      effect    = "Allow"
      actions   = ["logs:CreateLogGroup"]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.create ? [1] : []
    content {
      sid     = "AllowCloudWatchUsage"
      effect  = "Allow"
      actions = ["logs:CreateLogStream", "logs:PutLogEvents"]
      resources = [
        "arn:aws:logs:*:*:log-group:*${module.tags.default_name}*:log-stream:*",
        "arn:aws:logs:*:*:log-group:*${module.tags.default_name}*"
      ]
    }
  }
}

data "aws_iam_policy_document" "lambda_managed_policies" {

  dynamic "statement" {
    for_each = { for k, v in var.policy : k => v if var.create == true && length(var.policy) > 0 }

    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}

data "aws_vpc" "services_vpc" {
  tags = {
    services_vpc = "true"
  }
}

data "aws_subnets" "services_subnet" {
  filter {
    name   = "tag:services_subnet"
    values = ["true"]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}

