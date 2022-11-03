terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.6.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region  = "us-west-2"
}
