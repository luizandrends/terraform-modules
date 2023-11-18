remote_state {
  backend = "s3"
  config = {
    bucket         = "library-sandbox-tests-state-bucket"
    dynamodb_table = "library-sandbox-tests-state-table"
    key            = "tags-example/${path_relative_to_include()}"
    region         = "us-east-1"
    encrypt        = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}