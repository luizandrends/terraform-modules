variable "create" {
  description = "Whether to create DNS records"
  type        = bool
  default     = true
}

variable "recordsets" {
  description = "List of objects of DNS records"
  type        = any
  default     = []
}

variable "zone_id" {
  description = "ID of DNS zone"
  type        = string
  default     = null
}
