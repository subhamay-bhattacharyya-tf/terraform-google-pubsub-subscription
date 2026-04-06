variable "environment" { type = string }
variable "project_code" { type = string }
variable "region" {
  type    = string
  default = "us-central1"
}
variable "base_name" { type = string }
variable "topic" { type = string }
variable "message_retention_duration" {
  type    = string
  default = "1209600s"
}
variable "retain_acked_messages" {
  type    = bool
  default = true
}
