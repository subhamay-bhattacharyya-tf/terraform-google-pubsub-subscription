variable "environment" { type = string }
variable "project_code" { type = string }
variable "region" {
  type    = string
  default = "us-central1"
}
variable "base_name" { type = string }
variable "topic" { type = string }
variable "location" {
  type    = string
  default = "us-central1"
}
variable "ack_deadline_seconds" {
  type    = number
  default = 30
}
variable "message_retention_duration" {
  type    = string
  default = "1209600s"
}
variable "retain_acked_messages" {
  type    = bool
  default = true
}
variable "filter" {
  type    = string
  default = null
}
variable "enable_message_ordering" {
  type    = bool
  default = false
}
variable "labels" {
  type    = map(string)
  default = {}
}
variable "dead_letter_topic" { type = string }
variable "max_delivery_attempts" {
  type    = number
  default = 5
}
variable "expiration_ttl" {
  type    = string
  default = "2678400s"
}
