resource "aws_sns_topic" "alerts" {
  name = "${var.env}-alerts-topic"
}

resource "aws_sns_topic_subscription" "slack" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "https"
  endpoint  = var.slack_webhook_url  # Must be a webhook or Lambda endpoint
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu" {
  alarm_name          = "${var.env}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "High CPU on RDS"
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}

resource "aws_cloudwatch_metric_alarm" "s3_bucket_size" {
  alarm_name          = "${var.env}-s3-bucket-size"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "BucketSizeBytes"
  namespace           = "AWS/S3"
  period              = 86400
  statistic           = "Average"
  threshold           = var.s3_threshold_bytes
  dimensions = {
    BucketName = var.s3_bucket_name
    StorageType = "StandardStorage"
  }
  alarm_actions = [aws_sns_topic.alerts.arn]
}
