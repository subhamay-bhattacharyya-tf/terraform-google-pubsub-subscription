variable "environment" { type = string }
variable "project_code" { type = string }
variable "region" {
  type    = string
  default = "us-central1"
}
variable "base_name" { type = string }
variable "topic" { type = string }
variable "dead_letter_topic" { type = string }
variable "max_delivery_attempts" {
  type    = number
  default = 5
}
