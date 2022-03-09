provider "aws" {
  region = var.aws_region
  version = "~> 2.23"
}

terraform {
  backend "s3"  {
    encrypt = "true"
    bucket = "dataingestion-tfstate"
    dynamodb_table = "dataingestion-state-lock-dynamo"
    region = "us-east-1"
    key = "kinesis-delivery-stream"
  }
}