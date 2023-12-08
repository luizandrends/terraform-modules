locals {
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
}

terraform {
  source = "../../../../../../modules/route53/zone"
}

inputs =  {
  zones = {
    "default-zone.com" = {
      comment = "default-zone.com (sandbox env)"
      tags = {
        Name = "default-zone.com"
      }
    }
  }
}

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate