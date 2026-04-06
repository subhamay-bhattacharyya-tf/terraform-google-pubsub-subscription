module "pubsub_subscription" {
  source = "../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  pubsub_subscription_config = {
    base_name                  = var.base_name
    topic                      = var.topic
    location                   = var.location
    ack_deadline_seconds       = var.ack_deadline_seconds
    message_retention_duration = var.message_retention_duration
    retain_acked_messages      = var.retain_acked_messages
    filter                     = var.filter
    enable_message_ordering    = var.enable_message_ordering
    labels                     = var.labels
    dead_letter_policy = {
      dead_letter_topic     = var.dead_letter_topic
      max_delivery_attempts = var.max_delivery_attempts
    }
    expiration_policy = {
      ttl = var.expiration_ttl
    }
  }
}
