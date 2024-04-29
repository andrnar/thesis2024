resource "aws_acm_certificate" "cert" {
  domain_name       = "tootmiskeskkond.narisa.ee"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.production_subdomain_acm : record.fqdn]
}