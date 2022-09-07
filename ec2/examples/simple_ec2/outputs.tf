output "id" {
  value       = module.ec2_instance.id
  description = "Instance ID"
}

output "arn" {
  value       = module.ec2_instance.*.arn
  description = "Instance ARN"
}

output "public_ip" {
  value       = module.ec2_instance.*.public_ip
  description = "Instance public IP"
}

output "private_ip" {
  value       = module.ec2_instance.*.private_ip
  description = "Instance private IP"
}

output "public_key" {
  value       = module.ec2_instance.*.public_key
  description = "Instance private IP"
  sensitive   = true
}
