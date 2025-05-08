terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#configure 
provider "aws" {
  region = "eu-north-1"

}