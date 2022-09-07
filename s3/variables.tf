variable "name" {
  type        = string
  description = "Bucket Name"
}

variable "acl" {
  type        = string
  description = "ACL of bucket"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = ""
}

variable "logging_target_bucket" {
  type        = string
  default     = null
  description = "The Bucket for logs."
}

variable "logging_target_prefix" {
  type        = string
  default     = null
  description = "The Prefix for Bucket logs."
}

variable "versioning_enabled" {
  type        = bool
  default     = false
  description = "Enable Version"
}

variable "lifecycle_rule" {
  type        = any
  default     = []
  description = "List of configurations about lifecycle rules"
}

variable "cors_rules" {
  type        = any
  default     = []
  description = "List of rules of Cross-Origin Resource Sharing"
}

variable "replication_configuration" {
  type        = list(any)
  default     = []
  description = "List of replication configuration."
}
