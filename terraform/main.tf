terraform {
  required_version = ">= 1.0"
  
  # Uncomment below to use S3 backend for remote state storage
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "anniversary-countdown/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

# AWS Provider for us-east-1 (required for ACM certificates used with CloudFront)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

# Data sources for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC and Networking
module "networking" {
  source = "./modules/networking"
  
  app_name          = var.app_name
  environment       = var.environment
  availability_zone = data.aws_availability_zones.available.names[0]
}

# ECS Cluster and Service (Direct Fargate)
module "ecs" {
  source = "./modules/ecs"
  
  app_name       = var.app_name
  environment    = var.environment
  vpc_id         = module.networking.vpc_id
  subnet_ids     = [module.networking.public_subnet_id]
  
  container_image = var.container_image
  fargate_cpu     = var.fargate_cpu
  fargate_memory  = var.fargate_memory
  desired_count   = var.desired_count
}

# CloudFront and SSL Certificate
module "cloudfront" {
  source = "./modules/cloudfront"
  
  domain_name = var.domain_name
  environment = var.environment
  
  providers = {
    aws.us_east_1 = aws.us_east_1
  }
}

# Route53 DNS
module "route53" {
  source = "./modules/route53"
  
  domain_name           = var.domain_name
  environment           = var.environment
  cloudfront_domain     = module.cloudfront.cloudfront_domain_name
  cloudfront_zone_id    = module.cloudfront.cloudfront_zone_id
}
