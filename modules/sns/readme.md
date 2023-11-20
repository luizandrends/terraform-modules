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

| Name                                                                                                                                                   | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)                                            | resource    |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)                          | data source |
| [aws_iam_policy_document.sns_topic_default_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                            | data source |

## Inputs

| Name                                                                                                               | Description                                                                                                                                                                                                                                                                                                                                           | Type        | Default | Required |
| ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | ------- | :------: |
| <a name="input_additional_tags"></a> [additional_tags](#input_additional_tags)                                     | A map containing additional tags                                                                                                                                                                                                                                                                                                                      | `map(any)`  | `{}`    |    no    |
| <a name="input_application"></a> [application](#input_application)                                                 | The application that owns the resource                                                                                                                                                                                                                                                                                                                | `string`    | n/a     |   yes    |
| <a name="input_aws_object"></a> [aws_object](#input_aws_object)                                                    | he resource identifier, ex: ec2, s3, rds, etc...                                                                                                                                                                                                                                                                                                      | `string`    | n/a     |   yes    |
| <a name="input_content_based_deduplication"></a> [content_based_deduplication](#input_content_based_deduplication) | Boolean indicating whether or not to enable content-based deduplication for FIFO topics.                                                                                                                                                                                                                                                              | `bool`      | `false` |    no    |
| <a name="input_create_topic"></a> [create_topic](#input_create_topic)                                              | Determines whether resources will be created (affects all resources)                                                                                                                                                                                                                                                                                  | `bool`      | `true`  |    no    |
| <a name="input_delivery_policy"></a> [delivery_policy](#input_delivery_policy)                                     | The SNS delivery policy                                                                                                                                                                                                                                                                                                                               | `string`    | `null`  |    no    |
| <a name="input_enable_default_topic_policy"></a> [enable_default_topic_policy](#input_enable_default_topic_policy) | Specifies whether to enable the default topic policy. Defaults to `true`                                                                                                                                                                                                                                                                              | `bool`      | `true`  |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                                                 | The resource's environment                                                                                                                                                                                                                                                                                                                            | `string`    | n/a     |   yes    |
| <a name="input_fifo_topic"></a> [fifo_topic](#input_fifo_topic)                                                    | Boolean indicating whether or not to create a FIFO (first-in-first-out) topic                                                                                                                                                                                                                                                                         | `bool`      | `false` |    no    |
| <a name="input_kms_master_key_id"></a> [kms_master_key_id](#input_kms_master_key_id)                               | The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK                                                                                                                                                                                                                                                                     | `string`    | `null`  |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                      | The name of the resource                                                                                                                                                                                                                                                                                                                              | `string`    | n/a     |   yes    |
| <a name="input_policy"></a> [policy](#input_policy)                                                                | The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws_iam_policy_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. Note: Bucket policies are limited to 20 KB in size. | `list(any)` | `[]`    |    no    |
| <a name="input_team"></a> [team](#input_team)                                                                      | The squad that owns the resource                                                                                                                                                                                                                                                                                                                      | `string`    | n/a     |   yes    |
| <a name="input_tracing_config"></a> [tracing_config](#input_tracing_config)                                        | Tracing mode of an Amazon SNS topic. Valid values: PassThrough, Active.                                                                                                                                                                                                                                                                               | `string`    | `null`  |    no    |

## Outputs

| Name                                                                 | Description                                                        |
| -------------------------------------------------------------------- | ------------------------------------------------------------------ |
| <a name="output_topic_arn"></a> [topic_arn](#output_topic_arn)       | The ARN of the SNS topic, as a more obvious property (clone of id) |
| <a name="output_topic_id"></a> [topic_id](#output_topic_id)          | The ARN of the SNS topic                                           |
| <a name="output_topic_name"></a> [topic_name](#output_topic_name)    | The name of the topic                                              |
| <a name="output_topic_owner"></a> [topic_owner](#output_topic_owner) | The AWS Account ID of the SNS topic owner                          |

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
| <a name="module_tags"></a> [tags](#module\_tags) | git@github.com:luizandrends/terraform-modules.git//modules/tags | v1.9.0 |

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.sns_topic_default_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | A map containing additional tags | `map(any)` | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | The application that owns the resource | `string` | n/a | yes |
| <a name="input_aws_object"></a> [aws\_object](#input\_aws\_object) | he resource identifier, ex: ec2, s3, rds, etc... | `string` | n/a | yes |
| <a name="input_content_based_deduplication"></a> [content\_based\_deduplication](#input\_content\_based\_deduplication) | Boolean indicating whether or not to enable content-based deduplication for FIFO topics. | `bool` | `false` | no |
| <a name="input_create_topic"></a> [create\_topic](#input\_create\_topic) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_delivery_policy"></a> [delivery\_policy](#input\_delivery\_policy) | The SNS delivery policy | `string` | `null` | no |
| <a name="input_enable_default_topic_policy"></a> [enable\_default\_topic\_policy](#input\_enable\_default\_topic\_policy) | Specifies whether to enable the default topic policy. Defaults to `true` | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The resource's environment | `string` | n/a | yes |
| <a name="input_fifo_topic"></a> [fifo\_topic](#input\_fifo\_topic) | Boolean indicating whether or not to create a FIFO (first-in-first-out) topic | `bool` | `false` | no |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws\_iam\_policy\_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. Note: Bucket policies are limited to 20 KB in size. | `list(any)` | `[]` | no |
| <a name="input_team"></a> [team](#input\_team) | The squad that owns the resource | `string` | n/a | yes |
| <a name="input_test_docs"></a> [test\_docs](#input\_test\_docs) | The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws\_iam\_policy\_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. Note: Bucket policies are limited to 20 KB in size. | `list(any)` | `[]` | no |
| <a name="input_tracing_config"></a> [tracing\_config](#input\_tracing\_config) | Tracing mode of an Amazon SNS topic. Valid values: PassThrough, Active. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topic_arn"></a> [topic\_arn](#output\_topic\_arn) | The ARN of the SNS topic, as a more obvious property (clone of id) |
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | The ARN of the SNS topic |
| <a name="output_topic_name"></a> [topic\_name](#output\_topic\_name) | The name of the topic |
| <a name="output_topic_owner"></a> [topic\_owner](#output\_topic\_owner) | The AWS Account ID of the SNS topic owner |
<!-- END_TF_DOCS -->