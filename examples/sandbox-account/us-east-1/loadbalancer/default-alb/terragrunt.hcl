locals {
  default_tags = read_terragrunt_config(find_in_parent_folders("default-tags.hcl"))
  providers = read_terragrunt_config(find_in_parent_folders("providers.hcl"))
  application_tags = {
    application = "some-sandbox-lambda"
  }
}

terraform {
  source = "../../../../../modules/loadbalancer"
}

inputs = merge(local.default_tags.locals.default_tags, local.application_tags, {
  name = "default-alb"

  load_balancer_type         = "application"
  enable_deletion_protection = false

  sg_rules = [
    {
      from_port   = "0",
      to_port     = "65535",
      protocol    = "all",
      cidr_block  = "163.116.228.116/32",
      type        = "ingress",
      description = "Allow ingress to all protocols in all ports",
    }
  ]


  lambda_subscriptions = [
    {
      sid        = "allowlbaccess"
      lambda_arn = "arn:aws:lambda:us-east-1:035267315123:function:aws-lambda-custom-net-function-use1-dev"
      port       = "80"
      protocol   = "HTTP"
    },
  ]
})

include {
  path = find_in_parent_folders()
}

generate = local.providers.generate