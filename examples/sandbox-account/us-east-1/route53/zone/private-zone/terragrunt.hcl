locals {
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
}

terraform {
  source = "../../../../../../modules/route53/zone"
}

inputs =  {
  zones = {
    "private-zone.com" = {
      comment = "private-zone.com (sandbox env)"
      vpc = [
        {
          vpc_id = ""
        }
      ]
      tags = {
        Name = "private-zone.com"
      }
    }
  }
}

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate