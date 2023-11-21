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
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "enable_xray_tracing" {
  description = "Determines whether xray tracing will be enabled"
  type        = bool
  default     = false
}

variable "handler" {
  description = "Lambda Function entrypoint in your code"
  type        = string
  default     = ""
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments."
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 3
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = ""
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda Function. A value of 0 disables Lambda Function from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1."
  type        = number
  default     = -1
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "filename" {
  description = "Path to the function's deployment package within the local filesystem. Exactly one of filename, image_uri, or s3_bucket must be specified."
  type        = string
  default     = null
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  type        = number
  default     = 3
}

variable "cloudwatch_logs_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data."
  type        = string
  default     = null
}

variable "lambda_permissions" {
  description = "Map of Lambda permissions"
  type        = list(any)
  default     = []
}

variable "policy" {
  description = "Map of allowed triggers to create Lambda permissions"
  type        = any
  default     = []
}

variable "event_source_list" {
  description = "Map of allowed event_source_list"
  type        = list(any)
  default     = []
}
