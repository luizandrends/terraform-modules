
locals {
  environment_map = {
    "dev" = "dev"
    "hml" = "hml"
    "prd" = "prd"
  }

  environment = var.environment != null ? lower(trimspace(var.environment)) : null
  application = lower(trimspace(var.application))
  team        = lower(trimspace(var.team))

  default_name = local.environment != null ? format("%s-%s", local.application, local.environment) : format("%s", local.application)

  name = var.name != null ? trimspace(var.name) : local.default_name

  tags_optional = {
    "Name" = local.name
  }

  tags_optional_normalized = local.tags_optional
  tags_optional_map        = local.environment != null ? merge({ "environment" = local.environment_map[local.environment] }, local.tags_optional_normalized) : local.tags_optional_normalized

  required_tags = {
    "Application" = local.application
    "Team"        = local.team
    "ManagedBy"   = "Terraform"
  }

  tags_without_name = merge(local.required_tags, var.custom_tags)


  tags = merge(local.tags_optional_map, local.required_tags, var.custom_tags)

  resource                  = trimspace(var.resource)
  cloudwatch_log_group_name = format("/aws/%s/%s/%s", local.environment, local.resource, local.name)
}
