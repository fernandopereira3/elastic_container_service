terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.1"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}