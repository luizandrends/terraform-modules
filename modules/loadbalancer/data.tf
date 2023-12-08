data "aws_partition" "current" {}

data "aws_vpc" "services_vpc" {
  tags = {
    services_vpc = "true"
  }
}

data "aws_subnets" "services_subnet" {
  filter {
    name   = "tag:private_subnet"
    values = ["false"]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}
