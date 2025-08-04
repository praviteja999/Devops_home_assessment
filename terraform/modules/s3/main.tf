
resource "aws_s3_bucket" "storage" {
  bucket = "myapp-${var.env}-bucket"

  tags = {
    Environment = var.env
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.storage.id

  rule {
    id = "cleanup-old-versions"
    status = "Enabled"
    noncurrent_version_expiration {
      days = 30
    }
  }
}
