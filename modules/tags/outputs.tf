output "default_tags" {
  description = "Represents all the tags within the project"
  value       = local.default_tags
}

output "default_name" {
  description = "Represents the resource's parsed name"
  value       = local.default_name
}

output "default_vpc_sg_tags" {
  description = "Represents the resource's parsed name"
  value       = local.default_vpc_sg_tags
}

output "default_vpc_subnet_tags" {
  description = "Represents the resource's parsed name"
  value       = local.default_vpc_subnet_tags
}

output "default_vpc_rt_tags" {
  description = "Represents the resource's parsed name"
  value       = local.default_vpc_rt_tags
}
