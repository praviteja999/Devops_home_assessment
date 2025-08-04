
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name for EC2"
  type        = string
  sensitive   = true
}

variable "db_user" {
  type        = string
  description = "RDS database username"
  sensitive   = true
}

variable "db_pass" {
  type        = string
  description = "RDS database password"
  sensitive   = true
}
