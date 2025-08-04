
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "env-name/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
