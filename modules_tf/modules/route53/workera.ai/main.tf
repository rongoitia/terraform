resource "aws_route53_record" "frontend" {
  zone_id       = "Z08182073PZBCS4Q9WJKF"
  name          = var.frontend_url
  type          = "CNAME"
  ttl           = "60"
  records       = [var.frontend_endpoint]
}

resource "aws_route53_record" "odoo" {
  zone_id       = "Z08182073PZBCS4Q9WJKF"
  name          = var.odoo_url
  type          = "CNAME"
  ttl           = "60"
  records       = [var.odoo_endpoint]
}


resource "aws_route53_record" "backend" {
  zone_id       = "Z08182073PZBCS4Q9WJKF"
  name          = var.backend_url
  type          = "CNAME"
  ttl           = "60"
  records       = [var.backend_endpoint]
}


# resource "aws_route53_record" "matching" {
#   zone_id       = "Z08182073PZBCS4Q9WJKF"
#   name          = var.matching_url
#   type          = "CNAME"
#   ttl           = "60"
#   records       = [var.matching_endpoint]
# }

resource "aws_route53_record" "download" {
  zone_id       = "Z08182073PZBCS4Q9WJKF"
  name          = var.download_url
  type          = "CNAME"
  ttl           = "60"
  records       = [var.download_endpoint]
}

