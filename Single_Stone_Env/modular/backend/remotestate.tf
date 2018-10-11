##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  #shared_credentials_file = "~/.aws/credentials"
  region = "${var.region}"
}

##################################################################################
# RESOURCES
##################################################################################

# DynamoDB Backend
resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "${var.aws_dynamodb_table}"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# S3 Bucket for storing Terraform state
resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "${var.aws_application_bucket}"
  acl    = "private"
  force_destroy = true
  
  versioning {
    enabled = true
  }

      policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::463466179279:user/terraform-admin"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.aws_application_bucket}",
                "arn:aws:s3:::${var.aws_application_bucket}/*"
            ]
        }
    ]
}
EOF
}