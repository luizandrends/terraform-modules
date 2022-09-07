variable "environment" {
  type        = string
  description = ""
}

variable "application" {
  type        = string
  default     = ""
  description = ""
}

variable "resource" {
  type        = string
  default     = ""
  description = ""
}

variable "custom_tags" {
  type        = map(any)
  default     = {}
  description = ""
}

variable "name" {
  type        = string
  default     = null
  description = ""
}

variable "team" {
  type        = string
  default     = "null"
  description = ""
}
