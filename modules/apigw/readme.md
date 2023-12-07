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
| [aws_apigatewayv2_api.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_api_mapping.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping) | resource |
| [aws_apigatewayv2_domain_name.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name) | resource |
| [aws_apigatewayv2_integration.lambda_integrations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_integration.lb_integrations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.lambda_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_route.lb_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_stage.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |
| [aws_lambda_permission.allow_api_gw_trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | A map containing additional tags | `map(any)` | `{}` | no |
| <a name="input_api_key_selection_expression"></a> [api\_key\_selection\_expression](#input\_api\_key\_selection\_expression) | An API key selection expression. Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key. | `string` | `"$request.header.x-api-key"` | no |
| <a name="input_api_version"></a> [api\_version](#input\_api\_version) | A version identifier for the API | `string` | `null` | no |
| <a name="input_application"></a> [application](#input\_application) | The application that owns the resource | `string` | n/a | yes |
| <a name="input_body"></a> [body](#input\_body) | An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs. | `string` | `null` | no |
| <a name="input_cors_configuration"></a> [cors\_configuration](#input\_cors\_configuration) | The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs. | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if API Gateway resources should be created | `bool` | `true` | no |
| <a name="input_credentials_arn"></a> [credentials\_arn](#input\_credentials\_arn) | Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs. | `string` | `null` | no |
| <a name="input_default_route_settings"></a> [default\_route\_settings](#input\_default\_route\_settings) | Settings for default route | `map(string)` | `{}` | no |
| <a name="input_default_stage_access_log_destination_arn"></a> [default\_stage\_access\_log\_destination\_arn](#input\_default\_stage\_access\_log\_destination\_arn) | Default stage's ARN of the CloudWatch Logs log group to receive access logs. Any trailing :* is trimmed from the ARN. | `string` | `null` | no |
| <a name="input_default_stage_access_log_format"></a> [default\_stage\_access\_log\_format](#input\_default\_stage\_access\_log\_format) | Default stage's single line format of the access logs of data, as specified by selected $context variables. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the API. | `string` | `null` | no |
| <a name="input_disable_execute_api_endpoint"></a> [disable\_execute\_api\_endpoint](#input\_disable\_execute\_api\_endpoint) | Whether clients can invoke the API by using the default execute-api endpoint. To require that clients use a custom domain name to invoke the API, disable the default endpoint | `string` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name to use for API gateway | `string` | `null` | no |
| <a name="input_domain_name_certificate_arn"></a> [domain\_name\_certificate\_arn](#input\_domain\_name\_certificate\_arn) | The ARN of an AWS-managed certificate that will be used by the endpoint for the domain name | `string` | `null` | no |
| <a name="input_domain_name_ownership_verification_certificate_arn"></a> [domain\_name\_ownership\_verification\_certificate\_arn](#input\_domain\_name\_ownership\_verification\_certificate\_arn) | ARN of the AWS-issued certificate used to validate custom domain ownership (when certificate\_arn is issued via an ACM Private CA or mutual\_tls\_authentication is configured with an ACM-imported certificate.) | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The resource's environment | `string` | n/a | yes |
| <a name="input_integrations"></a> [integrations](#input\_integrations) | Map of API gateway routes with integrations | `map(any)` | `{}` | no |
| <a name="input_lambda_integrations"></a> [lambda\_integrations](#input\_lambda\_integrations) | Map of API gateway lambda routes with integrations | `map(any)` | `{}` | no |
| <a name="input_lb_integrations"></a> [lb\_integrations](#input\_lb\_integrations) | Map of API gateway LB routes with integrations | `map(any)` | `{}` | no |
| <a name="input_mutual_tls_authentication"></a> [mutual\_tls\_authentication](#input\_mutual\_tls\_authentication) | An Amazon S3 URL that specifies the truststore for mutual TLS authentication as well as version, keyed at uri and version | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource | `string` | n/a | yes |
| <a name="input_protocol_type"></a> [protocol\_type](#input\_protocol\_type) | The API protocol. Valid values: HTTP, WEBSOCKET | `string` | `"HTTP"` | no |
| <a name="input_route_key"></a> [route\_key](#input\_route\_key) | Part of quick create. Specifies any route key. Applicable for HTTP APIs. | `string` | `null` | no |
| <a name="input_route_selection_expression"></a> [route\_selection\_expression](#input\_route\_selection\_expression) | The route selection expression for the API. | `string` | `"$request.method $request.path"` | no |
| <a name="input_stepfunctions_integrations"></a> [stepfunctions\_integrations](#input\_stepfunctions\_integrations) | Map of API gateway step function routes with integrations | `map(any)` | `{}` | no |
| <a name="input_target"></a> [target](#input\_target) | Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP\_PROXY or AWS\_PROXY, respectively. Applicable for HTTP APIs. | `string` | `null` | no |
| <a name="input_team"></a> [team](#input\_team) | The squad that owns the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apigatewayv2_api_api_endpoint"></a> [apigatewayv2\_api\_api\_endpoint](#output\_apigatewayv2\_api\_api\_endpoint) | The URI of the API |
| <a name="output_apigatewayv2_api_arn"></a> [apigatewayv2\_api\_arn](#output\_apigatewayv2\_api\_arn) | The ARN of the API |
| <a name="output_apigatewayv2_api_execution_arn"></a> [apigatewayv2\_api\_execution\_arn](#output\_apigatewayv2\_api\_execution\_arn) | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| <a name="output_apigatewayv2_api_id"></a> [apigatewayv2\_api\_id](#output\_apigatewayv2\_api\_id) | The API identifier |
| <a name="output_apigatewayv2_api_mapping_id"></a> [apigatewayv2\_api\_mapping\_id](#output\_apigatewayv2\_api\_mapping\_id) | The API mapping identifier. |
| <a name="output_apigatewayv2_domain_name_api_mapping_selection_expression"></a> [apigatewayv2\_domain\_name\_api\_mapping\_selection\_expression](#output\_apigatewayv2\_domain\_name\_api\_mapping\_selection\_expression) | The API mapping selection expression for the domain name |
| <a name="output_apigatewayv2_domain_name_arn"></a> [apigatewayv2\_domain\_name\_arn](#output\_apigatewayv2\_domain\_name\_arn) | The ARN of the domain name |
| <a name="output_apigatewayv2_domain_name_configuration"></a> [apigatewayv2\_domain\_name\_configuration](#output\_apigatewayv2\_domain\_name\_configuration) | The domain name configuration |
| <a name="output_apigatewayv2_domain_name_hosted_zone_id"></a> [apigatewayv2\_domain\_name\_hosted\_zone\_id](#output\_apigatewayv2\_domain\_name\_hosted\_zone\_id) | The Amazon Route 53 Hosted Zone ID of the endpoint |
| <a name="output_apigatewayv2_domain_name_id"></a> [apigatewayv2\_domain\_name\_id](#output\_apigatewayv2\_domain\_name\_id) | The domain name identifier |
| <a name="output_apigatewayv2_domain_name_target_domain_name"></a> [apigatewayv2\_domain\_name\_target\_domain\_name](#output\_apigatewayv2\_domain\_name\_target\_domain\_name) | The target domain name |
| <a name="output_default_apigatewayv2_stage_arn"></a> [default\_apigatewayv2\_stage\_arn](#output\_default\_apigatewayv2\_stage\_arn) | The default stage ARN |
| <a name="output_default_apigatewayv2_stage_domain_name"></a> [default\_apigatewayv2\_stage\_domain\_name](#output\_default\_apigatewayv2\_stage\_domain\_name) | Domain name of the stage (useful for CloudFront distribution) |
| <a name="output_default_apigatewayv2_stage_execution_arn"></a> [default\_apigatewayv2\_stage\_execution\_arn](#output\_default\_apigatewayv2\_stage\_execution\_arn) | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| <a name="output_default_apigatewayv2_stage_id"></a> [default\_apigatewayv2\_stage\_id](#output\_default\_apigatewayv2\_stage\_id) | The default stage identifier |
| <a name="output_default_apigatewayv2_stage_invoke_url"></a> [default\_apigatewayv2\_stage\_invoke\_url](#output\_default\_apigatewayv2\_stage\_invoke\_url) | The URL to invoke the API pointing to the stage |
<!-- END_TF_DOCS -->