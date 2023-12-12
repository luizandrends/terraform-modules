<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

| Name                                                                                         | Source                                                          | Version |
| -------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | ------- |
| <a name="module_private_subnet_tags"></a> [private_subnet_tags](#module_private_subnet_tags) | git@github.com:luizandrends/terraform-modules.git//modules/tags | v1.9.0  |
| <a name="module_public_subnet_tags"></a> [public_subnet_tags](#module_public_subnet_tags)    | git@github.com:luizandrends/terraform-modules.git//modules/tags | v1.9.0  |
| <a name="module_tags"></a> [tags](#module_tags)                                              | git@github.com:luizandrends/terraform-modules.git//modules/tags | v1.9.0  |

## Resources

| Name                                                                                                                                                          | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_default_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group)                         | resource    |
| [aws_eip.default_vpc_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip)                                                    | resource    |
| [aws_internet_gateway.vpc_default_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)             | resource    |
| [aws_nat_gateway.default_vpc_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)                                    | resource    |
| [aws_route.igw_route_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                             | resource    |
| [aws_route.nat_route_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                             | resource    |
| [aws_route_table.private_subnets_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                        | resource    |
| [aws_route_table.public_subnets_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                         | resource    |
| [aws_route_table_association.private_subnet_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource    |
| [aws_route_table_association.public_subnet_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)  | resource    |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                              | resource    |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                               | resource    |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                                               | resource    |
| [aws_vpc_endpoint.dynamodb_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)                                | resource    |
| [aws_vpc_endpoint.s3_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)                                      | resource    |
| [aws_vpc_endpoint.sns_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)                                     | resource    |
| [aws_vpc_endpoint.sqs_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)                                     | resource    |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                                   | data source |

## Inputs

| Name                                                                                                                        | Description                                                                                                                                             | Type                | Default         | Required |
| --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- | --------------- | :------: |
| <a name="input_additional_tags"></a> [additional_tags](#input_additional_tags)                                              | A map containing additional tags                                                                                                                        | `map(any)`          | `{}`            |    no    |
| <a name="input_application"></a> [application](#input_application)                                                          | The application that owns the resource                                                                                                                  | `string`            | n/a             |   yes    |
| <a name="input_cidr"></a> [cidr](#input_cidr)                                                                               | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id` | `string`            | `"10.0.0.0/16"` |    no    |
| <a name="input_create_vpc"></a> [create_vpc](#input_create_vpc)                                                             | Controls if VPC should be created (it affects almost all resources)                                                                                     | `bool`              | `true`          |    no    |
| <a name="input_default_security_group_egress"></a> [default_security_group_egress](#input_default_security_group_egress)    | List of maps of egress rules to set on the default security group                                                                                       | `list(map(string))` | `[]`            |    no    |
| <a name="input_default_security_group_ingress"></a> [default_security_group_ingress](#input_default_security_group_ingress) | List of maps of ingress rules to set on the default security group                                                                                      | `list(map(string))` | `[]`            |    no    |
| <a name="input_enable_dns_hostnames"></a> [enable_dns_hostnames](#input_enable_dns_hostnames)                               | Should be true to enable DNS hostnames in the VPC                                                                                                       | `bool`              | `true`          |    no    |
| <a name="input_enable_dns_support"></a> [enable_dns_support](#input_enable_dns_support)                                     | Should be true to enable DNS support in the VPC                                                                                                         | `bool`              | `true`          |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                                                          | The resource's environment                                                                                                                              | `string`            | n/a             |   yes    |
| <a name="input_instance_tenancy"></a> [instance_tenancy](#input_instance_tenancy)                                           | A tenancy option for instances launched into the VPC                                                                                                    | `string`            | `"default"`     |    no    |
| <a name="input_ipv4_netmask_length"></a> [ipv4_netmask_length](#input_ipv4_netmask_length)                                  | (Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4_ipam_pool_id                                | `number`            | `null`          |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                               | The name of the resource                                                                                                                                | `string`            | n/a             |   yes    |
| <a name="input_private_subnet_additional_tags"></a> [private_subnet_additional_tags](#input_private_subnet_additional_tags) | A map containing private subnet additional tags                                                                                                         | `map(any)`          | `{}`            |    no    |
| <a name="input_private_subnets"></a> [private_subnets](#input_private_subnets)                                              | List of maps of VPC's subnets to associate                                                                                                              | `list(map(string))` | `[]`            |    no    |
| <a name="input_public_subnet_additional_tags"></a> [public_subnet_additional_tags](#input_public_subnet_additional_tags)    | A map containing private subnet additional tags                                                                                                         | `map(any)`          | `{}`            |    no    |
| <a name="input_public_subnets"></a> [public_subnets](#input_public_subnets)                                                 | List of maps of VPC's subnets to associate                                                                                                              | `list(map(string))` | `[]`            |    no    |
| <a name="input_team"></a> [team](#input_team)                                                                               | The squad that owns the resource                                                                                                                        | `string`            | n/a             |   yes    |

## Outputs

| Name                                                                          | Description               |
| ----------------------------------------------------------------------------- | ------------------------- |
| <a name="output_vpc_arn"></a> [vpc_arn](#output_vpc_arn)                      | The ARN of the VPC        |
| <a name="output_vpc_cidr_block"></a> [vpc_cidr_block](#output_vpc_cidr_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id)                         | The ID of the VPC         |

<!-- END_TF_DOCS -->
