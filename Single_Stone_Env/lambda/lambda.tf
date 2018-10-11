provider "aws" {
  access_key = "AKIAICQX25RZ33KASBGA"
  secret_key = "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"
  region = "us-east-2"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "terraform_lambda_exec_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "demo_lambda" {
    function_name = "terraform-poc-arlo"
    handler = "index.handler"
    runtime = "nodejs6.10"
    filename = "function.zip"
    source_code_hash = "${base64sha256(file("function.zip"))}"
    role = "${aws_iam_role.lambda_exec_role.arn}"
}