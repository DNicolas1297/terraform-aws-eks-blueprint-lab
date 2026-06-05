terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "diego-fullstack-tfstate"
    key            = "laboratorio-eks/terraform.tfstate"
    region         = "us-east-2" # O tu región de preferencia
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}
