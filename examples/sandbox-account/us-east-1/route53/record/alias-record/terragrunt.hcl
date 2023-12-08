locals {
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
}

terraform {
  source = "../../../../../../modules/route53/record"
}

inputs = {
  zone_id   = ""

  recordsets = [
    {
      name    = "alias-record"
      type    = "A"
      alias   = {
        name    = "",
        zone_id = ""
      }
    }
  ]
}

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate