## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                        | Type        |
| ----------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name                                                               | Description                                      | Type     | Default | Required |
| ------------------------------------------------------------------ | ------------------------------------------------ | -------- | ------- | :------: |
| <a name="input_application"></a> [application](#input_application) | The application that owns the resource           | `string` | n/a     |   yes    |
| <a name="input_aws_object"></a> [aws_object](#input_aws_object)    | he resource identifier, ex: ec2, s3, rds, etc... | `string` | n/a     |   yes    |
| <a name="input_environment"></a> [environment](#input_environment) | The resource's environment                       | `string` | n/a     |   yes    |
| <a name="input_name"></a> [name](#input_name)                      | The name of the resource                         | `string` | n/a     |   yes    |
| <a name="input_team"></a> [team](#input_team)                      | The squad that owns the resource                 | `string` | n/a     |   yes    |

## Outputs

| Name                                                                    | Description                                |
| ----------------------------------------------------------------------- | ------------------------------------------ |
| <a name="output_default_name"></a> [default_name](#output_default_name) | Represents the resource's parsed name      |
| <a name="output_default_tags"></a> [default_tags](#output_default_tags) | Represents all the tags within the project |
