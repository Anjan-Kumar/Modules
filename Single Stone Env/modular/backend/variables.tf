##################################################################################
# VARIABLES
##################################################################################
variable "region" {
  default = "us-east-1"
}

variable "aws_application_bucket" {
  default = "terraform-poc-state"
}

variable "aws_dynamodb_table" {
  default = "k8s-tfstatelock"
}


variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}
