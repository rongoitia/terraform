# -- Backend ----------------------------------------------------------------
terraform {
  required_version = "~> 0.14"

  backend "s3" {
    skip_credentials_validation = true
    bucket                      = "company-terraform-production"
    key                         = "staging/terraform.tfstate"
    region                      = "us-east-2"
  }
}
