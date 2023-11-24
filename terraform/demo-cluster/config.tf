terraform {
  backend "s3" {
    bucket         = "demo-clusters-tf-state-s3-bucket"
    key            = "demo-clusters.tfstate"
    region         = "us-east-2"
    dynamodb_table = "demo-clusters-tf-state-lock-dynamodb"
  }

  required_version = "~> 1.6.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
