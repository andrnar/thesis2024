terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.46.0"
    }
  }
}

provider "aws" {
  region  = "eu-north-1"
  shared_credentials_files = ["../../terraform_c/creds"]
  profile = "testing"
}







