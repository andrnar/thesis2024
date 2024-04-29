terraform {
  backend "s3" {
    bucket = "narisa-terraform-state-tootmiskeskkond"
    key    = "state"
    region = "eu-north-1"
    shared_credentials_files = ["../../terraform_c/creds"]
    profile = "production"
  }
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
  profile = "production"
}







