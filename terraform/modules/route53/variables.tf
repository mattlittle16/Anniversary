variable "domain_name" {
  description = "Domain name for the application"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cloudfront_domain" {
  description = "Domain name of the CloudFront distribution"
  type        = string
}

variable "cloudfront_zone_id" {
  description = "Zone ID of the CloudFront distribution"
  type        = string
}
