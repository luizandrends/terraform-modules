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

variable "aws_object" {
  type        = string
  description = "he resource identifier, ex: ec2, s3, rds, etc..."
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
  description = "Whether to create SQS queue"
  type        = bool
  default     = true
}

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = false
}

variable "create_dlq" {
  description = "Whether to create SQS DLQ"
  type        = bool
  default     = false
}

variable "max_receive_count" {
  type        = number
  default     = 5
  description = "For most standard queues (depending on queue traffic and message backlog), there can be a maximum of approximately 120,000 in flight messages"
}

variable "redrive_policy" {
  type        = string
  default     = ""
  description = "The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ('5')."
}

variable "dlq_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "dlq_sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys"
  type        = bool
  default     = true
}

variable "sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys"
  type        = bool
  default     = true
}

variable "dlq_content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = null
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = null
}

variable "dlq_deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level"
  type        = string
  default     = null
}

variable "deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level"
  type        = string
  default     = null
}

variable "dlq_delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)"
  type        = number
  default     = null
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)"
  type        = number
  default     = null
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group"
  type        = string
  default     = null
}

variable "dlq_kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours)"
  type        = number
  default     = null
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
  type        = number
  default     = null
}

variable "dlq_message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = number
  default     = null
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = number
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours)"
  type        = number
  default     = null
}

variable "dlq_receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
  type        = number
  default     = null
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
  type        = number
  default     = null
}

variable "dlq_visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
  type        = number
  default     = null
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
  type        = number
  default     = null
}

variable "policy" {
  type        = list(any)
  default     = []
  description = "The text of the policy. Although this is a bucket policy rather than an IAM policy, the aws_iam_policy_document data source may be used, so long as it specifies a principal. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. Note: Bucket policies are limited to 20 KB in size."
}

variable "subscriptions" {
  description = "A map of subscription definitions to create"
  type        = any
  default     = {}
}

variable "testingworkflow" {
  description = "A map of subscription definitions to create"
  type        = any
  default     = {}
}
