provider "aws" {
  access_key = "AKIAICQX25RZ33KASBGA"
  secret_key = "R066uWWTiblpH9Xa+pkxXd7lyzCxlcd3GObWi9jt"
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