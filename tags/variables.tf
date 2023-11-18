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

variable "test" {
  type        = string
  description = "The name of the resource"
}
