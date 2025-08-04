variable "env" {}
variable "rds_instance_id" {}
variable "s3_bucket_name" {}
variable "s3_threshold_bytes" {
  default = 1000000000 # 1 GB
}
variable "slack_webhook_url" {
  description = "Slack webhook or Lambda URL"
}
