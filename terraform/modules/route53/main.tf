# Get existing hosted zone
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

# A record pointing to CloudFront
resource "aws_route53_record" "main" {
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.main.zone_id
  name            = var.domain_name
  type            = "A"

  alias {
    name                   = var.cloudfront_domain
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}
