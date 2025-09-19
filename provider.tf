terraform {
  backend "s3" {
    /* Multiple environments will be used, each with backend.tfvars file from the `environments` dir,
     so no need to hard code it here.
    bucket       = "abra-terraform-states"
    key          = "kubernetes/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
    */
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  #shared_config_files      = ["~/.aws/config"]
  #shared_credentials_files = ["~/.aws/credentials"]
  #profile                  = "default"
}