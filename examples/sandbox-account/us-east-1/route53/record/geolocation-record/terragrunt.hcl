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
      name           = "geolocation-record"
      type           = "CNAME"
      ttl            = 300
      set_identifier = "geolocation-europe-record"
      records = [
        "europe.test.example.com."
      ]
      geolocation_routing_policy = {
        continent = "EU"
      }
    }
  ]
}

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate