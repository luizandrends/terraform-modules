output "id" {
  value       = aws_secretsmanager_secret.secret.id
  description = "Secret ID."
}

output "arn" {
  value       = aws_secretsmanager_secret.secret.arn
  description = "Secret ARN."
}
