variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "s3_bucket_domain" {
  description = "S3 bucket regional domain name"
  type        = string
}

variable "alb_dns" {
  description = "DNS name of the ALB"
  type        = string
}
