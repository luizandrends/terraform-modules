data "aws_route53_zone" "this" {
  count   = var.create && var.zone_id != null ? 1 : 0
  zone_id = var.zone_id
}

resource "aws_route53_record" "this" {
  provider        = aws.org_main_account_provider
  zone_id         = data.aws_route53_zone.this[0].zone_id
  for_each        = { for k, v in var.recordsets : k => v if var.create }
  name            = lookup(each.value, "name", null)
  type            = lookup(each.value, "type", null)
  ttl             = lookup(each.value, "ttl", null)
  health_check_id = lookup(each.value, "health_check_id", null)
  records         = try(each.value.records, null)
  set_identifier  = lookup(each.value, "set_identifier", null)

  dynamic "weighted_routing_policy" {
    for_each = length(keys(lookup(each.value, "weighted_routing_policy", {}))) == 0 ? [] : [true]

    content {
      weight = each.value.weighted_routing_policy.weight
    }
  }

  dynamic "alias" {
    for_each = length(keys(lookup(each.value, "alias", {}))) == 0 ? [] : [true]

    content {
      name                   = each.value.alias.name
      zone_id                = try(each.value.alias.zone_id, data.aws_route53_zone.this[0].zone_id)
      evaluate_target_health = lookup(each.value.alias, "evaluate_target_health", false)
    }
  }

  dynamic "failover_routing_policy" {
    for_each = length(keys(lookup(each.value, "failover_routing_policy", {}))) == 0 ? [] : [true]

    content {
      type = each.value.failover_routing_policy.type
    }
  }

  dynamic "latency_routing_policy" {
    for_each = length(keys(lookup(each.value, "latency_routing_policy", {}))) == 0 ? [] : [true]

    content {
      region = each.value.latency_routing_policy.region
    }
  }

  dynamic "geolocation_routing_policy" {
    for_each = length(keys(lookup(each.value, "geolocation_routing_policy", {}))) == 0 ? [] : [true]

    content {
      continent   = lookup(each.value.geolocation_routing_policy, "continent", null)
      country     = lookup(each.value.geolocation_routing_policy, "country", null)
      subdivision = lookup(each.value.geolocation_routing_policy, "subdivision", null)
    }
  }
}
