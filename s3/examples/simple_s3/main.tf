module "s3" {
  source = "../../"

  name = "simple-s3-teste"
  acl  = "private"

  tags = {
    "ManagedBy" = "Terraform"
  }
}
