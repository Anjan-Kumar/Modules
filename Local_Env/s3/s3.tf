provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-poc-arlo"
  acl    = "private"

  tags {
    Name        = "terraform-poc"
    Environment = "Dev"
  }
}