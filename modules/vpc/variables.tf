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

variable "private_subnet_additional_tags" {
  type        = map(any)
  default     = {}
  description = "A map containing private subnet additional tags"
}

variable "public_subnet_additional_tags" {
  type        = map(any)
  default     = {}
  description = "A map containing private subnet additional tags"
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ipv4_netmask_length" {
  description = "(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4_ipam_pool_id"
  type        = number
  default     = null
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "default_security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
  type        = list(map(string))
  default     = []
}

variable "default_security_group_egress" {
  description = "List of maps of egress rules to set on the default security group"
  type        = list(map(string))
  default     = []
}

variable "private_subnets" {
  description = "List of maps of VPC's subnets to associate"
  type        = list(map(string))
  default     = []
}

variable "public_subnets" {
  description = "List of maps of VPC's subnets to associate"
  type        = list(map(string))
  default     = []
}
