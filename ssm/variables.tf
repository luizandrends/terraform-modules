variable "name" {
  type        = string
  default     = null
  description = "Secret name."
}

variable "description" {
  type        = string
  default     = null
  description = "Secret description."
}

variable "recovery_window_in_days" {
  type        = number
  default     = 0
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Resource tags."
}

variable "secret_string" {
  type        = string
  default     = null
  description = "Simple string to store on Secret."
}

variable "policy" {
  type        = string
  default     = null
  description = "The JSON policy for the Secret."
}
