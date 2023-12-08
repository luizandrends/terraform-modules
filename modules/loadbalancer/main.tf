locals {
  default_security_groups_rules = [
    {
      from_port   = "0",
      to_port     = "65535",
      protocol    = "all",
      cidr_block  = "0.0.0.0/0",
      type        = "egress",
      description = "Allow egress to all protocols in all ports",
    }
  ]

  security_group_rules = concat(local.default_security_groups_rules, var.sg_rules)
}

module "tags" {
  source = "git@github.com:luizandrends/terraform-modules.git//modules/tags?ref=v1.9.0"

  name            = var.name
  environment     = var.environment
  application     = var.application
  team            = var.team
  aws_object      = "lb"
  additional_tags = var.additional_tags
}

resource "aws_security_group" "default_security_group" {
  count = var.create ? 1 : 0

  vpc_id      = data.aws_vpc.services_vpc.id
  name        = "${var.name}-lb-default-sg"
  description = "SG for ${module.tags.default_name}"
  tags        = module.tags.default_tags
}

resource "aws_security_group_rule" "security_groups_rules" {
  for_each = { for k, v in local.security_group_rules : k => v }

  description       = each.value.description
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_block]
  security_group_id = aws_security_group.default_security_group[0].id
  type              = each.value.type

  depends_on = [aws_security_group.default_security_group]
}

resource "aws_lb" "this" {
  count = var.create ? 1 : 0

  name = module.tags.default_name
  tags = module.tags.default_tags

  dynamic "access_logs" {
    for_each = length(var.access_logs) > 0 ? [var.access_logs] : []

    content {
      bucket  = access_logs.value.bucket
      enabled = try(access_logs.value.enabled, true)
      prefix  = try(access_logs.value.prefix, null)
    }
  }

  customer_owned_ipv4_pool                    = var.customer_owned_ipv4_pool
  desync_mitigation_mode                      = var.desync_mitigation_mode
  dns_record_client_routing_policy            = var.dns_record_client_routing_policy
  drop_invalid_header_fields                  = var.drop_invalid_header_fields
  enable_cross_zone_load_balancing            = var.enable_cross_zone_load_balancing
  enable_deletion_protection                  = var.enable_deletion_protection
  enable_http2                                = var.enable_http2
  enable_tls_version_and_cipher_suite_headers = var.enable_tls_version_and_cipher_suite_headers
  enable_waf_fail_open                        = var.enable_waf_fail_open
  enable_xff_client_port                      = var.enable_xff_client_port
  idle_timeout                                = var.idle_timeout
  internal                                    = var.internal
  ip_address_type                             = var.ip_address_type
  load_balancer_type                          = var.load_balancer_type
  preserve_host_header                        = var.preserve_host_header

  security_groups = [aws_security_group.default_security_group[0].id]
  subnets         = data.aws_subnets.services_subnet.ids

  lifecycle {
    ignore_changes = [
      tags["elasticbeanstalk:shared-elb-environment-count"]
    ]
  }
}

resource "aws_lambda_permission" "allow_lb_subscription_on_lambda" {
  for_each = { for k, v in var.lambda_subscriptions : k => v if var.create == true && length(var.lambda_subscriptions) > 0 }

  statement_id       = try(each.value.sid, null)
  function_name      = each.value.lambda_arn
  action             = "lambda:InvokeFunction"
  principal          = "elasticloadbalancing.amazonaws.com"
  source_arn         = aws_lb_target_group.this[0].arn
  source_account     = try(each.value.source_account, null)
  event_source_token = try(each.value.event_source_token, null)
}

resource "aws_lb_target_group" "this" {
  for_each = { for k, v in var.lambda_subscriptions : k => v if var.create }

  name        = "${var.name}-lambda-tg-${each.key}"
  target_type = "lambda"
}

resource "aws_lb_target_group_attachment" "lambda_target_group_attachment" {
  for_each = { for k, v in var.lambda_subscriptions : k => v if var.create }

  target_group_arn = aws_lb_target_group.this[each.key].arn
  target_id        = each.value.lambda_arn

  depends_on = [aws_lambda_permission.allow_lb_subscription_on_lambda]
}

resource "aws_lb_listener" "lambda_lb_listner" {
  for_each = { for k, v in var.lambda_subscriptions : k => v if var.create }

  load_balancer_arn = aws_lb.this[0].arn

  port            = try(each.value.port, 80)
  protocol        = try(each.value.protocol, "HTTP")
  ssl_policy      = try(each.value.ssl_policy, null) #ELBSecurityPolicy-2016-08
  certificate_arn = try(each.value.certificate_arn, null)

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.key].arn
  }
}

