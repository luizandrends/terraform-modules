module "ec2_instance" {
  source = "../../"

  ami           = "ami-090fa75af13c156b4"
  instance_type = "t2.micro"
  key_name      = "teste-keypair"
  monitoring    = false

  tags = {
    ManagedBy   = "Terraform"
    Environment = "dev"
    bu          = "tech_cross"
    Name        = "simple_instance"
  }

  volume_tags = {
    ManagedBy   = "Terraform"
    Environment = "dev"
    bu          = "tech_cross"
  }
}
