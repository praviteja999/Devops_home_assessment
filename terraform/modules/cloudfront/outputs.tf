output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.app_cdn.id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name"
  value       = aws_cloudfront_distribution.app_cdn.domain_name
}

output "waf_web_acl_arn" {
  description = "WAF Web ACL ARN"
  value       = aws_wafv2_web_acl.cloudfront_acl.arn
}

output "cloudfront_waf_association_id" {
  description = "WAF association ID"
  value       = aws_wafv2_web_acl_association.cloudfront_waf_assoc.id
}
