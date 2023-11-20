locals {
  create_vpc = var.create_vpc

  sg_default_egress_rules = [
    {
      from_port   = "0",
      to_port     = "0",
      protocol    = "all",
      cidr_blocks = "0.0.0.0/0",
      description = "Allow egress to all protocols in all ports",
    }
  ]

  sg_egress_rules = concat(local.sg_default_egress_rules, var.default_security_group_egress)
}

module "tags" {
  source = "git@github.com:luizandrends/terraform-modules.git//modules/tags?ref=v1.9.0"

  name            = var.name
  environment     = var.environment
  application     = var.application
  team            = var.team
  aws_object      = "vpc"
  additional_tags = var.additional_tags
}

module "private_subnet_tags" {
  source = "git@github.com:luizandrends/terraform-modules.git//modules/tags?ref=v1.9.0"

  name            = "${var.name}-private"
  environment     = var.environment
  application     = var.application
  team            = var.team
  aws_object      = "subnet"
  additional_tags = var.private_subnet_additional_tags
}

resource "aws_vpc" "this" {
  count = local.create_vpc ? 1 : 0

  cidr_block = var.cidr

  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = module.tags.default_tags
}

resource "aws_default_security_group" "this" {
  count = local.create_vpc ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  dynamic "ingress" {
    for_each = { for k, v in var.default_security_group_ingress : k => v }
    content {
      self             = lookup(ingress.value, "self", null)
      cidr_blocks      = compact(split(",", lookup(ingress.value, "cidr_blocks", "")))
      ipv6_cidr_blocks = compact(split(",", lookup(ingress.value, "ipv6_cidr_blocks", "")))
      prefix_list_ids  = compact(split(",", lookup(ingress.value, "prefix_list_ids", "")))
      security_groups  = compact(split(",", lookup(ingress.value, "security_groups", "")))
      description      = lookup(ingress.value, "description", null)
      from_port        = lookup(ingress.value, "from_port", 0)
      to_port          = lookup(ingress.value, "to_port", 0)
      protocol         = lookup(ingress.value, "protocol", "-1")
    }
  }

  dynamic "egress" {
    for_each = { for k, v in local.sg_egress_rules : k => v }
    content {
      self             = lookup(egress.value, "self", null)
      cidr_blocks      = compact(split(",", lookup(egress.value, "cidr_blocks", "")))
      ipv6_cidr_blocks = compact(split(",", lookup(egress.value, "ipv6_cidr_blocks", "")))
      prefix_list_ids  = compact(split(",", lookup(egress.value, "prefix_list_ids", "")))
      security_groups  = compact(split(",", lookup(egress.value, "security_groups", "")))
      description      = lookup(egress.value, "description", null)
      from_port        = lookup(egress.value, "from_port", 0)
      to_port          = lookup(egress.value, "to_port", 0)
      protocol         = lookup(egress.value, "protocol", "-1")
    }
  }

  tags = module.tags.default_vpc_sg_tags
}

resource "aws_subnet" "private_subnets" {
  for_each = { for k, v in var.private_subnets : k => v }

  vpc_id                  = aws_vpc.this[0].id
  map_public_ip_on_launch = false
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone

  tags = module.private_subnet_tags.default_vpc_subnet_tags
}

resource "aws_route_table" "private_subnets_route_table" {
  count = local.create_vpc && length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this[0].id

  tags = module.private_subnet_tags.default_vpc_rt_tags
}

resource "aws_route_table_association" "private_subnet_route_table" {
  for_each = { for k, v in var.private_subnets : k => v }

  subnet_id      = aws_subnet.private_subnets[each.key].id
  route_table_id = aws_route_table.private_subnets_route_table[0].id
}
