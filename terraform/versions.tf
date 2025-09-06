terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: Remote state backend
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "anniversary-app/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Project   = "Anniversary Countdown"
      Environment = "production"
      ManagedBy = "Terraform"
      Application = "anniversary-app"
    }
  }
}
