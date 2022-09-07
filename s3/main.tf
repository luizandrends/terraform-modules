resource "aws_s3_bucket" "main" {
  bucket = var.name
  acl    = var.acl
  tags   = var.tags

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule
    content {
      id                                     = lookup(lifecycle_rule.value, "id", null)
      prefix                                 = lookup(lifecycle_rule.value, "prefix", null)
      tags                                   = lookup(lifecycle_rule.value, "tags", null)
      abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", null)
      enabled                                = lifecycle_rule.value.enabled

      dynamic "transition" {
        for_each = lifecycle_rule.value.transitions
        content {
          date          = lookup(transition.value, "date", null)
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }
      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration
        content {
          days                         = expiration.value.days
          date                         = expiration.value.date
          expired_object_delete_marker = expiration.value.expired_object_delete_marker
        }
      }
      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration
        content {
          days = noncurrent_version_expiration.value.days
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transition
        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }
    }
  }

  dynamic "cors_rule" {
    for_each = var.cors_rules
    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }

  dynamic "replication_configuration" {
    for_each = var.replication_configuration
    content {
      role = replication_configuration.value.role
      dynamic "rules" {
        for_each = replication_configuration.value.rules
        content {
          id                               = lookup(rules.value, "id", null)
          priority                         = lookup(rules.value, "priority", null)
          prefix                           = lookup(rules.value, "prefix", null)
          delete_marker_replication_status = lookup(rules.value, "delete_marker_replication_status", null)
          status                           = lookup(rules.value, "status", "Enabled")

          dynamic "destination" {
            for_each = length(keys(lookup(rules.value, "destination", {}))) == 0 ? [] : [lookup(rules.value, "destination", {})]
            content {
              bucket             = destination.value.bucket
              storage_class      = lookup(destination.value, "storage_class", null)
              account_id         = lookup(destination.value, "account_id", null)

              dynamic "access_control_translation" {
                for_each = length(keys(lookup(destination.value, "access_control_translation", {}))) == 0 ? [] : [lookup(destination.value, "access_control_translation", {})]
                content {
                  owner = access_control_translation.value.owner
                }
              }
            }
          }

          dynamic "filter" {
            for_each = length(keys(lookup(rules.value, "filter", {}))) == 0 ? [{}] : []
            content {}
          }

          dynamic "filter" {
            for_each = length(keys(lookup(rules.value, "filter", {}))) != 0 ? [lookup(rules.value, "filter", {})] : []
            content {
              prefix = lookup(filter.value, "prefix", null)
              tags   = lookup(filter.value, "tags", null)
            }
          }
        }
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
