output "id" {
  value       = aws_instance.main.*.id
  description = "The id of the instance"
}

output "arn" {
  value       = aws_instance.main.*.arn
  description = "The arn of the instance"
}

output "public_ip" {
  value = aws_instance.main.*.public_ip
}

output "private_ip" {
  value = aws_instance.main.*.private_ip
}

output "public_key" {
  value       = aws_key_pair.generated_key.*.public_key
  description = "Instance private IP"
}

output "key_name" {
  value       = aws_key_pair.generated_key.*.key_name
  description = "Instance private IP"
}
