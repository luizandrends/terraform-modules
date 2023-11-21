module "tags" {
  source = "git@github.com:luizandrends/terraform-modules.git//modules/tags?ref=v1.9.0"

  name            = var.name
  environment     = var.environment
  application     = var.application
  team            = var.team
  aws_object      = "lambda"
  additional_tags = var.additional_tags
}

resource "aws_iam_policy" "lambda_default_policy" {
  count = var.create ? 1 : 0

  name        = "${module.tags.default_name}-lambda-policy"
  description = "General policy for ${module.tags.default_name}"
  path        = "/"

  policy = data.aws_iam_policy_document.default_lambda_policy.json

  tags = module.tags.default_tags
}

resource "aws_iam_policy" "lambda_managed_policy" {
  count = var.create && length(var.policy) > 0 ? 1 : 0

  name        = "${module.tags.default_name}-lambda-managed-policy"
  description = "Managed policy for ${module.tags.default_name}"
  path        = "/"

  policy = data.aws_iam_policy_document.lambda_managed_policies.json

  tags = module.tags.default_tags
}

resource "aws_iam_role" "lambda_default_role" {
  count = var.create ? 1 : 0

  name        = "${module.tags.default_name}-lambda-role"
  description = "General role for ${module.tags.default_name}"
  path        = "/"

  assume_role_policy = data.aws_iam_policy_document.default_lambda_role.json

  tags = module.tags.default_tags

  depends_on = [aws_iam_policy.lambda_default_policy]
}

resource "aws_iam_role_policy_attachment" "lambda_default_role_policy_attachment" {
  count = var.create ? 1 : 0

  role       = aws_iam_role.lambda_default_role[0].name
  policy_arn = aws_iam_policy.lambda_default_policy[0].arn

  depends_on = [aws_iam_policy.lambda_default_policy, aws_iam_role.lambda_default_role]
}

resource "aws_iam_role_policy_attachment" "lambda_managed_role_policy_attachment" {
  count = var.create && length(var.policy) > 0 ? 1 : 0

  role       = aws_iam_role.lambda_default_role[0].name
  policy_arn = aws_iam_policy.lambda_managed_policy[0].arn

  depends_on = [aws_iam_policy.lambda_managed_policy, aws_iam_role.lambda_default_role]
}

resource "aws_lambda_function" "this" {
  count = var.create ? 1 : 0

  function_name                  = module.tags.default_name
  role                           = aws_iam_role.lambda_default_role[0].arn
  handler                        = var.handler
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  runtime                        = var.runtime
  reserved_concurrent_executions = var.reserved_concurrent_executions
  filename                       = var.filename

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []

    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

  tags = module.tags.default_tags
}

resource "aws_cloudwatch_log_group" "lambda_fuction_cw_log_group" {
  count = var.create ? 1 : 0

  name              = "/aws/lambda/${module.tags.default_name}"
  retention_in_days = var.cloudwatch_logs_retention_in_days
  kms_key_id        = var.cloudwatch_logs_kms_key_id
}

resource "aws_lambda_permission" "lambda_permissions" {
  for_each = { for k, v in var.lambda_permissions : k => v if length(var.lambda_permissions) > 0 && var.create == true }

  function_name = aws_lambda_function.this[0].arn

  statement_id       = try(each.value.statement_id, null)
  action             = "lambda:InvokeFunction"
  principal          = try("${each.value.principal}.amazonaws.com", "*.amazonaws.com")
  principal_org_id   = try(each.value.principal_org_id, null)
  source_arn         = try(each.value.source_arn, null)
  source_account     = try(each.value.source_account, null)
  event_source_token = try(each.value.event_source_token, null)
}

resource "aws_lambda_event_source_mapping" "event_source_list" {
  for_each = { for k, v in var.event_source_list : k => v if length(var.event_source_list) > 0 && var.create == true }

  function_name = aws_lambda_function.this[0].arn

  event_source_arn = each.value.source_arn
  enabled          = try(each.value.enabled, true)
  batch_size       = try(each.value.batch_size, 10)
}
