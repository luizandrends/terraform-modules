## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

| Name                                            | Source                                                  | Version |
| ----------------------------------------------- | ------------------------------------------------------- | ------- |
| <a name="module_tags"></a> [tags](#module_tags) | git@github.com:luizandrends/terraform-modules.git//tags | v1.5.0  |

## Resources

| Name                                                                                                                  | Type     |
| --------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name                                                                                                                                    | Description                                                                                                                                                                                                                                                                                  | Type                | Default                                                                         | Required |
| --------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- | ------------------------------------------------------------------------------- | :------: |
| <a name="input_additional_tags"></a> [additional_tags](#input_additional_tags)                                                          | A map containing additional tags                                                                                                                                                                                                                                                             | `map(any)`          | `{}`                                                                            |    no    |
| <a name="input_application"></a> [application](#input_application)                                                                      | The application that owns the resource                                                                                                                                                                                                                                                       | `string`            | n/a                                                                             |   yes    |
| <a name="input_attributes"></a> [attributes](#input_attributes)                                                                         | List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute, type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data | `list(map(string))` | `[]`                                                                            |    no    |
| <a name="input_autoscaling_enabled"></a> [autoscaling_enabled](#input_autoscaling_enabled)                                              | Whether or not to enable autoscaling. See note in README about this setting                                                                                                                                                                                                                  | `bool`              | `false`                                                                         |    no    |
| <a name="input_aws_object"></a> [aws_object](#input_aws_object)                                                                         | he resource identifier, ex: ec2, s3, rds, etc...                                                                                                                                                                                                                                             | `string`            | n/a                                                                             |   yes    |
| <a name="input_billing_mode"></a> [billing_mode](#input_billing_mode)                                                                   | Controls how you are billed for read/write throughput and how you manage capacity. The valid values are PROVISIONED or PAY_PER_REQUEST                                                                                                                                                       | `string`            | `"PAY_PER_REQUEST"`                                                             |    no    |
| <a name="input_create_table"></a> [create_table](#input_create_table)                                                                   | Controls if DynamoDB table and associated resources are created                                                                                                                                                                                                                              | `bool`              | `true`                                                                          |    no    |
| <a name="input_deletion_protection_enabled"></a> [deletion_protection_enabled](#input_deletion_protection_enabled)                      | Enables deletion protection for table                                                                                                                                                                                                                                                        | `bool`              | `true`                                                                          |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                                                                      | The resource's environment                                                                                                                                                                                                                                                                   | `string`            | n/a                                                                             |   yes    |
| <a name="input_global_secondary_indexes"></a> [global_secondary_indexes](#input_global_secondary_indexes)                               | Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc.                                                                                                                                                                                 | `any`               | `[]`                                                                            |    no    |
| <a name="input_hash_key"></a> [hash_key](#input_hash_key)                                                                               | The attribute to use as the hash (partition) key. Must also be defined as an attribute                                                                                                                                                                                                       | `string`            | `null`                                                                          |    no    |
| <a name="input_import_table"></a> [import_table](#input_import_table)                                                                   | Configurations for importing s3 data into a new table.                                                                                                                                                                                                                                       | `any`               | `{}`                                                                            |    no    |
| <a name="input_local_secondary_indexes"></a> [local_secondary_indexes](#input_local_secondary_indexes)                                  | Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource.                                                                                                                                              | `any`               | `[]`                                                                            |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                                           | The name of the resource                                                                                                                                                                                                                                                                     | `string`            | n/a                                                                             |   yes    |
| <a name="input_point_in_time_recovery_enabled"></a> [point_in_time_recovery_enabled](#input_point_in_time_recovery_enabled)             | Whether to enable point-in-time recovery                                                                                                                                                                                                                                                     | `bool`              | `false`                                                                         |    no    |
| <a name="input_range_key"></a> [range_key](#input_range_key)                                                                            | The attribute to use as the range (sort) key. Must also be defined as an attribute                                                                                                                                                                                                           | `string`            | `null`                                                                          |    no    |
| <a name="input_read_capacity"></a> [read_capacity](#input_read_capacity)                                                                | The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0                                                                                                                                                                             | `number`            | `null`                                                                          |    no    |
| <a name="input_replica_regions"></a> [replica_regions](#input_replica_regions)                                                          | Region names for creating replicas for a global DynamoDB table.                                                                                                                                                                                                                              | `any`               | `[]`                                                                            |    no    |
| <a name="input_server_side_encryption_enabled"></a> [server_side_encryption_enabled](#input_server_side_encryption_enabled)             | Whether or not to enable encryption at rest using an AWS managed KMS customer master key (CMK)                                                                                                                                                                                               | `bool`              | `false`                                                                         |    no    |
| <a name="input_server_side_encryption_kms_key_arn"></a> [server_side_encryption_kms_key_arn](#input_server_side_encryption_kms_key_arn) | The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb.                                                                                                        | `string`            | `null`                                                                          |    no    |
| <a name="input_stream_enabled"></a> [stream_enabled](#input_stream_enabled)                                                             | Indicates whether Streams are to be enabled (true) or disabled (false).                                                                                                                                                                                                                      | `bool`              | `false`                                                                         |    no    |
| <a name="input_stream_view_type"></a> [stream_view_type](#input_stream_view_type)                                                       | When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES.                                                                                                    | `string`            | `null`                                                                          |    no    |
| <a name="input_table_class"></a> [table_class](#input_table_class)                                                                      | The storage class of the table. Valid values are STANDARD and STANDARD_INFREQUENT_ACCESS                                                                                                                                                                                                     | `string`            | `null`                                                                          |    no    |
| <a name="input_team"></a> [team](#input_team)                                                                                           | The squad that owns the resource                                                                                                                                                                                                                                                             | `string`            | n/a                                                                             |   yes    |
| <a name="input_timeouts"></a> [timeouts](#input_timeouts)                                                                               | Updated Terraform resource management timeouts                                                                                                                                                                                                                                               | `map(string)`       | <pre>{<br> "create": "10m",<br> "delete": "10m",<br> "update": "60m"<br>}</pre> |    no    |
| <a name="input_ttl_attribute_name"></a> [ttl_attribute_name](#input_ttl_attribute_name)                                                 | The name of the table attribute to store the TTL timestamp in                                                                                                                                                                                                                                | `string`            | `""`                                                                            |    no    |
| <a name="input_ttl_enabled"></a> [ttl_enabled](#input_ttl_enabled)                                                                      | Indicates whether ttl is enabled                                                                                                                                                                                                                                                             | `bool`              | `false`                                                                         |    no    |
| <a name="input_write_capacity"></a> [write_capacity](#input_write_capacity)                                                             | The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0                                                                                                                                                                            | `number`            | `null`                                                                          |    no    |

## Outputs

| Name                                                                                      | Description               |
| ----------------------------------------------------------------------------------------- | ------------------------- |
| <a name="output_dynamodb_table_arn"></a> [dynamodb_table_arn](#output_dynamodb_table_arn) | ARN of the DynamoDB table |
| <a name="output_dynamodb_table_id"></a> [dynamodb_table_id](#output_dynamodb_table_id)    | ID of the DynamoDB table  |

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:luizandrends/terraform-modules.git//tags | v1.5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | A map containing additional tags | `map(any)` | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | The application that owns the resource | `string` | n/a | yes |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | List of nested attribute definitions. Only required for hash\_key and range\_key attributes. Each attribute has two properties: name - (Required) The name of the attribute, type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data | `list(map(string))` | `[]` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | Whether or not to enable autoscaling. See note in README about this setting | `bool` | `false` | no |
| <a name="input_aws_object"></a> [aws\_object](#input\_aws\_object) | he resource identifier, ex: ec2, s3, rds, etc... | `string` | n/a | yes |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | Controls how you are billed for read/write throughput and how you manage capacity. The valid values are PROVISIONED or PAY\_PER\_REQUEST | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_create_table"></a> [create\_table](#input\_create\_table) | Controls if DynamoDB table and associated resources are created | `bool` | `true` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Enables deletion protection for table | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The resource's environment | `string` | n/a | yes |
| <a name="input_global_secondary_indexes"></a> [global\_secondary\_indexes](#input\_global\_secondary\_indexes) | Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc. | `any` | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | The attribute to use as the hash (partition) key. Must also be defined as an attribute | `string` | `null` | no |
| <a name="input_import_table"></a> [import\_table](#input\_import\_table) | Configurations for importing s3 data into a new table. | `any` | `{}` | no |
| <a name="input_local_secondary_indexes"></a> [local\_secondary\_indexes](#input\_local\_secondary\_indexes) | Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource. | `any` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource | `string` | n/a | yes |
| <a name="input_point_in_time_recovery_enabled"></a> [point\_in\_time\_recovery\_enabled](#input\_point\_in\_time\_recovery\_enabled) | Whether to enable point-in-time recovery | `bool` | `false` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | The attribute to use as the range (sort) key. Must also be defined as an attribute | `string` | `null` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | The number of read units for this table. If the billing\_mode is PROVISIONED, this field should be greater than 0 | `number` | `null` | no |
| <a name="input_replica_regions"></a> [replica\_regions](#input\_replica\_regions) | Region names for creating replicas for a global DynamoDB table. | `any` | `[]` | no |
| <a name="input_server_side_encryption_enabled"></a> [server\_side\_encryption\_enabled](#input\_server\_side\_encryption\_enabled) | Whether or not to enable encryption at rest using an AWS managed KMS customer master key (CMK) | `bool` | `false` | no |
| <a name="input_server_side_encryption_kms_key_arn"></a> [server\_side\_encryption\_kms\_key\_arn](#input\_server\_side\_encryption\_kms\_key\_arn) | The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb. | `string` | `null` | no |
| <a name="input_stream_enabled"></a> [stream\_enabled](#input\_stream\_enabled) | Indicates whether Streams are to be enabled (true) or disabled (false). | `bool` | `false` | no |
| <a name="input_stream_view_type"></a> [stream\_view\_type](#input\_stream\_view\_type) | When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS\_ONLY, NEW\_IMAGE, OLD\_IMAGE, NEW\_AND\_OLD\_IMAGES. | `string` | `null` | no |
| <a name="input_table_class"></a> [table\_class](#input\_table\_class) | The storage class of the table. Valid values are STANDARD and STANDARD\_INFREQUENT\_ACCESS | `string` | `null` | no |
| <a name="input_team"></a> [team](#input\_team) | The squad that owns the resource | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Updated Terraform resource management timeouts | `map(string)` | <pre>{<br>  "create": "10m",<br>  "delete": "10m",<br>  "update": "60m"<br>}</pre> | no |
| <a name="input_ttl_attribute_name"></a> [ttl\_attribute\_name](#input\_ttl\_attribute\_name) | The name of the table attribute to store the TTL timestamp in | `string` | `""` | no |
| <a name="input_ttl_enabled"></a> [ttl\_enabled](#input\_ttl\_enabled) | Indicates whether ttl is enabled | `bool` | `false` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | The number of write units for this table. If the billing\_mode is PROVISIONED, this field should be greater than 0 | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | ARN of the DynamoDB table |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | ID of the DynamoDB table |
<!-- END_TF_DOCS -->