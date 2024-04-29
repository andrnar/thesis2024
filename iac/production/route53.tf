resource "aws_route53_record" "cloudfront_alias" {
  zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
  name    = "tootmiskeskkond.narisa.ee"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "primary" {
  name = "narisa.ee"
}

resource "aws_route53_record" "production" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "tootmiskeskkond.narisa.ee"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.primary.name_servers
}

resource "aws_route53_zone" "production_subdomain" {
  name = "tootmiskeskkond.narisa.ee"
}

resource "aws_route53_record" "production_subdomain_acm" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.production_subdomain.zone_id
}