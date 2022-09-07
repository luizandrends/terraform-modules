module "sqs" {
  source = "../../"

  name       = "fifo-queue.fifo"

  policy         = file("./files/policy.json")
  redrive_policy = file("./files/redrive_policy.json")

  fifo_queue = true

  tags = {
    "ManagedBy" = "Terraform"
  }
}
