variable "environment" {
  type        = string
  description = "The resource's environment"
}

variable "application" {
  type        = string
  description = "The application that owns the resource"
}

variable "team" {
  type        = string
  description = "The squad that owns the resource"
}

variable "name" {
  type        = string
  description = "The name of the resource"
}

variable "additional_tags" {
  type        = map(any)
  default     = {}
  description = "A map containing additional tags"
}

variable "create" {
  description = "Controls if API Gateway resources should be created"
  type        = bool
  default     = true
}

variable "description" {
  description = "The description of the API."
  type        = string
  default     = null
}

variable "protocol_type" {
  description = "The API protocol. Valid values: HTTP, WEBSOCKET"
  type        = string
  default     = "HTTP"
}

variable "api_version" {
  description = "A version identifier for the API"
  type        = string
  default     = null
}

variable "body" {
  description = "An OpenAPI specification that defines the set of routes and integrations to create as part of the HTTP APIs. Supported only for HTTP APIs."
  type        = string
  default     = null
}

variable "route_selection_expression" {
  description = "The route selection expression for the API."
  type        = string
  default     = "$request.method $request.path"
}

variable "api_key_selection_expression" {
  description = "An API key selection expression. Valid values: $context.authorizer.usageIdentifierKey, $request.header.x-api-key."
  type        = string
  default     = "$request.header.x-api-key"
}

variable "disable_execute_api_endpoint" {
  description = "Whether clients can invoke the API by using the default execute-api endpoint. To require that clients use a custom domain name to invoke the API, disable the default endpoint"
  type        = string
  default     = false
}

variable "route_key" {
  description = "Part of quick create. Specifies any route key. Applicable for HTTP APIs."
  type        = string
  default     = null
}

variable "credentials_arn" {
  description = "Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs."
  type        = string
  default     = null
}

variable "target" {
  description = "Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs."
  type        = string
  default     = null
}

variable "cors_configuration" {
  description = "The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs."
  type        = any
  default     = {}
}

variable "domain_name" {
  description = "The domain name to use for API gateway"
  type        = string
  default     = null
}

variable "domain_name_certificate_arn" {
  description = "The ARN of an AWS-managed certificate that will be used by the endpoint for the domain name"
  type        = string
  default     = null
}

variable "domain_name_ownership_verification_certificate_arn" {
  description = "ARN of the AWS-issued certificate used to validate custom domain ownership (when certificate_arn is issued via an ACM Private CA or mutual_tls_authentication is configured with an ACM-imported certificate.)"
  type        = string
  default     = null
}

variable "mutual_tls_authentication" {
  description = "An Amazon S3 URL that specifies the truststore for mutual TLS authentication as well as version, keyed at uri and version"
  type        = map(string)
  default     = {}
}

variable "default_stage_access_log_destination_arn" {
  description = "Default stage's ARN of the CloudWatch Logs log group to receive access logs. Any trailing :* is trimmed from the ARN."
  type        = string
  default     = null
}

variable "default_stage_access_log_format" {
  description = "Default stage's single line format of the access logs of data, as specified by selected $context variables."
  type        = string
  default     = null
}

variable "default_route_settings" {
  description = "Settings for default route"
  type        = map(string)
  default     = {}
}

variable "integrations" {
  description = "Map of API gateway routes with integrations"
  type        = map(any)
  default     = {}
}

variable "lambda_integrations" {
  description = "Map of API gateway lambda routes with integrations"
  type        = map(any)
  default     = {}
}

variable "lb_integrations" {
  description = "Map of API gateway LB routes with integrations"
  type        = map(any)
  default     = {}
}

variable "stepfunctions_integrations" {
  description = "Map of API gateway step function routes with integrations"
  type        = map(any)
  default     = {}
}
