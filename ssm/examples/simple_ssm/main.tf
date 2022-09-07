module "secret" {
  source = "../../"

  name          = "default-secret-test"
  secret_string = "Example Secret 2"

  recovery_window_in_days = 7

  tags = {
    "ManagedBy" : "Terraform"
  }
}
