resource "aws_secretsmanager_secret" "secret" {
  name        = var.name
  description = var.description

  recovery_window_in_days = var.recovery_window_in_days

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "version" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = var.secret_string
}

resource "aws_secretsmanager_secret_policy" "policy" {
  count      = var.policy != null ? 1 : 0
  secret_arn = aws_secretsmanager_secret.secret.arn
  policy     = var.policy
}
