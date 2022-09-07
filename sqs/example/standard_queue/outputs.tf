output "id" {
  value       = module.sqs.*.id
  description = "SQS ID"
}

output "arn" {
  value       = module.sqs.*.arn
  description = "SQS ARN"
}

output "url" {
  value       = module.sqs.*.url
  description = "SQS URL"
}
