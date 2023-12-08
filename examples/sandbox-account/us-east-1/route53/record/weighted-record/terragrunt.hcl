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
      name    = "weighted-record"
      type    = "CNAME"
      ttl     = 300
      set_identifier = "primary-record"
      weighted_routing_policy = {
        weight = 90
      }
      records = [
        "alfred-test.example.com."
      ]
    },
    {
      name    = "weighted-record"
      type    = "CNAME"
      ttl     = 300
      set_identifier = "secondary-record"
      weighted_routing_policy = {
        weight = 10
      }
      records = [
        "alfred-migration-test.example.com."
      ]
    }
  ]
}

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate