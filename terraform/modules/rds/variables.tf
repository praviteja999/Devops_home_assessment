
variable "env"     { type = string }
variable "db_user" {
  type      = string
  sensitive = true
}
variable "db_pass" {
  type      = string
  sensitive = true
}
variable "subnet_ids" {
  type = list(string)
}
