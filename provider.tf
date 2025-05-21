terraform {
  backend "s3" {
    bucket = "abra-terraform-states"
    key    = "kubernetes/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
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
  region = "us-east-1"
}
