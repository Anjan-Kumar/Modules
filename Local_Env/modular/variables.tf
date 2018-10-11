##################################################################################
# VARIABLES
##################################################################################

variable "billing_code_tag" {}
variable "environment_tag" {}
variable "bucket_name" {}
variable "region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}


