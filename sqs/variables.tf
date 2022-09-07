variable "name" {
  type        = string
  default     = null
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name."
}

variable "name_prefix" {
  type        = string
  default     = null
  description = "Creates a unique name beginning with the specified prefix. Conflicts with name."
}

variable "visibility_timeout_seconds" {
  type        = string
  default     = "30"
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see AWS docs."
}

variable "message_retention_seconds" {
  type        = string
  default     = "345600"
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)."
}

variable "max_message_size" {
  type        = string
  default     = "262144"
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)."
}

variable "delay_seconds" {
  type        = string
  default     = "0"
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds."
}

variable "receive_wait_time_seconds" {
  type        = string
  default     = "0"
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
}

variable "policy" {
  type        = string
  default     = null
  description = "The JSON policy for the SQS queue. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
}

variable "redrive_policy" {
  type        = string
  default     = ""
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
}

variable "fifo_queue" {
  type        = bool
  default     = false
  description = "Boolean designating a FIFO queue. If not set, it defaults to false making it standard."
}

variable "content_based_deduplication" {
  type        = bool
  default     = false
  description = "Enables content-based deduplication for FIFO queues. For more information, see the related documentation"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = ""
}
