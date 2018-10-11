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
# DATA
##################################################################################

##################################################################################
# RESOURCES
##################################################################################

# S3 Bucket config for K8s state store
module "bucket" {
  name = "${var.bucket_name}"

  source = "./modules/storage"

  tags = {
    BillingCode = "${var.billing_code_tag}"
    Environment = "${var.environment_tag}"
  }
}
