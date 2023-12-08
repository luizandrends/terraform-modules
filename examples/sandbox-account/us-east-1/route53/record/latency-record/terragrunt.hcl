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
      name           = "latency-record"
      type           = "A"
      set_identifier = "latency-record"
      alias = {
        name                   = "",
        zone_id                = ""
        evaluate_target_health = true
      }
      latency_routing_policy = {
        region = "us-east-1"
      }
    }
  ]
}

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate