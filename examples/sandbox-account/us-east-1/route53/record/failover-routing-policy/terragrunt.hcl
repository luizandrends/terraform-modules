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
      name           = "failover-primary-record"
      type           = "A"
      set_identifier = "failover-primary"
      health_check_id = ""
      failover_routing_policy = {
        type = "PRIMARY"
      }
      alias   = {
        name    = "",
        zone_id = ""
      }
    },
    {
      name           = "failover-secondary-record"
      type           = "A"
      set_identifier = "failover-secondary"
      failover_routing_policy = {
        type = "SECONDARY"
      }
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