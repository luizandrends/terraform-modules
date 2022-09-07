output "id" {
  value       = module.secret.id
  description = "Secret ID."
}

output "arn" {
  value       = module.secret.*.arn
  description = "Secret ARN"
}
