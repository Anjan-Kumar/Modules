##################################################################################
# OUTPUT
##################################################################################

output "tfstate_bucket" {
  value = "${aws_s3_bucket.tfstate_bucket.bucket}"
}

output "terraform_statelock" {
  value = "${aws_dynamodb_table.terraform_statelock.id}"
}
