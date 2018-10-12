provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-2"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform_S3_Sample_bucket"
  acl    = "private"

  tags {
    Name        = "terraform-poc"
    Environment = "Dev"
  }
}