resource "aws_route53_zone" "testing" {
  name = "testimiskeskkond.narisa.ee"
}

resource "aws_route53_record" "testing" {
  zone_id = aws_route53_zone.testing.zone_id
  name    = "testimiskeskkond.narisa.ee"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.testing.name_servers
}

resource "aws_route53_record" "testing" {
  zone_id = aws_route53_zone.testing.zone_id
  name    = "*.testimiskeskkond.narisa.ee"
  type    = "CNAME"
  ttl     = "300"
  records = aws_route53_record.testing.name
}