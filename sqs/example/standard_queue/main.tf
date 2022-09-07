module "sqs" {
  source = "../../"

  name       = "standard-queue"

  policy         = file("./files/policy.json")
  # redrive_policy = file("./files/redrive_policy.json")

  fifo_queue = false

  tags = {
    "ManagedBy" = "Terraform"
  }
}
