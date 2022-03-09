provider "aws" {
  version = "~> 2.23"
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = "dataingestion-tfstate"
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "dataingestion-state-lock-dynamo"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

