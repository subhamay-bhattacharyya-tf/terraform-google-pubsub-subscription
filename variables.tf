# =============================================================================
# Pub/Sub Subscription Module - Variables
# =============================================================================

variable "environment" {
  description = "Deployment environment. One of: devl, test, prod."
  type        = string

  validation {
    condition     = contains(["devl", "test", "prod"], var.environment)
    error_message = "environment must be one of: devl, test, prod."
  }
}

variable "project_code" {
  description = "Short identifier used in resource naming standardization."
  type        = string

  validation {
    condition     = length(var.project_code) > 0
    error_message = "project_code must not be empty."
  }
}

variable "region" {
  description = "GCP region for the provider."
  type        = string
  default     = "us-central1"
}

variable "pubsub_subscription_config" {
  description = "Configuration for the Google Pub/Sub subscription resource."
  type = object({
    base_name                  = string
    topic                      = string
    location                   = optional(string, "us-central1")
    ack_deadline_seconds       = optional(number, 10)
    message_retention_duration = optional(string, "604800s")
    retain_acked_messages      = optional(bool, false)
    filter                     = optional(string, null)
    enable_message_ordering    = optional(bool, false)
    labels                     = optional(map(string), {})
    dead_letter_policy = optional(object({
      dead_letter_topic     = string
      max_delivery_attempts = optional(number, 5)
    }), null)
    expiration_policy = optional(object({
      ttl = string
    }), null)
  })

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.pubsub_subscription_config.base_name)) && length(var.pubsub_subscription_config.base_name) <= 30
    error_message = "base_name must contain only alphanumeric characters or dashes, and be at most 30 characters."
  }

  validation {
    condition     = var.pubsub_subscription_config.ack_deadline_seconds >= 10 && var.pubsub_subscription_config.ack_deadline_seconds <= 600
    error_message = "ack_deadline_seconds must be between 10 and 600."
  }
}
