output "id" {
  value       = aws_sqs_queue.main.*.id
  description = "SQS ID"
}

output "arn" {
  value       = aws_sqs_queue.main.*.arn
  description = "SQS ARN"
}

output "url" {
  value       = aws_sqs_queue.main.*.url
  description = "SQS URL"
}
